#!/bin/bash

#######################
# Author: Khaju Biradar
# Date Jun 20, 2025
#
# This script outputs the node health
#######################

# set -x #debug mode
# set -e # exit the script when there is an error
# set -o pipefail 

df -h

free -g

nproc

ps -ef | grep brave | awk -F" " '{print $2}'


