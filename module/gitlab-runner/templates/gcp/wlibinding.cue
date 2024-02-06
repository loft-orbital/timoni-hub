package gcp

import (
	iamv1beta1 "github.com/GoogleCloudPlatform/k8s-config-connector/pkg/clients/generated/apis/iam/v1beta1"
)

#WorkloadIdentityBinding: iamv1beta1.#IAMPolicyMember & {
	#config: #Config

	apiVersion: "iam.cnrm.cloud.google.com/v1beta1"
	kind:       "IAMPolicyMember"
	metadata: {
		name:      #config.metadata.name + "-wli"
		namespace: #config.provider.resourceManager.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}

	spec: {
		member: "serviceAccount:\(#config.provider.project).svc.id.goog[\(#config.metadata.namespace)/\(#config.metadata.name)]"
		resourceRef: {
			apiVersion: "iam.cnrm.cloud.google.com/v1beta1"
			kind:       "IAMServiceAccount"
			name:       #config.metadata.name
		}
		role: "roles/iam.workloadIdentityUser"
	}
}
