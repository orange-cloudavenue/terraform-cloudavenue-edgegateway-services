# Contributing Guidelines

Thank you for your interest in contributing to our project. Whether it's a bug report, new feature, correction, or additional
documentation, we greatly value feedback and contributions from our community.

Please read through this document before submitting any issues or pull requests to ensure we have all the necessary
information to effectively respond to your bug report or contribution.

## Reporting Bugs/Feature Requests

We welcome you to use the GitHub issue tracker to report bugs or suggest features.

When filing an issue, please check existing open, or recently closed, issues to make sure somebody else hasn't already
reported the issue. Please try to include as much information as you can. Details like these are incredibly useful:

* A reproducible test case or series of steps
* The version of our code being used
* Any modifications you've made relevant to the bug
* Anything unusual about your environment or deployment

## Contributing via Pull Requests

Contributions via pull requests are much appreciated. Before sending us a pull request, please ensure that:

1. You are working against the latest source on the *main* branch.
2. You check existing open, and recently merged, pull requests to make sure someone else hasn't addressed the problem already.
3. You open an issue to discuss any significant work - we would hate for your time to be wasted.

To send us a pull request, please:

1. Fork the repository.
2. Modify the source; please focus on the specific change you are contributing. If you also reformat all the code, it will be hard for us to focus on your change.
3. Ensure local tests pass.
4. Commit to your fork using clear commit messages.
5. Send us a pull request, answering any default questions in the pull request interface.
6. Pay attention to any automated CI failures reported in the pull request, and stay involved in the conversation.

GitHub provides additional document on [forking a repository](https://help.github.com/articles/fork-a-repo/) and
[creating a pull request](https://help.github.com/articles/creating-a-pull-request/).

### Initial Setup

Run pre-commit install to install the pre-commit hooks.

```bash
pre-commit install
```

## Licensing

See the LICENSE file for our project's licensing.

## Changelog format

We use the go-changelog to generate and update the changelog from files created in the .changelog/ directory. It is important that when you raise your Pull Request, there is a changelog entry which describes the changes your contribution makes. Not all changes require an entry in the changelog, guidance follows on what changes do.

The changelog format requires an entry in the following format, where HEADER corresponds to the changelog category, and the entry is the changelog entry itself. The entry should be included in a file in the .changelog directory with the naming convention {PR-NUMBER}.txt. For example, to create a changelog entry for pull request 1234, there should be a file named .changelog/1234.txt.

``````markdown
```release-note:{HEADER}
{ENTRY}
```
``````

## Pull request types to CHANGELOG

The CHANGELOG is intended to show operator-impacting changes to the codebase for a particular version. If every change or commit to the code resulted in an entry, the CHANGELOG would become less useful for operators. The lists below are general guidelines and examples for when a decision needs to be made to decide whether a change should have an entry.

### Changes that should have a CHANGELOG entry

#### Resource and provider bug fixes

A new bug entry should use the `release-note:bug` header and have a prefix indicating the resource or data source it corresponds to, a colon, then followed by a brief summary. Use a `provider` prefix for provider level fixes.

``````markdown
```release-note:bug
`Category`: Fix argument being optional
```
``````

#### Resource and provider enhancements

A new enhancement entry should use the `release-note:enhancement` header and have a prefix indicating the resource or data source it corresponds to, a colon, then followed by a brief summary. Use a `provider` prefix for provider level enhancements.

``````markdown
```release-note:enhancement
`Category`: Add new argument
```
``````

#### Deprecations

A deprecation entry should use the `release-note:note` header and have a prefix indicating the resource or data source it corresponds to, a colon, then followed by a brief summary.

``````markdown
```release-note:note
`Category`: The old_attribute is being deprecated in favor of the new_attribute to support new feature
```
``````

#### Breaking changes and removals

A breaking-change entry should use the `release-note:breaking-change` header and have a prefix indicating the resource or data source it corresponds to, a colon, then followed by a brief summary.

``````markdown
```release-note:breaking-change
`Category`: This is a breaking change
```
``````

### Changes that should *not* have a CHANGELOG entry

* Testing updates
* Code refactoring
* CI pipeline changes
