#!/bin/bash

RESOURCE_GROUP="my-resource-group"
WORKSPACE_NAME="my-log-workspace"
STORAGE_ACCOUNT="mystorageaccount"
CONTAINER_NAME="log-archive"
QUERY="AzureActivity | where TimeGenerated > ago(1d)"

echo "Exporting logs..."

az monitor log-analytics query \
  --workspace $WORKSPACE_NAME \
  --analytics-query "$QUERY" \
  --out json > exported_logs.json

echo "Uploading logs to archive storage..."

az storage blob upload \
  --account-name $STORAGE_ACCOUNT \
  --container-name $CONTAINER_NAME \
  --name "logs_$(date +%F).json" \
  --file exported_logs.json \
  --auth-mode login

echo "Logs archived successfully."
