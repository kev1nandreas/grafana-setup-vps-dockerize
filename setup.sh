#!/bin/bash

set -e

BASE_WORKING_DIR="$1"
REPO_DIR="$BASE_WORKING_DIR/grafana-setup-vps-dockerize"
MONITORING_DIR="$BASE_WORKING_DIR/monitoring"

# Validate argument
if [ -z "$BASE_WORKING_DIR" ]; then
  echo "❌ Error: BASE_WORKING_DIR argument is required"
  echo "Usage: ./setup-monitoring.sh /absolute/path"
  exit 1
fi

echo "📂 Base working directory: $BASE_WORKING_DIR"

# Install Docker and Docker Compose
sudo apt update
sudo apt install -y docker.io docker-compose
echo "🟢 Docker and Docker Compose installed."

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker
echo "🟢 Docker service started."

# Create Monitoring directories
mkdir -p "$MONITORING_DIR/prometheus"
echo "🟢 Created monitoring directory at $MONITORING_DIR."

# Move Prometheus configuration file
if [ ! -f "$REPO_DIR/prometheus.yml" ]; then
  echo "❌ Error: prometheus.yml not found in cloned repo"
  exit 1
fi

mv "$REPO_DIR/prometheus.yml" \
   "$MONITORING_DIR/prometheus/prometheus.yml"

echo "🟢 Moved prometheus.yml to $MONITORING_DIR/prometheus/"

# Run Docker Compose
docker-compose -f "$REPO_DIR/docker-compose.yml" up -d
echo "🟢 Monitoring stack is set up and running in detached mode."
