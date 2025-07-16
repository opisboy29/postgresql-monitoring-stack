#!/bin/bash

# Health Check Script for Monitoring Stack

echo "Checking monitoring stack health..."
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if services are running
check_service() {
    local service_name=$1
    local service_url=$2
    
    if curl -s -o /dev/null -w "%{http_code}" "$service_url" | grep -q "200\|000"; then
        echo -e "${GREEN}✓${NC} $service_name is healthy"
        return 0
    else
        echo -e "${RED}✗${NC} $service_name is not responding"
        return 1
    fi
}

# Check Docker containers
echo "Container Status:"
docker-compose ps

echo -e "\nService Health Checks:"

# Check services
check_service "Grafana" "http://localhost:3000/api/health"
check_service "Prometheus" "http://localhost:9090/-/healthy"
check_service "PostgreSQL Exporter" "http://localhost:9187/metrics"
check_service "Node Exporter" "http://localhost:9100/metrics"

# Check Prometheus targets
echo -e "\nPrometheus Targets:"
curl -s http://localhost:9090/api/v1/targets | jq -r '.data.activeTargets[] | "\(.labels.job): \(.health)"' 2>/dev/null || echo "jq not installed - check http://localhost:9090/targets manually"

echo -e "\nFor detailed logs run: docker-compose logs -f [service-name]" 