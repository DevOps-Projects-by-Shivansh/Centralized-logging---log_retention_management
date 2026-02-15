#!/bin/bash

RESOURCE_GROUP="my-resource-group"
WORKSPACE_NAME="my-log-workspace"

echo "Setting retention to 90 days..."

az monitor log-analytics workspace update \
  --resource-group $RESOURCE_GROUP \
  --workspace-name $WORKSPACE_NAME \
  --retention-time 90

echo "Retention policy updated."
