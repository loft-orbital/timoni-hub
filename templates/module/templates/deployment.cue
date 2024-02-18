/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package templates

import (
	conf "timoni.sh/{{name}}/instance/config"
	"loftorbital.com/k8s/container"

	appsv1 "k8s.io/api/apps/v1"
	corev1 "k8s.io/api/core/v1"
)

#Deployment: appsv1.#Deployment & {
	#config:    conf.#Config

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
				containers: [
					{
						name:            #config.metadata.name
						image:           #config.image.reference
						imagePullPolicy: #config.image.pullPolicy
						#ports: container.#Ports & {
							http: containerPort: 8080
						}
						ports: #ports.$out

						readinessProbe: {
							httpGet: {
								path: "/"
								port: "http"
							}
							initialDelaySeconds: 5
							periodSeconds:       10
						}
						livenessProbe: {
							tcpSocket: {
								port: "http"
							}
							initialDelaySeconds: 5
							periodSeconds:       5
						}
						if #config.resources != _|_ {
							resources: #config.resources
						}
						if #config.securityContext != _|_ {
							securityContext: #config.securityContext
						}
					},
				]
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
