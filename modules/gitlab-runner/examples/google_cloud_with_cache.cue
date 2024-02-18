/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package examples

values: {
	provider: {
		name:    "gcp"
		project: "myproject"
		region:  "us-central1"
		zone:    "us-central1-a"

		serviceAccount: "gitlab-runner"
		// Enable management of resources with Config Connector
		resourceManager: _
	}

	cache: bucket: "runner-cache"

	runner: {
		config:   globalConfig
		template: runnerTemplate
		token:    "gitlabsupersecrettoken"
	}
}

let globalConfig = """
	concurrent = 100
	check_interval = 5
	"""

let runnerTemplate = """
[[runners]]
  name = "gcp-runner"
  executor = "kubernetes"
  url = "https://gitlab.com/"
  cache_dir = "/mnt/cache"

  [runners.cache]
    type = "gcs"
    path = "cached"
    shared = true
    [runners.cache.gcs]
      bucket_name = "\(values.cache.bucket)"
"""
