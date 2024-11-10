#!/bin/bash

REMOTE_USER=$REMOTE_USER
REMOTE_HOST=$REMOTE_HOST
REMOTE_PATH=$REMOTE_PATH
DOCKER_COMPOSE_FILE="docker-compose.dev.yaml"

echo "Copying files to remote server..."
scp -o StrictHostKeyChecking=no -r -q * "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

echo "Restarting containers..."
ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_HOST" << EOF
    cd $REMOTE_PATH
    
    echo "Stopping containers..."
    docker compose -f $DOCKER_COMPOSE_FILE down > /dev/null 2>&1
    
    echo "Removing useless images..."
    docker image prune -f > /dev/null 2>&1
    
    echo "Rebuilding and starting new containers..."
    docker compose -f $DOCKER_COMPOSE_FILE up -d --build > /dev/null 2>&1
EOF

echo "Deploying complete!"
