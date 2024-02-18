/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package templates

import (
	conf "timoni.sh/postgresql/instance/config"
	timoniv1 "timoni.sh/core/v1alpha1"
)

#Secret: timoniv1.#ImmutableConfig & {
	#config: conf.#Config
	#Kind:   timoniv1.#SecretKind
	#Meta:   #config.metadata
	#Data: {
		"pgpassword": #config.password
	}
}
