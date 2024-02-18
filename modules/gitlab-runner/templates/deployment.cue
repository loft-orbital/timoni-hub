/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package templates

import (
	conf "timoni.sh/gitlab-runner/instance/config"
	"loftorbital.com/k8s/container"

	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
)

let ConfigFilePath = "config/runner.toml"

#Deployment: appsv1.#Deployment & {
	#config: conf.#Config

	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata:   #config.metadata

	spec: appsv1.#DeploymentSpec & {
		replicas: #config.replicas
		selector: matchLabels: #config.selector.labels
		template: {
			metadata: {
				labels: #config.selector.labels
				if #config.pod.annotations != _|_ {
					annotations: #config.pod.annotations
				}
			}
			spec: corev1.#PodSpec & {
				serviceAccountName: #config.metadata.name

				terminationGracePeriodSeconds: 3600

				containers: [
					{
						name:            "runner"
						image:           #config.image.reference
						imagePullPolicy: #config.image.pullPolicy

						_ports: container.#Ports & {
							metrics: containerPort: 9252
						}
						ports: _ports.$out

						volumeMounts: [{
							mountPath: "/config"
							name:      "config"
						}]

						command: ["gitlab-runner", "run", "--config", ConfigFilePath]

						if #config.resources != _|_ {
							resources: #config.resources
						}
						if #config.securityContext != _|_ {
							securityContext: #config.securityContext
						}
					},
				]

				initContainers: [{
					name:            "global-config"
					image:           "alpine:3.12"
					imagePullPolicy: "IfNotPresent"

					command: ["cp", "/configmaps/config.toml", ConfigFilePath]

					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}, {
						mountPath: "/configmaps"
						name:      "cm"
					}]
				}, {
					name:            "register"
					image:           #config.image.reference
					imagePullPolicy: #config.image.pullPolicy

					command: [
						"gitlab-runner", "register",
						"--config", ConfigFilePath,
						"--template-config", "/configmaps/config.template.toml",
						"--non-interactive",
						"--url", #config.gitlab.url,
						"--token", "$(TOKEN)",
						"--locked",
						"--executor", "kubernetes",
					]

					_env: container.#Env & {
						TOKEN: secretKeyRef: {
							name: #config.metadata.name
							key:  "runnerToken"
						}
					}
					env: _env.$out

					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}, {
						mountPath: "/configmaps"
						name:      "cm"
					}]

					if #config.resources != _|_ {
						resources: #config.resources
					}
				}]

				volumes: [{
					name: "cm"
					configMap: {
						defaultMode: 420
						name:        #config.metadata.name
					}
				}, {
					emptyDir: {}
					name: "config"
				}]

				securityContext: {
					fsGroup:   65533
					runAsUser: 100
				}

				if #config.pod.affinity != _|_ {
					affinity: #config.pod.affinity
				}
				if #config.pod.imagePullSecrets != _|_ {
					imagePullSecrets: #config.pod.imagePullSecrets
				}
			}
		}
	}
}
