/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package instance

import (
	conf "timoni.sh/postgresql/instance/config"
	"timoni.sh/postgresql/templates"
)

// Instance takes the config values and outputs the Kubernetes objects.
#Instance: {
	config: conf.#Config

	objects: {
		statefulset: templates.#StatefulSet & {
			#config:     config
			#secretname: secret.metadata.name
		}
		service: templates.#Service & {#config: config}
		secret: templates.#Secret & {#config: config}
	}
}
