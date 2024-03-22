# Kubernetes Monitoring and Observability Setup

This repository provides configuration files and instructions for setting up monitoring and observability tools on Kubernetes clusters. By following these steps, you'll be able to deploy essential components for monitoring your Kubernetes infrastructure and applications effectively.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Components](#components)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Monitoring and observability are crucial aspects of managing and maintaining Kubernetes clusters. This repository simplifies the process of deploying popular monitoring and observability tools such as Prometheus, Grafana, and OpenTelemetry on your Kubernetes clusters.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- A running Kubernetes cluster
- `kubectl` command-line tool installed and configured to interact with your cluster
- `helm` command-line tool installed (version 3.x)
- Internet connectivity from your Kubernetes cluster

## Installation

To install the monitoring and observability components, follow these steps:

1. Apply ClickHouse Operator:
    ```bash
    kubectl apply -f https://raw.githubusercontent.com/Altinity/clickhouse-operator/master/deploy/operator/clickhouse-operator-install-bundle.yaml
    ```

2. Apply Cert-Manager:
    ```bash
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml
    ```

3. Add Prometheus Community Helm repository:
    ```bash
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    ```

4. Install kube-prometheus-stack using Helm:
    ```bash
    helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack
    ```

5. Add OpenTelemetry Helm repository:
    ```bash
    helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
    helm repo update
    ```

6. Apply ClickHouse configuration:
    ```bash
    kubectl apply -f clickhouse.yaml
    ```

7. Install OpenTelemetry Operator:
    ```bash
    helm install opentelemetry-operator open-telemetry/opentelemetry-operator
    ```

8. Apply OpenTelemetry configuration:
    ```bash
    kubectl apply -f otel.yaml
    ```

9. Install OpenTelemetry eBPF:
    ```bash
    helm install opentelemetry-ebpf open-telemetry/opentelemetry-operator-ebpf --values ./ebpf.yaml
    ```

## Components

This setup includes the following components:

- **ClickHouse Operator**: For managing ClickHouse clusters.
- **Cert-Manager**: For managing TLS certificates.
- **Prometheus**: For monitoring Kubernetes clusters.
- **Grafana**: For visualization and dashboarding.
- **OpenTelemetry Operator**: For collecting telemetry data from applications.
- **OpenTelemetry eBPF**: For collecting high-resolution metrics using eBPF technology.

## Usage

Once the installation is complete, you can access Grafana to view dashboards and Prometheus for querying metrics. Additional configurations can be done as per your requirements to customize monitoring and observability for your Kubernetes environment.

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests if you have any suggestions or improvements.

## License

This project is licensed under the [MIT License](LICENSE).
