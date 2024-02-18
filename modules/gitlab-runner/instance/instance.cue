/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package instance

import (
	conf "timoni.sh/gitlab-runner/instance/config"
	"timoni.sh/gitlab-runner/templates"
	"timoni.sh/gitlab-runner/templates/gcp"
	"loftorbital.com/utils"
	"loftorbital.com/cloud"
)

// Instance takes the config values and outputs the Kubernetes objects.
#Instance: {
	config: conf.#Config

	objects: {
		deploy: templates.#Deployment & {
			#config: config
			#config: pod: annotations: "checksum.timoni.sh/secret":    (utils.#Checksum & {$in: secret.stringData}).$out
			#config: pod: annotations: "checksum.timoni.sh/configmap": (utils.#Checksum & {$in: configmap.data}).$out
		}
		service: templates.#Service & {#config: config}
		secret: templates.#Secret & {#config: config}
		configmap: templates.#ConfigMap & {#config: config}
		sa: templates.#ServiceAccount & {#config: config}

		if config.provider != _|_ {
			if config.provider.name == cloud.#GCP.name {
				// Annotate service account with the GCP service account email
				sa: #config: metadata: annotations: "iam.gke.io/gcp-service-account": "\(config.provider.serviceAccount)@\(config.provider.project).iam.gserviceaccount.com"

				// If cloud resources are managed from K8s
				if config.provider.resourceManager != _|_ {
					gcp_sa: gcp.#IAMServiceAccount & {#config: config}

					gcp_worload_identity_binding: gcp.#WorkloadIdentityBinding & {#config: config}

					if config.cache != _|_ {
						gcp_cache_bucket: gcp.#CacheBucket & {#config: config}
						gcp_cache_admin_binding: gcp.#CacheAdminBinding & {#config: config}
						gcp_cache_token_creator: gcp.#CacheTokenCreatorBinding & {#config: config}
					}
				}
			}
		}
	}
}
