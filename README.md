# Grafana + Prometheus Docker Stack

A lightweight monitoring stack for VPS or bare-metal hosts using Docker Compose. It includes Prometheus for metrics storage, Node Exporter for host metrics, and Grafana for dashboards— all with persistent volumes and sensible defaults. The included script minimizes manual setup time by installing Docker, wiring configs, and starting the stack for you.

## Features
- Prometheus with persistent TSDB volume mapped to `prometheus_data`
- Node Exporter scraping host metrics via `/host` mount
- Grafana with persisted dashboards/users via `grafana_data`
- Default ports: Grafana `3000`, Prometheus `9090`, Node Exporter `9100`
- Simple bootstrap script for Ubuntu-based servers

## Prerequisites
- Docker and Docker Compose installed (script will install on Ubuntu)
- Open inbound access to ports 3000/9090/9100 as needed
- A non-root user with `sudo` rights (for running the setup script)

## 🚀 Quick Setup
Use the script to install Docker, Docker Compose, and launch the stack on Ubuntu. Replace `/opt` with your desired base directory:
```bash
chmod +x setup.sh
./setup.sh /opt
```
The script will:
- Install Docker and Docker Compose
- Create `/opt/monitoring` with a Prometheus config
- Launch the stack via `docker-compose -f /opt/grafana-setup-vps-docker/docker-compose.yml up -d`

> Note: Adjust the repo path in `setup.sh` if your folder name differs (e.g., `grafana-setup-vps-dockerize`).

## ✅ Verify Services
1) Prometheus: http://YOUR_VPS_IP:9090 → Status → Targets → `node_exporter` should be UP
2) Grafana: http://YOUR_VPS_IP:3000 → login with `admin` / `admin` (change after first login)

## 🔗 Connect Prometheus to Grafana
Grafana → Settings → Data Sources → Add Prometheus → URL: `http://prometheus:9090` → Save & Test ✅

## 📊 Import VPS Dashboard
Grafana → Dashboards → Import → Dashboard ID: `1860` → Select Prometheus datasource → Import 🎉

## Configuration
- Prometheus scrape targets: defined in `prometheus/prometheus.yml` (mounted into the container).
- Volumes: `prometheus_data` and `grafana_data` keep data across restarts.
- To add more exporters/targets, edit `prometheus.yml` and reload Prometheus or restart the stack.
