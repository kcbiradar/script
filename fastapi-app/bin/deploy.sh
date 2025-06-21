#!/bin/bash

set -e
set -o pipefail

REPO_URL="https://github.com/yourusername/fastapi-app.git"
APP_DIR="fastapi-app"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function check_command() {
    command -v "$1" >/dev/null 2>&1 || {
        echo -e "${RED}❌ $1 is not installed.${NC}"
        exit 1
    }
}

function ensure_docker_running() {
    if ! docker info >/dev/null 2>&1; then
        echo -e "${RED}❌ Docker is not running. Please start Docker.${NC}"
        exit 1
    fi
}

function clone_repo() {
    if [ -d "$APP_DIR" ]; then
        echo -e "${GREEN}✔ Repo already exists. Skipping clone.${NC}"
    else
        echo -e "${GREEN}➡ Cloning FastAPI app...${NC}"
        git clone "$REPO_URL"
    fi
}

function build_docker() {
    echo -e "${GREEN}➡ Building Docker image...${NC}"
    cd "$APP_DIR"
    docker-compose build
}

function run_docker() {
    echo -e "${GREEN}➡ Running app with Docker Compose...${NC}"
    docker-compose up -d
}

function verify_app() {
    echo -e "${GREEN}✔ FastAPI is live: http://localhost:8000${NC}"
    echo -e "${GREEN}➡ Test it: curl http://localhost:8000${NC}"
}

# ---------------- Main ---------------- #

echo -e "${GREEN}🚀 Starting FastAPI Docker Deployment...${NC}"

check_command git
check_command docker
check_command docker-compose
ensure_docker_running
clone_repo
build_docker
run_docker
verify_app

