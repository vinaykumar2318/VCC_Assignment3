# Auto-Scaling VM on Google Cloud

![Google Cloud](https://img.shields.io/badge/Google_Cloud-4285F4?style=for-the-badge&logo=google-cloud&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)

Automatically create new VMs when CPU utilization exceeds 75% threshold.

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Scripts](#scripts)

## Features
- 🚀 Automatic VM creation on GCP when CPU > 75%
- 🔄 Continuous resource monitoring
- ⚡ Quick deployment with bash scripts
- 📊 Detailed logging system

## Prerequisites
- ✅ Google Cloud account with billing enabled
- ✅ Google Cloud SDK installed (`gcloud`)
- ✅ Service account with Compute Admin permissions
- ✅ Linux/Unix environment for running scripts

## Installation
1. Clone this repository:
```bash
git clone https://github.com/vinaykumar2318/VCC_Assignment3.git
cd auto-scaling-gcp
```

2. Set up Google Cloud authentication:
```bash
gcloud auth login
gcloud config set project YOUR_PROJECT_ID
gcloud auth activate-service-account key.json
```

3. Make scripts executable:
```bash
chmod +x createVm.sh monitorRes.sh
```

## Usage
1. Run the monitoring script:
```bash
./monitorRes.sh
```

2. Increase the CPU load by using stress

## Scripts

### `createVm.sh`
Creates new VM instance on GCP with these default settings:

- **Machine type:** `e2-medium`
- **OS:** Ubuntu 20.04 LTS
- **Network:** Automatic public IP assignment
- **Security:** HTTP/HTTPS firewall rules enabled

### `monitorRes.sh`
Monitors system resources with these behaviors:

- **Frequency:** Checks CPU usage every 60 seconds
- **Scaling Trigger:** Executes `createVm.sh` when CPU > 75%
- **Logging:** Records all activities to `monitor.log`
