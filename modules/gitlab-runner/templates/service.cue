package templates

import (
	conf "timoni.sh/gitlab-runner/instance/config"

	corev1 "k8s.io/api/core/v1"
)

#Service: corev1.#Service & {
	#config: conf.#Config

	apiVersion: "v1"
	kind:       "Service"
	metadata:   #config.metadata
	if #config.service.annotations != _|_ {
		metadata: annotations: #config.service.annotations
	}

	spec: corev1.#ServiceSpec & {
		type:     corev1.#ServiceTypeClusterIP
		selector: #config.selector.labels
		ports: [
			{
				port:       #config.service.port
				protocol:   "TCP"
				name:       "http"
				targetPort: name
			},
		]
	}
}
