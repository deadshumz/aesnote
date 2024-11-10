#!/bin/bash

REMOTE_USER=$REMOTE_USER
REMOTE_HOST=$REMOTE_HOST
REMOTE_PATH=$REMOTE_PATH
DOCKER_COMPOSE_FILE="docker-compose.dev.yaml"

echo "Copying files to remote server..."
scp -r * "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

echo "Restarting containers..."
ssh "$REMOTE_USER@$REMOTE_HOST" << EOF
    cd $REMOTE_PATH
    
    echo "Stoping containers.."
    docker compose -f $DOCKER_COMPOSE_FILE down
  
    echo "Removing useless images.."
    docker image prune -f
    
    echo "Rebuilding and starting new containers.."
    docker compose -f $DOCKER_COMPOSE_FILE up -d --build
EOF

echo "Deploying complete!"
