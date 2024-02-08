# Common variables
# ---
dev_image := github.com/loft-orbital/timoni-hub/dev
container_name := loft-timoni-hub-dev

# Executables
# ---
container := $(shell command -v podman 2> /dev/null)
container := $(shell command -v nerdctl 2> /dev/null)
container += $(shell command -v docker 2> /dev/null)
container := $(word 1, $(container))

# Targets
# ---
dev-image: ## Build development image
	@$(container) build \
		--file=tools/devenv/Containerfile \
		--tag=$(dev_image) \
		.
.PHONY: dev-image

dev-shell: dev-image ## Run development shell
	-@tools/devenv/container_shell.sh $(container) $(dev_image) $(container_name) $(CURDIR)
.PHONY: dev-shell

clean: ## Clean up
	-@$(container) rm $(container_name)
.PHONY: clean

help: ## Show help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help

.DEFAULT_GOAL := help
