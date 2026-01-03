# !/bin/bash

BASE_WORKING_DIR=$1

# Install Docker and Docker Compose
sudo apt update
sudo apt install -y docker.io docker-compose
echo "🟢 Docker and Docker Compose installed."

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker
echo "🟢 Docker service started."

# Make Directory for Monitoring
mkdir -p $BASE_WORKING_DIR/monitoring
cd $BASE_WORKING_DIR/monitoring
echo "🟢 Created monitoring directory at $BASE_WORKING_DIR/monitoring."

# Create Prometheus Data Directory
mkdir -p $BASE_WORKING_DIR/monitoring/prometheus
echo "🟢 Created Prometheus data directory at $BASE_WORKING_DIR/monitoring/prometheus."

# Copy Prometheus Configuration File
cp $BASE_WORKING_DIR/grafana-setup-vps-dockerize/prometheus.yml $BASE_WORKING_DIR/monitoring/prometheus/prometheus.yml
echo "🟢 Copied Prometheus configuration file to $BASE_WORKING_DIR/monitoring/prometheus/prometheus.yml."

# Run Docker Compose to Set Up Monitoring Stack
docker-compose -f $BASE_WORKING_DIR/grafana-setup-vps-dockerize/docker-compose.yml up -d
echo "🟢 Monitoring stack is set up and running in detached mode."