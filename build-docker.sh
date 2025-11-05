#!/bin/bash

# Docker build script for simple-java-maven-app
# Works on Linux/Mac with bash

# Configuration
IMAGE_NAME="simple-java-maven-app"
IMAGE_TAG="latest"
DOCKER_REGISTRY="" # Leave empty for local, or add your registry (e.g., "docker.io/username")

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Building Docker Image${NC}"
echo -e "${BLUE}========================================${NC}"

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo -e "${RED}Error: Docker is not installed or not in PATH${NC}"
    exit 1
fi

# Build the Docker image
echo -e "${GREEN}Building image: ${IMAGE_NAME}:${IMAGE_TAG}${NC}"
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}Build successful!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo -e "Image: ${IMAGE_NAME}:${IMAGE_TAG}"
    echo ""
    echo "To run the container:"
    echo "  docker run -d -p 8080:8080 --name my-java-app ${IMAGE_NAME}:${IMAGE_TAG}"
    echo ""
    echo "To view logs:"
    echo "  docker logs my-java-app"
    echo ""
    echo "To stop the container:"
    echo "  docker stop my-java-app"
    echo ""
    echo "To remove the container:"
    echo "  docker rm my-java-app"
else
    echo -e "${RED}Build failed!${NC}"
    exit 1
fi