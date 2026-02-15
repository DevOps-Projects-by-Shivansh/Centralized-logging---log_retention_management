#!/bin/bash

RESOURCE_GROUP="my-resource-group"
WORKSPACE_NAME="my-log-workspace"
ACTION_GROUP_NAME="email-action-group"

WORKSPACE_ID=$(az monitor log-analytics workspace show \
  --resource-group $RESOURCE_GROUP \
  --workspace-name $WORKSPACE_NAME \
  --query id -o tsv)

echo "Creating disk space alert..."

az monitor scheduled-query create \
  --name "LowDiskSpaceAlert" \
  --resource-group $RESOURCE_GROUP \
  --scopes $WORKSPACE_ID \
  --condition "count 'Perf | where CounterName == \"% Free Space\" and CounterValue < 15' > 0" \
  --description "Alert when disk free space <15%" \
  --evaluation-frequency 5m \
  --window-size 5m \
  --severity 2 \
  --action-group $ACTION_GROUP_NAME

echo "Disk alert created."
