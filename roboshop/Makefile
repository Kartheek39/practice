#!/bin/bash
help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep 
mongodb: ## install mongoDB.
	@bash components/mongodb.sh
catalogue: ## install catalogue.
	@bash components/catalogue.sh
cart: ## install cart.
	@bash cart
user: ## install user.
	@bash user
shipping: ## install shipping.
	@bash shipping
common: 
	@bash components/common.sh