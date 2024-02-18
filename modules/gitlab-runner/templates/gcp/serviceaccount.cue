/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package gcp

import (
	conf "timoni.sh/gitlab-runner/instance/config"
	iamv1beta1 "github.com/GoogleCloudPlatform/k8s-config-connector/pkg/clients/generated/apis/iam/v1beta1"
)

#IAMServiceAccount: iamv1beta1.#IAMServiceAccount & {
	#config: conf.#Config

	apiVersion: "iam.cnrm.cloud.google.com/v1beta1"
	kind:       "IAMServiceAccount"

	metadata: {
		name:      #config.metadata.name
		namespace: #config.provider.resourceManager.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}

	spec: resourceID: #config.provider.serviceAccount
}
