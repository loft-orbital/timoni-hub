/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package templates

import (
	conf "timoni.sh/gitlab-runner/instance/config"
	corev1 "k8s.io/api/core/v1"
)

#ConfigMap: corev1.#ConfigMap & {
	#config: conf.#Config

	apiVersion: "v1"
	kind:       "ConfigMap"
	metadata:   #config.metadata

	data: {
		"config.toml":          #config.runner.config
		"config.template.toml": #config.runner.template
	}
}
