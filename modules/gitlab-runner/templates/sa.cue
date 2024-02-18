/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

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
