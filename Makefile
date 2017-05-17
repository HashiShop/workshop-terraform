PATH := $(PATH):$(HOME)/.local/bin:$(HOME)/bin:/bin:/usr/local/bin
SHELL := /usr/bin/env bash

.DEFAULT_GOAL := help

ENV ?= dev
OPTIONS ?=
OUTPUT ?=
RESOURCE ?=

help:
	@printf "\033[36m\033[1m%-10s\033[0m%-55s\033[33m%s\n\n" target description usage
	@grep -E '^[a-zA-Z1-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN { FS = ": ## " }; { printf "\033[36m\033[1m%-10s\033[0m%-55s\033[33m%s\n", $$1, $$2, $$3 }'

# TERRAFORM COMMANDS
apply: ## Builds or changes infrastructure : ## ENV="dev" OPTIONS= make apply
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform apply $(OPTIONS) ".terraform/plan-$(ENV)"

console: ## Interactive console for Terraform interpolations : ## ENV="dev" OPTIONS= make console
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform console $(OPTIONS)

destroy: ## Destroy Terraform-managed infrastructure : ## ENV="dev" OPTIONS= make destroy
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform destroy $(OPTIONS)

get: ## Download and install modules for the configuration : ## ENV="dev" OPTIONS= make get
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform get $(OPTIONS)

graph: ## Create a visual graph of Terraform resources : ## ENV="dev" OPTIONS= make graph
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform graph $(OPTIONS) | dot -Tpng > ".terraform/graph-$(ENV).png" && echo graph saved as .terraform/graph-$(ENV).png

init: ## Initialize a new or existing Terraform configuration : ## ENV="dev" OPTIONS= make init
	@terraform init -backend-config=backend.configuration $(OPTIONS)

output: ## Read an output from a state file : ## ENV="dev" OPTIONS= OUTPUT="" make output
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform output $(OPTIONS) $(OUTPUT)

plan: ## Generate and show an execution plan : ## ENV="dev" OPTIONS= make plan
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform plan -out=".terraform/plan-$(ENV)" $(OPTIONS)

refresh: ## Update local state file against real resources : ## ENV="dev" OPTIONS= make refresh
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform refresh $(OPTIONS)

show: ## Inspect Terraform state or plan : ## ENV="dev" OPTIONS= make show
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform show $(OPTIONS)

taint: ## Manually mark a resource for recreation : ## ENV="dev" OPTIONS= RESOURCE= make taint
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform taint $(OPTIONS) $(RESOURCE)

untaint: ## Manually unmark a resource as tainted : ## ENV="dev" OPTIONS= RESOURCE= make untaint
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform untaint $(OPTIONS) $(RESOURCE)

validate: ## Validates the Terraform files : ## ENV="dev" OPTIONS= make validate
	$(info --> switching to terraform $(ENV) environment)
	@make select-env
	@terraform validate $(OPTIONS)

# HELPER
select-env:
	@terraform env select $(ENV)
