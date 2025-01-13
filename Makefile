help:  ## Show help
	@grep -E '^[.a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Clean autogenerated files
	rm -rf dist
	find . -type f -name "*.DS_Store" -ls -delete
	find . | grep -E "(__pycache__|\.pyc|\.pyo)" | xargs rm -rf
	find . | grep -E ".pytest_cache" | xargs rm -rf
	find . | grep -E ".ipynb_checkpoints" | xargs rm -rf
	rm -f .coverage

venv: ## Makes the venv with system site packages
	uv venv --system-site-packages

scripts-executable: ## Add executable permission to scripts and ensure shebang exists
	@echo "Preparing script files to executable..."
	@for script in $$(find scripts -type f -name "*.py"); do \
		chmod +x $$script; \
		if ! grep -q '^#!' $$script; then \
			echo "Adding shebang to $$script"; \
			sed -i '1i#!/usr/bin/env python3' $$script; \
		fi \
	done

docker-build: ## Build docker images
	docker compose build --no-cache

docker-up: ## Start docker containers
	docker compose up -d

docker-down: ## Stop docker containers
	docker compose down

docker-down-volume:  ## Stop docker containers with removing volumes.
	docker compose down -v

docker-attach: ## Attach to development container
	docker compose exec dev bash

format: ## Run pre-commit hooks
	uv run pre-commit run -a

test: ## Run pytest
	uv run pytest
