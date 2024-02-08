# Contributing Guide for Timoni-Hub

Thank you for your interest in contributing to Timoni-Hub!
Your contributions are highly valuable in helping to improve the project.
Please take a moment to read and follow this guide to make your contributions as smooth as possible.

## Requirements

Before you begin contributing to Timoni-Hub, ensure that your system is prepared for building and testing.
We offer two setup options, both of which are non-invasive.
You are free to choose the one that suits you best.

### Local Setup

For the local setup, you only need to [install `proto`](https://moonrepo.dev/docs/proto/install), a unified toolchain.

### Containerized Setup

The containerized setup requires you to have a container runtime and a compatible command-line interface.
Currently, we support [Podman](https://podman.io/), [Nerdctl](https://github.com/containerd/nerdctl), and [Docker](https://www.docker.com/).
Additionally, you will need `make`, although it's likely already available on your system.

To execute the commands described later, you must first run:

```shell
make dev-shell
```

This command will launch a container with `proto` available. Your container will be stopped but preserved after you exit. If you wish to start fresh, simply run:

```shell
make clean
```

This command will remove the container.

## Code of Conduct

Timoni-Hub follows a code of conduct outlined in [this document](https://github.com/loft-orbital/.github/blob/main/CODE_OF_CONDUCT.md).
Please ensure all interactions and contributions adhere to these guidelines.

## Contributing to Timoni-Hub

We welcome contributions from the community!
Here are some guidelines for contributing to the project.

### Pull Requests

1. Fork the [Timoni-Hub repository](https://github.com/loft-orbital/timoni-hub) on GitHub.
1. Clone your forked repository to your local development environment.
1. Create a new branch for your work:
    ```shell
    git checkout -b <prefix>/<name>
    ```
    where `<prefix>` reflects the type of your proposal (fix, feat, build, etc...)
    and `<name>` is a short name describing your proposal.
1. Make your changes, commit your work (c.f. [Commit Messages](#commit-messages)), and push the changes to your forked repository.
1. Verify your changes are passing tests (c.f. [Running Checks](#running-checks)).
1. Create a pull request (PR) from your branch to the `main` branch of the original Timoni-Hub repository.
1. Ensure your PR has a clear and descriptive title.
1. Describe your changes in the PR description, providing context and reasoning for the changes.
1. Once submitted, your PR will be reviewed by the maintainers. Make sure to respond to any feedback or requested changes in a timely manner.

### Toolchain Configuration

Prior to running any command, you'll have to configure your toolchain.
You only need to run that command once, any tool update will automatically be handled by `proto` at runtime.

```
proto use
```

### Commit Messages

We follow the Conventional Commits standard for commit messages.
Please adhere to the guidelines outlined in [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) when writing your commit messages.

This is important for our release workflow.
**Every commit** landing on `main` will be automatically released.
[Conventional Commits Next Version](https://crates.io/crates/conventional_commits_next_version) is used to automatically determine if a module release is mandatory, and if so which version should be released.
It's based on commit history and modified files (module dependencies included).

### Running Checks

You can run checks on the codebase by using `moon`. To run all checks, use the following command:

```shell
moon check --all
```

To check a specific module, use:

```shell
moon check <module_name>
```

## Project Structure

```
.
├── .moon      <-- moon tasks and configuration
├── libs       <-- CUE libraries
├── modules    <-- Timoni modules
├── templates  <-- Templates to generate module and libraries
└── tools      <-- Additionnal tools and scripts for buildsystem and dev environment
```

## Scaffolding a new module

To generate boilerplate for a new module or library, you can use moon [code generation](https://moonrepo.dev/docs/guides/codegen):

```shell
moon generate [module|lib]
```

---

We appreciate your contributions to Timoni-Hub and look forward to your involvement in the project!
If you have any questions or need assistance, feel free to reach out to the maintainers.
Happy contributing!
