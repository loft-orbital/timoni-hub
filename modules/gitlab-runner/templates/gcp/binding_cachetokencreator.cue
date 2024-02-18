/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package gcp

import (
	conf "timoni.sh/gitlab-runner/instance/config"
	iamv1beta1 "github.com/GoogleCloudPlatform/k8s-config-connector/pkg/clients/generated/apis/iam/v1beta1"
)

#CacheTokenCreatorBinding: iamv1beta1.#IAMPolicyMember & {
	#config: conf.#Config

	apiVersion: "iam.cnrm.cloud.google.com/v1beta1"
	kind:       "IAMPolicyMember"
	metadata: {
		name:      #config.metadata.name + "-cache-token-creator"
		namespace: #config.provider.resourceManager.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}

	spec: {
		memberFrom: serviceAccountRef: name: #config.metadata.name
		resourceRef: {
			apiVersion: "iam.cnrm.cloud.google.com/v1beta1"
			kind:       "IAMServiceAccount"
			name:       #config.metadata.name
		}
		role: "roles/iam.serviceAccountTokenCreator"
	}
}
