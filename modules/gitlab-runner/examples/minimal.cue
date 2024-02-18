/// Crafted with love by the Loft Orbital team and contributors.
/// Licensed under the Apache License, Version 2.0.

package examples

values: runner: {
	config:   globalConfig
	template: runnerTemplate
	token:    "gitlabsupersecrettoken"
}

let globalConfig = """
	concurrent = 100
	check_interval = 5
	"""

let runnerTemplate = """
	[[runners]]
	  name = "gitlab-runner"
	  executor = "kubernetes"
	  url = "https://gitlab.com/"
	"""
