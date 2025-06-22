#!/bin/bash

###############
# Author: Khaju Biradar
# Date: Jun 22, 2025
# This script helps us to understand API connection downtimes
################

GREEN='\033[0;32m'
RED='\033[0;31m'

set -e

echo "Staging APIs..."

echo -e "${GREEN}\n\nSTAGING: Checking my-api connection:"
curl -s -X GET https://test-myapi.inspecthoa.com/health

echo -e "${RED}\n\nSTAGING: Checking ihoa-ai-service connection:"
curl -s -X GET https://ihoa-ai-service-staging.ihoa.link/health

echo -e "${GREEN}\n\nSTAGING: Checking agent-one connection:"
curl -s -X GET https://agent-one-staging.ihoa.link/api/v1/health

echo -e "${RED}\n\nSTAGING: Checking file-processing connection:"
curl -s -X GET https://files-processing-staging.ihoa.link/api/v1/health

echo -e "${GREEN}\n\nSTAGING: Checking agent-max connection:"
curl -s -X GET https://agent-max-staging.ihoa.link/api/v1/health

echo -e "\n\nProduction APIs..."

echo -e "${RED}\n\nPRODUCTION: Checking my-api connection:"
curl -s -X GET https://myapi.inspecthoa.com/health

echo -e "${GREEN}\n\nPRODUCTION: Checking ihoa-ai-service connection:"
curl -s -X GET https://ihoa-ai-service.ihoa.link/health

echo -e "${RED}\n\nPRODUCTION: Checking agent-one connection:"
curl -s -X GET https://agent-one.ihoa.link/api/v1/health

echo -e "${GREEN}\n\nPRODUCTION: Checking file-processing connection:"
curl -s -X GET https://files-processing.ihoa.link/api/v1/health

echo -e "${RED}\n\nPRODUCTION: Checking agent-max connection"
curl -s -X GET https://agent-max.ihoa.link/api/v1/health

echo -e "${GREEN}\n\nDone!!!"

