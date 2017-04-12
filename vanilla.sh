#!/usr/bin/env bash
#
#Copyright (c) VanillaNexus
#
#Credit to Nathan for the help
#This script will initalize the repo and then sync the current version
#
#USAGE: bash vanilla.sh <sync/nosync> <clean/noclean> <device> <pixel/nopixel> <public/nopublic>

# Source our variables script.
source $( dirname ${BASH_SOURCE} )/variables.sh

DEVICE=${3}

#Runs a repo sync
if [[ ${1} = "sync" ]]; then
  echo -e ${BLUEBOLD}
  echo -e  "-------"
  echo -e  "Syncing"
  echo -e "--------"
  echo -e ${BLUE}
  ${REPO_SYNC} ${RSFLAGS}
fi

#Switches between round icons and regular
if [[ ${4} = "pixel" ]]; then
  export PIXEL=true
else
  export PIXEL=false
fi

#Switches between public and git-built builds
if [[ ${5} = "public" ]]; then
  export PUBLIC=true
else
  export PUBLIC=false
fi

#Starts up the build script
cd ${SOURCE_DIR}
. build/envsetup.sh

#Selects the device to use
echo -e ${BLUE}
lunch vanilla_${3}-userdebug
echo -e ${RESTORE}

#Clean the out directory
if [[ ${2} = "clean" ]]; then
  mka clobber
fi

#Starts the build
# MAKE THE REQUESTED ITEM
mka vanilla
./prebuilts/sdk/tools/jack-admin kill-server
# Was it succesful?
FILES=$( ls ${OUT_DIR}/*.zip 2>/dev/null | wc -l )
if [[ ${FILES} != 0 ]]; then
  BUILD_RESULT="S"
  SUCCESS=true
        
  #Creates a out directory if missing
  if [[ ! -d "${VANILLA_OUT}" ]]; then
     mkdir -p "${VANILLA_OUT}"
  fi
  
  #Copies the zip and md5sum to Vanilla_Out
  echo -e ${BLUEBOLD}
  echo -e  "---------------------------"
  echo -e  "Moving files to Vanilla_Out"
  echo -e "---------------------------"
  echo -e ${BLUE}
  cd ${VANILLA_OUT}
  if [[ ! -d "${DATE}" ]]; then
     mkdir -p "${DATE}}"
  fi
  for FILE in $( ls ${OUT_DIR}/${DEVICE}/*.zip* | grep -v ota ); do
     mv -v "${FILE}" "${VANILLA_OUT}/${DATE}"
  done 

    # Print if it failed
else
  BUILD_RESULT="F"
  SUCCESS=false
fi

if [[ $BUILD_RESULT = "F" ]]; then
  echo -e ${REDBOLD}"Build Failed D:"
  echo -e ${RESTORE}
else
  echo -e ${GREENBOLD}"Build Successful :D"
  echo -e ${RESTORE}
fi

# Ending Info
if [[ ${SUCCESS} = true ]]; then
    echo -e ${BLUEBOLD}"FILE LOCATION: $( ls ${VANILLA_OUT}/${DATE}/*.zip )"
    echo -e "SIZE: $( du -h ${VANILLA_OUT}/${DATE}/*.zip | awk '{print $1}' )"
fi
