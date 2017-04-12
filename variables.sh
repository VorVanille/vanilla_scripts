#!/usr/bin/env bash
#
#Copyright (c) VanillaNexus
#
#Credit to Nathan for the help
#This script will hold our mess of variables.

SOURCE_DIR="${HOME}/Vanilla"
OUT_DIR="${SOURCE_DIR}/out/target/product/"
VANILLA_OUT="${HOME}/Vanilla_Out"
DATE=$(date +"%m-%d")
CURRENT_VERSION="7.1.2"
BOLD="\033[1m"
BLUE="\033[0;36m"
BLUEBOLD="\033[1;34m"
REDBOLD="\033[1;31m"
GREENBOLD="\033[1;32m"
RESTORE="\033[0m"
REPO_SYNC="repo sync"
RSFLAGS="-j$( nproc --all ) --force-sync -c --no-clone-bundle --no-tags --optimized-fetch --prune"