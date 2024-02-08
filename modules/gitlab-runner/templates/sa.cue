package templates

import (
	conf "timoni.sh/gitlab-runner/instance/config"
	corev1 "k8s.io/api/core/v1"
)

#ServiceAccount: corev1.#ServiceAccount & {
	#config: conf.#Config

	apiVersion: "v1"
	kind:       "ServiceAccount"
	metadata:   #config.metadata
}
