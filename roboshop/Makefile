#!/bin/bash
help:  ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep 
mongodb: ## install mongoDB.
	@bash Components/mongoDB
catalogue: ## install catalogue.
	@bash Components/catalogue
cart: ## install cart.
	@bash Components/cart
user: ## install user.
	@bash Components/user
shipping: ## install shipping.
	@bash Components/shipping
mysql: ## install mysql.
	@bash Components/mysql
redis: ## install redis.
	@bash Componets/redis
rabbitmq: ## install rabbitmq.
	@bash Components/frontend
payment: ## install payment.
	@bash Components/payment
frontend: ## install frontend.
	@bash Components/frontend