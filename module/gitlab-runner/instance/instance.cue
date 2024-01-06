package instance

import (
	conf "timoni.sh/gitlab-runner/instance/config"
	"timoni.sh/gitlab-runner/templates"
	"loftorbital.com/utils"
)

// Instance takes the config values and outputs the Kubernetes objects.
#Instance: {
	config: conf.#Config

	objects: {
		deploy: templates.#Deployment & {
			#config: config
			#config: pod: annotations: "checksum.timoni.sh/secret":    (utils.#Checksum & {$in: secret.stringData}).$out
			#config: pod: annotations: "checksum.timoni.sh/configmap": (utils.#Checksum & {$in: configmap.data}).$out
		}
		service: templates.#Service & {#config: config}
		secret: templates.#Secret & {#config: config}
		configmap: templates.#ConfigMap & {#config: config}
	}
}
