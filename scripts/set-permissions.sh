#!/bin/bash

echo "Setting up directory permissions..."

# Create directories if they don't exist
mkdir -p prometheus/rules
mkdir -p grafana/provisioning/datasources
mkdir -p grafana/provisioning/dashboards
mkdir -p grafana/dashboards

# Set Grafana permissions (UID 472)
echo "Setting Grafana permissions..."
sudo chown -R 472:472 grafana/ 2>/dev/null || echo "Warning: Could not set Grafana permissions with sudo"

# Make scripts executable
chmod +x setup.sh
chmod +x health-check.sh
chmod +x scripts/set-permissions.sh

echo "Permissions set successfully!" 