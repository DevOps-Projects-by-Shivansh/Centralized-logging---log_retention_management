#!/bin/bash

RESOURCE_GROUP="my-resource-group"
ACTION_GROUP_NAME="email-action-group"
EMAIL="your-email@example.com"

az monitor action-group create \
  --name $ACTION_GROUP_NAME \
  --resource-group $RESOURCE_GROUP \
  --short-name "OpsEmail" \
  --action email ops-alert $EMAIL

echo "Action group created."
