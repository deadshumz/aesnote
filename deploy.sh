#!/bin/bash

REMOTE_USER=$REMOTE_USER
REMOTE_HOST=$REMOTE_HOST
REMOTE_PATH=$REMOTE_PATH
DOCKER_COMPOSE_FILE="docker-compose.dev.yaml"

echo "Copying files to remote server..."
<<<<<<< HEAD
scp -r * "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

echo "Restarting containers..."
ssh "$REMOTE_USER@$REMOTE_HOST" << EOF
    cd $REMOTE_PATH
    
    echo "Stoping containers.."
    docker compose -f $DOCKER_COMPOSE_FILE down
  
    echo "Removing useless images.."
    docker image prune -f
    
    echo "Rebuilding and starting new containers.."
=======
scp -o StrictHostKeyChecking=no -r * "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

echo "Restarting containers..."
ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_HOST" << EOF
    cd $REMOTE_PATH
    
    echo "Stopping containers..."
    docker compose -f $DOCKER_COMPOSE_FILE down
  
    echo "Removing useless images..."
    docker image prune -f
    
    echo "Rebuilding and starting new containers..."
>>>>>>> 92d7513 (ci: fix deploy sh)
    docker compose -f $DOCKER_COMPOSE_FILE up -d --build
EOF

echo "Deploying complete!"
