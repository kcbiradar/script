#!/bin/bash

set -e
set -o pipefail

REPO_URL="https://github.com/kcbiradar/script.git"
CLONE_DIR="script"
APP_DIR="script/fastapi-app"

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Will be set to either 'docker compose' or 'docker-compose'
DOCKER_COMPOSE_CMD=""

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

function resolve_docker_compose_command() {
    if command -v docker-compose >/dev/null 2>&1; then
        DOCKER_COMPOSE_CMD="docker-compose"
    elif docker compose version >/dev/null 2>&1; then
        DOCKER_COMPOSE_CMD="docker compose"
    else
        echo -e "${RED}❌ Neither 'docker-compose' nor 'docker compose' is available.${NC}"
        exit 1
    fi
}

function clone_repo() {
    if [ -d "$CLONE_DIR" ]; then
        echo -e "${GREEN}✔ Repo already exists. Pulling latest changes...${NC}"
        cd "$CLONE_DIR"
        git pull
        cd ..
    else
        echo -e "${GREEN}➡ Cloning FastAPI app repo...${NC}"
        git clone "$REPO_URL"
    fi
}

function build_docker() {
    echo -e "${GREEN}➡ Building Docker image...${NC}"
    cd "$APP_DIR"
    $DOCKER_COMPOSE_CMD build
}

function run_docker() {
    echo -e "${GREEN}➡ Running app with Docker Compose...${NC}"
    $DOCKER_COMPOSE_CMD up -d
}

function verify_app() {
    echo -e "${GREEN}✔ FastAPI is live: http://localhost:8000${NC}"
    echo -e "${GREEN}➡ Test it: curl http://localhost:8000${NC}"
}

# ---------------- Main ---------------- #

echo -e "${GREEN}🚀 Starting FastAPI Docker Deployment...${NC}"

check_command git
check_command docker
ensure_docker_running
resolve_docker_compose_command
clone_repo
build_docker
run_docker
verify_app
