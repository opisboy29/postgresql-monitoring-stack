#!/bin/bash

# PostgreSQL & System Monitoring Stack Setup Script

echo "Setting up PostgreSQL & System Monitoring Stack..."

# Create required directories
echo "Creating directory structure..."
mkdir -p prometheus/rules
mkdir -p grafana/provisioning/datasources
mkdir -p grafana/provisioning/dashboards
mkdir -p grafana/dashboards

# Set proper permissions for Grafana
echo "Setting permissions..."
sudo chown -R 472:472 grafana/ 2>/dev/null || echo "Warning: Could not set Grafana permissions. You may need to run this with sudo."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose > /dev/null 2>&1; then
    echo "Error: Docker Compose is not installed. Please install Docker Compose and try again."
    exit 1
fi

# Start the monitoring stack
echo "Starting monitoring stack..."
docker-compose up -d

# Wait a moment for services to start
echo "Waiting for services to start..."
sleep 10

# Check service status
echo "Checking service status..."
docker-compose ps

echo ""
echo "Setup complete! Access your services at:"
echo "- Grafana: http://localhost:3000 (admin/admin123)"
echo "- Prometheus: http://localhost:9090"
echo "- PostgreSQL Exporter: http://localhost:9187/metrics"
echo "- Node Exporter: http://localhost:9100/metrics"
echo ""
echo "To view logs: docker-compose logs -f"
echo "To stop services: docker-compose down" 