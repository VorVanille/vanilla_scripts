#!/usr/bin/env bash
#
#Copyright (c) VanillaNexus
#
#Credit to Nathan for the help
#This script will hold our mess of variables.

if [[ ${BRANCH} = "8.0.0" ]]; then
  SOURCE_DIR="${HOME}/VorVanille"
else
  SOURCE_DIR="${HOME}/Vanilla"
fi
CURRENT_VERSION="8.0.0"
BOLD="\033[1m"
BLUE="\033[0;36m"
BLUEBOLD="\033[1;34m"
REDBOLD="\033[1;31m"
RESTORE="\033[0m"
REPO_SYNC="repo sync"
RSFLAGS="-j$( nproc --all ) --force-sync -c --no-clone-bundle --no-tags --optimized-fetch --prune"
REPO_INIT="repo init"
if [[ ${BRANCH} = "8.0.0" ]]; then
  RIFLAGS="-u https://github.com/VorVanille/android_manifest -b ${BRANCH} --no-clone-bundle"
else
   RIFLAGS="-u https://github.com/VanillaNexusSource/android_manifest -b ${BRANCH} --no-clone-bundle"
fi