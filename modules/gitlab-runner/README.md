# gitlab-runner

A [timoni.sh](http://timoni.sh) module for deploying a [GitLab Runner](https://docs.gitlab.com/runner/) to Kubernetes clusters.

## Install

To create an instance using the default values:

```shell
timoni -n default apply gitlab-runner oci://ghcr.io/loft-orbital/timoni-hub/gitlab-runner
```

To change the [default configuration](#configuration),
create one or more `values.cue` files and apply them to the instance.

For example, create a file `my-values.cue` with the following content:

```cue
values: {
	resources: requests: {
		cpu:    "100m"
		memory: "128Mi"
	}
}
```

And apply the values with:

```shell
timoni -n default apply gitlab-runner oci://ghcr.io/loft-orbital/timoni-hub/gitlab-runner \
--values ./my-values.cue
```

## Uninstall

To uninstall an instance and delete all its Kubernetes resources:

```shell
timoni -n default delete gitlab-runner
```

## Configuration

| Key                        | Type                               | Default              | Description                                                                                                                                    |
| -------------------------- | ---------------------------------- | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `image: tag:`              | `string`                           | `<latest version>`   | Container image tag                                                                                                                            |
| `image: digest:`           | `string`                           | `""`                 | Container image digest, takes precedence over `tag` when specified                                                                             |
| `image: repository:`       | `string`                           | `docker.io/nginx`    | Container image repository                                                                                                                     |
| `image: pullPolicy:`       | `string`                           | `IfNotPresent`       | [Kubernetes image pull policy](https://kubernetes.io/docs/concepts/containers/images/#image-pull-policy)                                       |
| `metadata: labels:`        | `{[ string]: string}`              | `{}`                 | Common labels for all resources                                                                                                                |
| `metadata: annotations:`   | `{[ string]: string}`              | `{}`                 | Common annotations for all resources                                                                                                           |
| `pod: annotations:`        | `{[ string]: string}`              | `{}`                 | Annotations applied to pods                                                                                                                    |
| `pod: affinity:`           | `corev1.#Affinity`                 | `{}`                 | [Kubernetes affinity and anti-affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity)   |
| `pod: imagePullSecrets:`   | `[...timoniv1.#ObjectReference]`   | `[]`                 | [Kubernetes image pull secrets](https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod)                   |
| `replicas:`                | `int`                              | `1`                  | Kubernetes deployment replicas                                                                                                                 |
| `resources:`               | `timoniv1.#ResourceRequirements`   | `{}`                 | [Kubernetes resource requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers)                       |
| `securityContext:`         | `corev1.#SecurityContext`          | `{}`                 | [Kubernetes container security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context)                             |
| `service: annotations:`    | `{[ string]: string}`              | `{}`                 | Annotations applied to the Kubernetes Service                                                                                                  |
| `service: port:`           | `int`                              | `80`                 | Kubernetes Service HTTP port                                                                                                                   |
| `provider?:`               | `cloud.#Provider`                  | ``                   | Optional cloud provider configuration. [Documentation](../../libs/cloud/README.md).                                                            |
| `gitlab: url:`             | `string`                           | `https://gitlab.com` | GitLab instance host                                                                                                                           |
| `cache?: bucket:`          | `string`                           | ``                   | Bucket name for the cache, if used                                                                                                             |
| `runner: config`           | `string`                           | `""`                 | Runner global configuration                                                                                                                    |
| `runner: template`         | `string`                           | `""`                 | Registration [configuration template](https://docs.gitlab.com/runner/register/#register-with-a-configuration-template)                         |
| `runner: token!`           | `string`                           | ``                   | [Runner authentication token](https://docs.gitlab.com/ee/security/token_overview.html#runner-authentication-tokens)                            |

## Cloud Providers Compatibility

This module is currently only compatible with Google Cloud provider.
This does not mean you cannot deploy it on other Cloud provider, but cloud resources (like cache bucket) will have to be managed separately.
