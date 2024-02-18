# timoni-hub

K8s packages collection as [timoni.sh](https://timoni.sh) modules.

## Using a Module
If you're new to Timoni, we highly recommend visiting [Timoni concepts](https://timoni.sh/concepts/) first.
This resource will help you understand the fundamental concepts of Timoni.
Additionally, having some basic knowledge of [CUE](https://cuelang.org/) is necessary.
This [walktrough](https://timoni.sh/cue/walkthrough/) will get you started with using a module.

### Modules
Modules are stored within the `modules/` directory.
Each module includes its own usage documentation.
Before using a module, please ensure to review its documentation thoroughly.

Every module includes a set of examples located in the `examples/` directory.
These examples serve as a valuable starting point to comprehend the module configuration.

| Module                                 | Package                                                                                                                      | Description           |
| ---                                    | ---                                                                                                                          | ---                   |
| [gitlab-runner](modules/gitlab-runner) | [ghcr.io/loft-orbital/timoni/gitlab-runner](https://github.com/loft-orbital/timoni-hub/pkgs/container/timoni%2gitlab-runner) | CI runner for GitLab  |
| [postgresql](modules/postgresql)       | [ghcr.io/loft-orbital/timoni/gitlab-runner](https://github.com/loft-orbital/timoni-hub/pkgs/container/timoni%2postgresql)    | Postgres SQL database |

### Verifying

All modules are signed with [Cosign](https://github.com/sigstore/cosign) keyless during distribution.
You can verify the integrity of the module by using the `--certificate-identity-regexp` `^https://github.com/loft-orbital/timoni-hub.*$` and `--certificate-oidc-issuer` `https://token.actions.githubusercontent.com`.
Here's an example with the pull command:

```shell
timoni mod pull oci://ghcr.io/loft-orbital/timoni/<module-name> -v 1.0.0 \
  --output ./<module-name> \
  --verify=cosign \
  --certificate-identity-regexp="^https://github.com/loft-orbital/timoni-hub.*$` \
  --certificate-oidc-issuer-regexp=https://token.actions.githubusercontent.com
```

## Contributing

We welcome contribution via GitHub pull requests.
Please refer to the [contributing guide](CONTRIBUTING.md) for more informations.

