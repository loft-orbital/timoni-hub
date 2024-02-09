# cloud

Cloud provider configuration library.

## Azure

> Work in progress

## AWS

> Work in progress

## Google Cloud 

The [Google Cloud](https://cloud.google.com) configuration is exposed under the [`#GCP`](gcp.cue) definition.
When available, module are compatible with the [Config Connector](https://cloud.google.com/config-connector/docs/overview) resource manager.

| Key                           | Type     | Description                                                                                                                                                                                                                                                                                      |
| ---                           | ---      | ---                                                                                                                                                                                                                                                                                              |
| `project!:`                   | `string` | Project ID                                                                                                                                                                                                                                                                                       |
| `region!:`                    | `string` | [Region](https://cloud.google.com/compute/docs/regions-zones)                                                                                                                                                                                                                                    |
| `zone?:`                      | `string` | [Zone](https://cloud.google.com/compute/docs/regions-zones). If set, this must starts with the region name                                                                                                                                                                                       |
| `serviceAccount?:`            | `string` | [Service Account](https://cloud.google.com/iam/docs/service-account-overview). When set, it should be the name of the service account, not its id (email). Depending on the module it can be used to create the service account, or just reference it. Please refer to the module documentation. |
| `resourceManager?: namespace` | `string` | Config connector resource namespace. Often defaults to the instance namespace.                                                                                                                                                                                                                   |
