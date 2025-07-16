# System Monitoring Stack

[![GitHub](https://img.shields.io/github/license/opisboy29/postgresql-monitoring-stack)](https://github.com/opisboy29/postgresql-monitoring-stack/blob/main/LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue)](https://docs.docker.com/compose/)
[![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-orange)](https://prometheus.io/)
[![Grafana](https://img.shields.io/badge/Grafana-Dashboard-green)](https://grafana.com/)

System monitoring stack with Prometheus, Grafana, and Node Exporter. Focused on server/system monitoring with option to connect external database exporters.

## 🚀 Features

- **System Monitoring**: CPU, memory, disk, network metrics for Linux/Debian servers
- **Pre-built Dashboards**: Ready-to-use Grafana dashboards
- **Alerting**: Built-in alerts for critical system conditions
- **Docker-based**: Easy deployment with Docker Compose
- **Extensible**: Easy to add external exporters (PostgreSQL, MySQL, etc.)

## 📋 Quick Start

### Prerequisites

- Docker and Docker Compose installed

### Installation

1. **Clone the repository**:
   ```bash
   git clone git@github.com:opisboy29/postgresql-monitoring-stack.git
   cd postgresql-monitoring-stack
   ```

2. **Configure environment**:
   ```bash
   cp .env.example .env
   # Edit .env file if needed (optional for basic system monitoring)
   ```

3. **Run setup**:
   ```bash
   # Option 1: Using setup script
   make setup
   
   # Option 2: Manual setup
   docker-compose up -d
   ```

4. **Access services**:
   - **Grafana**: http://localhost:3004 (admin/admin123)
   - **Prometheus**: http://localhost:9091
   - **Node Exporter**: http://localhost:9101/metrics

## 📊 Monitoring Scope

### Current Stack Monitors:
- ✅ **System Resources**: CPU, Memory, Disk usage
- ✅ **Network I/O**: Interface statistics and traffic
- ✅ **Disk I/O**: Read/write operations and throughput
- ✅ **System Load**: Load averages and process counts
- ✅ **File System**: Disk space usage per mount point

### External Databases:
- 🔗 **PostgreSQL**: Add postgres-exporter to your database compose
- 🔗 **MySQL**: Add mysqld-exporter if needed
- 🔗 **Redis**: Add redis-exporter if needed

## 🔗 Adding PostgreSQL Monitoring

To monitor PostgreSQL, add postgres-exporter to your database docker-compose:

```yaml
  postgres-exporter:
    image: prometheuscommunity/postgres-exporter:latest
    container_name: your_postgres_exporter
    environment:
      DATA_SOURCE_NAME: "postgresql://user:pass@postgres:5432/dbname?sslmode=disable"
    ports:
      - "9187:9187"
    depends_on:
      - postgres
```

Then uncomment postgres-exporter section in `prometheus/prometheus.yml` and update the target IP.

## 🎯 Dashboards

### System Dashboard
- CPU usage gauge and trends
- Memory usage monitoring
- Disk space and I/O metrics
- Network traffic analysis
- System load and uptime

## 🔔 Alerts

Pre-configured alerts for:

**System:**
- High CPU usage (>80%)
- High memory usage (>90%)
- Low disk space (>90% used)
- High system load
- Service availability

## 🛠️ Commands

```bash
# Start services
make start

# Stop services
make stop

# Check health
make health

# View logs
make logs

# Clean up everything
make clean
```

## 📁 Project Structure

```
postgresql-monitoring-stack/
├── docker-compose.yml          # Main monitoring stack
├── .env.example               # Environment variables template
├── prometheus/
│   ├── prometheus.yml         # Prometheus configuration
│   └── rules/                 # Alert rules
├── grafana/
│   ├── provisioning/          # Grafana provisioning
│   └── dashboards/            # Pre-built dashboards
└── scripts/
    └── setup.sh               # Setup script
```

## 🔧 Extending Monitoring

### Add Database Monitoring:
1. Add exporter to your database compose
2. Uncomment relevant section in `prometheus.yml`
3. Update target IP/port
4. Import relevant Grafana dashboards

### Add Custom Metrics:
1. Add new scrape job in `prometheus.yml`
2. Create custom dashboard in `grafana/dashboards/`
3. Add alert rules in `prometheus/rules/`

## 🚀 Production Recommendations

1. **Security**: Change default Grafana password
2. **Storage**: Use external volumes for data persistence
3. **Networking**: Use reverse proxy for external access
4. **Backup**: Regular backup of Grafana dashboards
5. **Monitoring**: Monitor the monitoring stack itself

---

**Focus**: System monitoring with extensible architecture for database monitoring