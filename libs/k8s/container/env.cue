/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package container

// #Env is an helper to generate a list of kubernetes env vars from a map.
// It can help referencing env by name instead of index.
//
// Example usage:
// ```cue
// containers: [{
//     name: "my-container"
//     ...
//     _env: #Env & {
//         MY_ENV: "my-value"
//         FROM_SECRET: configMapKeyRef: {
//             name: "my-config-map"
//             key: "my-key"
//         }
//     }
//    env: _env.$out
// }]
// ```
#Env: this={
	[NAME= !="$out"]: _

	"$out": [for k, v in this if k != "$out" {
		name: k
		if "\(v)" != _|_ {
			value: "\(v)"
		}
		if "\(v)" == _|_ {
			valueFrom: v
		}
	}]
}
