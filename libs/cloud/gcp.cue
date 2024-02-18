/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package cloud

#GCP: {
	name: "gcp"

	project!: string

	region!: string
	zone?:   =~"^\(region)"

	serviceAccount?: string

	resourceManager?: {
		namespace: string
	}
}
