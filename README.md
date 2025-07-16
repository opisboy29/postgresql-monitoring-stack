# PostgreSQL Monitoring Stack

[![GitHub](https://img.shields.io/github/license/opisboy29/postgresql-monitoring-stack)](https://github.com/opisboy29/postgresql-monitoring-stack/blob/main/LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue)](https://docs.docker.com/compose/)
[![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-orange)](https://prometheus.io/)
[![Grafana](https://img.shields.io/badge/Grafana-Dashboard-green)](https://grafana.com/)

Complete PostgreSQL and system monitoring stack with Prometheus, Grafana, and Docker. Pre-configured dashboards, alerts, and one-click setup for monitoring PostgreSQL databases and Linux servers.

## 🚀 Features

- **PostgreSQL Monitoring**: Database performance, connections, queries, and more
- **System Monitoring**: CPU, memory, disk, network metrics for Linux/Debian servers
- **Pre-built Dashboards**: Ready-to-use Grafana dashboards
- **Alerting**: Built-in alerts for critical conditions
- **Docker-based**: Easy deployment with Docker Compose
- **One-click Setup**: Automated deployment scripts

## 📋 Quick Start

### Prerequisites

- Docker and Docker Compose installed
- PostgreSQL database running (configured for localhost:5445 by default)

### Installation

1. **Clone the repository**:
   ```bash
   git clone git@github.com:opisboy29/postgresql-monitoring-stack.git
   cd postgresql-monitoring-stack
   ```

2. **Configure environment**:
   ```bash
   cp .env.example .env
   # Edit .env file with your PostgreSQL connection details
   ```

3. **Run setup**:
   ```bash
   # Option 1: Using setup script
   chmod +x setup.sh && ./setup.sh
   
   # Option 2: Using Makefile
   make setup
   
   # Option 3: Manual setup
   docker-compose up -d
   ```

4. **Access services**:
   - **Grafana**: http://localhost:3000 (admin/admin123)
   - **Prometheus**: http://localhost:9090
   - **PostgreSQL Exporter**: http://localhost:9187/metrics
   - **Node Exporter**: http://localhost:9100/metrics

## 📊 Dashboards

### PostgreSQL Dashboard
- Active connections monitoring
- Query performance metrics
- Database operations (inserts, updates, deletes)
- Lock statistics and cache hit ratios

### System Dashboard
- CPU usage gauge and trends
- Memory usage monitoring
- Disk space and I/O metrics
- Network traffic analysis

## 🔔 Alerts

Pre-configured alerts for:

**PostgreSQL:**
- Database connectivity issues
- High connection count
- Performance degradation

**System:**
- High CPU usage (>80%)
- High memory usage (>90%)
- Low disk space (>90% used)
- Service availability

## 🛠️ Configuration

### Database Connection

Edit `.env` file:
```bash
POSTGRES_USER=your_username
POSTGRES_PASSWORD=your_password
POSTGRES_HOST=host.docker.internal  # For localhost connections
POSTGRES_PORT=5445
POSTGRES_DB=your_database
```

### Custom Dashboards

Add custom dashboard JSON files to `grafana/dashboards/` directory for automatic provisioning.

### Custom Alerts

Add alert rules to `prometheus/rules/` following the existing YAML format.

## 📁 Project Structure

```
postgresql-monitoring-stack/
├── docker-compose.yml          # Main Docker Compose configuration
├── .env.example               # Environment variables template
├── setup.sh                   # Automated setup script
├── health-check.sh            # Health check script
├── Makefile                   # Common operations
├── prometheus/
│   ├── prometheus.yml         # Prometheus configuration
│   └── rules/                 # Alert rules
├── grafana/
│   ├── provisioning/          # Grafana provisioning
│   └── dashboards/            # Pre-built dashboards
└── scripts/
    └── set-permissions.sh     # Permission setup script
```

## 🔧 Commands

```bash
# Start services
make start
# or
docker-compose up -d

# Stop services
make stop
# or
docker-compose down

# Check health
make health
# or
./health-check.sh

# View logs
make logs
# or
docker-compose logs -f

# Clean up everything
make clean
```

## 🐛 Troubleshooting

### PostgreSQL Connection Issues
1. Verify PostgreSQL is running and accessible
2. Check connection parameters in `.env` file
3. For localhost connections, ensure `host.docker.internal` is used
4. Review PostgreSQL logs for connection errors

### Permission Issues
```bash
# Run permission setup
chmod +x scripts/set-permissions.sh
./scripts/set-permissions.sh
```

### Container Issues
```bash
# Check container status
docker-compose ps

# View specific service logs
docker-compose logs [service-name]

# Restart services
docker-compose restart
```

## 🔒 Security

For production deployments:
- Change default Grafana admin password
- Use environment-specific credentials
- Implement proper firewall rules
- Use TLS/SSL for external access
- Restrict PostgreSQL access to monitoring user only

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Support

If this project helps you, please give it a star! ⭐

For issues and questions:
- Create an [issue](https://github.com/opisboy29/postgresql-monitoring-stack/issues)
- Review container logs for debugging

## 📈 Roadmap

- [ ] Add more database exporters (MySQL, MongoDB)
- [ ] Implement Alertmanager for notifications
- [ ] Add backup monitoring
- [ ] Create Helm chart for Kubernetes deployment
- [ ] Add more pre-built dashboards

---

Made with ❤️ for the DevOps community