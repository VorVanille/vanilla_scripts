#!/usr/bin/env bash
#
#Copyright (c) VanillaNexus
#
#Credit to Nathan for the help
#This script will hold our mess of variables.

SOURCE_DIR="${HOME}/VorVanille"
OUT_DIR="${SOURCE_DIR}/out/target/product"
DATE=$(date +"%m-%d")
VANILLA_OUT="${HOME}/Vanilla_Out"
CURRENT_VERSION="8.0.0"
VANILLA_OUT_DATE="${VANILLA_OUT}/${DATE}"
VANILLA_OUT_FOLDER=${VANILLA_OUT_DATE}
BOLD="\033[1m"
BLUE="\033[0;36m"
BLUEBOLD="\033[1;34m"
REDBOLD="\033[1;31m"
GREENBOLD="\033[1;32m"
RESTORE="\033[0m"
REPO_SYNC="repo sync"
RSFLAGS="-j$( nproc --all ) --force-sync -c --no-clone-bundle --no-tags --optimized-fetch --prune"