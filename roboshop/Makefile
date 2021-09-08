#!/bin/bash
help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep 
mongodb.sh: ## install mongoDB.
	@bash components/mongodb
catalogue: ## install catalogue.
	@bash catalogue
cart: ## install cart.
	@bash cart
user: ## install user.
	@bash user
shipping: ## install shipping.
	@bash shipping
mysql: ## install mysql.
	@bash mysql
redis: ## install redis.
	@bash redis
rabbitmq: ## install rabbitmq.
	@bash rabbitmq
payment: ## install payment.
	@bash payment
frontend: ## install frontend.
	@bash frontend