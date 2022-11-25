#!/bin/sh

# This script builds and pushes the Docker image to Azure Container Registry.

# The script assumes that the acr is authenticated to using Azure CLI on MacOS
# https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli

docker tag node zxf7yfda.azurecr.io/test/node

docker push zxf7yfda.azurecr.io/test/node
