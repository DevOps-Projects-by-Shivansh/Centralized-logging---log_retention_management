#!/bin/bash

RESOURCE_GROUP="my-resource-group"
WORKSPACE_NAME="my-log-workspace"
SUBSCRIPTION_ID="your-subscription-id"
ACTION_GROUP_NAME="email-action-group"

WORKSPACE_ID=$(az monitor log-analytics workspace show \
  --resource-group $RESOURCE_GROUP \
  --workspace-name $WORKSPACE_NAME \
  --query id -o tsv)

echo "Creating 5xx error alert..."

az monitor scheduled-query create \
  --name "High5xxErrorAlert" \
  --resource-group $RESOURCE_GROUP \
  --scopes $WORKSPACE_ID \
  --condition "count 'AzureDiagnostics | where StatusCode startswith \"5\"' > 10" \
  --description "Alert when 5xx errors exceed 10 in 5 minutes" \
  --evaluation-frequency 5m \
  --window-size 5m \
  --severity 2 \
  --action-group $ACTION_GROUP_NAME

echo "Alert created successfully."
