# Grafana + Prometheus Docker Stack

A lightweight monitoring stack for VPS or bare-metal servers using **Docker Compose**.  
Includes **Prometheus** for metrics storage, **Node Exporter** for host metrics, and **Grafana** for visualization — all with persistent volumes and sensible defaults.

A bootstrap script is provided to minimize manual setup by installing Docker, preparing configs, and launching the stack automatically.

---

## ✨ Features
- Prometheus with persistent TSDB volume (`prometheus_data`)
- Node Exporter scraping host metrics via `/host` mount
- Grafana with persisted dashboards and users (`grafana_data`)
- Default ports:
  - Grafana: **3000**
  - Prometheus: **9090**
  - Node Exporter: **9100**
- One-command setup script for Ubuntu-based servers

---

## 📦 Prerequisites
- Ubuntu-based VPS or server
- Internet access
- A **non-root user** with `sudo` privileges
- Ports **3000**, **9090**, and **9100** open (UFW / cloud firewall)

> Docker and Docker Compose do NOT need to be preinstalled — the script handles it.

---

## 🚀 Step-by-Step Setup

### 1. Clone the Repository
```bash
git clone https://github.com/kev1nandreas/grafana-setup-vps-dockerize.git
cd grafana-setup-vps-docker
```

---

### 2️. Make the Setup Script Executable
```bash
chmod +x setup.sh
```

---

### 3. Run the Setup Script
```bash
./setup.sh /opt
```

*Note: Change `/opt` with current working directory*

This script will:
- Install Docker and Docker Compose
- Create `/opt/monitoring`
- Generate a default `prometheus.yml`
- Start the stack using Docker Compose:

---

## ✅ Verify Services

Open:
```
http://YOUR_VPS_IP:3000
```

Default credentials:
```
username: admin
password: admin
```

⚠️ Change the password after first login.

---

## 🔗 Connect Prometheus to Grafana
1. Grafana → **Settings → Data Sources**
2. Click **Add data source**
3. Select **Prometheus**
4. URL:
```
http://prometheus:9090
```
5. Click **Save & Test** → ✅

---

## 📈 Import VPS Dashboard
1. Grafana → **Dashboards → Import**
2. Dashboard ID (Most Used Dashboard For Full Analytics):
```
1860
```
3. Select **Prometheus** datasource
4. Click **Import**
