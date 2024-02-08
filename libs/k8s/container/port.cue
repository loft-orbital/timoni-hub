package container

// #Ports is an helper type to define ports for a container.
// It can help you reference ports in the container definition.
//
// Example usage:
// ```cue
// containers: [{
//    name: "my-container"
//    _ports: #Ports & {
//       http: containerPort: 8080
//    }
//    ports: _ports.$out
// }]
// ```
#Ports: this={
	$out: [for k, v in this if k != "$out" {v}]

	[Name= !="$out"]: {
		name:          Name
		containerPort: int & >0 & <65536
		protocol:      *"TCP" | string
	}
}
