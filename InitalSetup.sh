#!/usr/bin/env bash
#
#Copyright (c) VanillaNexus
#
#Credit to Nathan for the help
#This script will initalize the repo and then sync the current version

# Source our variables script.
source $( dirname ${BASH_SOURCE} )/variables.sh

BOPT=${1}
BNAME=${2}

  #Creates a out directory if missing
if [[ ! -d "${SOURCE_DIR}" ]]; then
   mkdir -p "${SOURCE_DIR}"
fi

if [[ ${2} = "current" ]]; then
  BRANCH=${CURRENT_VERSION}
else
  BRANCH=${2}
fi

cd ${SOURCE_DIR}
echo -e ${BLUEBOLD}
echo -e  "-----------"
echo -e  "Initalizing"
echo -e "-----------"
echo -e ${BLUE}

${REPO_INIT} ${RIFLAGS}

echo -e ${BLUEBOLD}
echo -e  "-------"
echo -e  "Syncing"
echo -e "--------"
echo -e ${BLUE}

${REPO_SYNC} ${RSFLAGS}

echo -e ${BLUEBOLD}
echo -e  "--------------"
echo -e  "Finished Enjoy"
echo -e "---------------"
echo -e ${RESTORE}