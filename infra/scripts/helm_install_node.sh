#!/bin/sh

# This script assumes that kubectl config has been set to the correct cluster

# This script installs the helm chart for the node app

helm install -f../helm/Chart.yaml node ../helm