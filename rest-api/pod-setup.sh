#!/bin/bash

set -e

# Podman
POD_NAME=rest-api
CONTAINER_MONGO=$POD_NAME-mongo
CONTAINER_API=$POD_NAME-server

# API
API_PORT=9000
API_URL=http://localhost:$API_PORT/v2
API_CONTENT_TYPE=application/json
API_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJsb2NhbGhvc3QiLCJleHAiOjE1NzE1Mzc0ODAsImlhdCI6MTU3MTUzNTY4MCwiaXNzIjoibWFpbEBtb3JwaHkyay5kZXYiLCJzdWIiOiI1ZGFiYmE3MDdkZjcyMGEzOTdhZjIxMjAiLCJzY29wZSI6WyJyZWFkOmFsbCIsIndyaXRlOmFsbCJdfQ.3pfJ4-nykKrEcPiCGQR9aODj-ifV51aRbkGFFHBLHl8"

# Misc
MONGODUMP_FILE=rest-api.archive

# Check prerequisites
if ! [ -x "$(command -v podman)" ]; then
  echo "Podman is not installed!"
  exit 1
fi

if ! [ -x "$(command -v curl)" ]; then
  echo "curl is not installed!"
  exit 1
fi

if ! [ -x "$(command -v jq)" ]; then
  echo "JQ is not installed!"
  exit 1
fi

# Set up pod
echo "Set setup API server..."

podman play kube rest-api-pod.yaml

podman cp $MONGODUMP_FILE $CONTAINER_MONGO:/$MONGODUMP_FILE

podman exec $CONTAINER_MONGO sh -c "exec mongorestore --gzip --archive=$MONGODUMP_FILE"

# Verify pod
echo "
Check API server..."

API_TOKEN=$(curl -s -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: $API_CONTENT_TYPE" "$API_URL/token" | jq -r '.token')
ITEMS=$(curl -s -H "Authorization: Bearer $API_TOKEN" -H "Content-Type: $API_CONTENT_TYPE" "$API_URL/item" | jq -r '.total')

if ! (( $ITEMS > 0 )); then
  echo "Oh oh, something went wrong! :-("
  exit 1
fi

echo "
Setup successful! The API is now accessible via $API_URL"
echo "Your API token: $API_TOKEN"
