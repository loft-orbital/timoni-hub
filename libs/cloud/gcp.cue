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
