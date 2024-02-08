package gcp

import (
	conf "timoni.sh/gitlab-runner/instance/config"
	storagev1beta1 "github.com/GoogleCloudPlatform/k8s-config-connector/pkg/clients/generated/apis/storage/v1beta1"
)

#CacheBucket: storagev1beta1.#StorageBucket & {
	#config: conf.#Config

	apiVersion: "storage.cnrm.cloud.google.com/v1beta1"
	kind:       "StorageBucket"
	metadata: {
		name:      #config.cache.bucket
		namespace: #config.provider.resourceManager.namespace
		labels:    #config.metadata.labels
		if #config.metadata.annotations != _|_ {
			annotations: #config.metadata.annotations
		}
	}

	spec: {
		versioning: enabled: false
		publicAccessPrevention:   "enforced"
		uniformBucketLevelAccess: true
		lifecycleRule: [{
			action: type: "Delete"
			condition: {
				age:       90
				withState: "ANY"
			}
		}]
	}
}
