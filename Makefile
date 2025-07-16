# Makefile for PostgreSQL & System Monitoring Stack

.PHONY: help setup start stop restart logs health clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: ## Initial setup and start all services
	@echo "Setting up monitoring stack..."
	@chmod +x setup.sh health-check.sh
	@./setup.sh

start: ## Start all services
	@echo "Starting monitoring stack..."
	@docker-compose up -d

stop: ## Stop all services
	@echo "Stopping monitoring stack..."
	@docker-compose down

restart: ## Restart all services
	@echo "Restarting monitoring stack..."
	@docker-compose restart

logs: ## Show logs for all services
	@docker-compose logs -f

health: ## Check health of all services
	@chmod +x health-check.sh
	@./health-check.sh

clean: ## Stop and remove all containers, networks, and volumes
	@echo "Cleaning up monitoring stack..."
	@docker-compose down -v
	@docker system prune -f

postgres-logs: ## Show PostgreSQL exporter logs
	@docker-compose logs -f postgres-exporter

prometheus-logs: ## Show Prometheus logs
	@docker-compose logs -f prometheus

grafana-logs: ## Show Grafana logs
	@docker-compose logs -f grafana

node-logs: ## Show Node exporter logs
	@docker-compose logs -f node-exporter 