/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

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
