package test

import (
	"fmt"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/ssh"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/orange-cloudavenue/cloudavenue-sdk-go"
	"github.com/orange-cloudavenue/cloudavenue-sdk-go/v1/edgegateway"
)

func TestCloudavenueNetworkServices(t *testing.T) {
	_, err := cloudavenue.New(&cloudavenue.ClientOpts{})
	if err != nil {
		t.Fatalf("Failed to create cloudavenue client: %v", err)
	}

	sshKeyPair := ssh.GenerateRSAKeyPair(t, 2048)

	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "tf/",

		Vars: map[string]interface{}{
			"ssh_public_key": sshKeyPair.PublicKey,
			"username":       "terratest",
		},
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	publicInstanceIP := terraform.Output(t, terraformOptions, "vm_public_ip")

	publicHost := ssh.Host{
		Hostname:    publicInstanceIP,
		SshUserName: "terratest",
		SshKeyPair:  sshKeyPair,
		CustomPort:  45876,
	}

	retry.DoWithRetry(t, "Try connecting to the VM", 30, 5*time.Second, func() (string, error) {
		actualText, err := ssh.CheckSshCommandE(t, publicHost, "echo -n Connected")

		if err != nil {
			return "", err
		}

		if !strings.Contains(actualText, "Connected") {
			return "", fmt.Errorf("Expected SSH command to return '%s' but got '%s'", "Connected", actualText)
		}

		return "", nil
	})

	maxRetries := 5
	timeBetweenRetries := 5 * time.Second

	var listOfCommands = []struct {
		description string
		command     string
	}{}

	for _, svc := range edgegateway.ListOfServices {
		for _, s := range svc.Services {
			for _, ip := range s.IP {
				for _, port := range s.Ports {
					listOfCommands = append(listOfCommands, struct {
						description string
						command     string
					}{
						description: fmt.Sprintf("Check connectivity to %s:%d", ip, port.Port),
						command: func() string {
							if port.Protocol == "tcp" {
								return fmt.Sprintf("nc -vz -w 1 %s %d", ip, port.Port)
							}

							return fmt.Sprintf("nc -vzu -w 1 %s %d", ip, port.Port)
						}(),
					})
				}
			}
		}
	}

	for _, cmd := range listOfCommands {
		retry.DoWithRetry(t, cmd.description, maxRetries, timeBetweenRetries, func() (string, error) {
			actualText, err := ssh.CheckSshCommandE(t, publicHost, cmd.command)

			if err != nil {
				return "", err
			}

			if !strings.Contains(actualText, "succeeded!") {
				return "", fmt.Errorf("Expected SSH command to return '%s' but got '%s'", "succeeded!", actualText)
			}

			return "", nil
		})
	}

}
