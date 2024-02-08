package templates

import (
	conf "timoni.sh/gitlab-runner/instance/config"

	corev1 "k8s.io/api/core/v1"
)

#Secret: corev1.#Secret & {
	#config: conf.#Config

	apiVersion: "v1"
	kind:       "Secret"
	metadata:   #config.metadata

	stringData: {
		runnerToken: #config.runner.token
	}
}
