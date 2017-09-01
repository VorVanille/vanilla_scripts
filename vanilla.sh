#!/usr/bin/env bash
#
# Copyright (c) Vanilla
#
# Credit to Nathan for the help
# This script will initalize the repo and then sync the current version
#
# USAGE: bash vanilla.sh <ram> <sync/nosync> <clean/noclean> <device> <public/nopublic>

# Source our variables script.
source $( dirname ${BASH_SOURCE} )/variables.sh

RAM=${1}
SYNC=${2}
CLEAN=${3}
DEVICE=${4}
PUBLIC=${5}

if [[ ${RAM} -le 5 ]]; then
  echo -e ${REDBOLD}"SHIT OUTTA LUCK"
  echo -e ${RESTORE}
elif [[ ${RAM} -eq 6 ]]; then
  echo -e ${BLUEBOLD}
  echo -e "Jack is using 5 GB of ram"
  echo -e ${RESTORE}
  export ANDROID_JACK_VM_ARGS="-Xmx5g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
elif [[ ${RAM} -eq 8 ]]; then
  echo -e ${BLUEBOLD}
  echo -e "Jack is using 6 GB of ram"
  echo -e ${RESTORE}
  export ANDROID_JACK_VM_ARGS="-Xmx6g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
elif [[ ${RAM} -eq 12 ]]; then
  echo -e ${BLUEBOLD}
  echo -e "Jack is using 8 GB of ram"
  echo -e ${RESTORE}
  export ANDROID_JACK_VM_ARGS="-Xmx8g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
elif [[ ${RAM} -eq 16 ]]; then
  echo -e ${BLUEBOLD}
  echo -e "Jack is using 12 GB of ram"
  echo -e ${RESTORE}
  export ANDROID_JACK_VM_ARGS="-Xmx12g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
elif [[ ${RAM} -ge 32 ]]; then
  echo -e ${BLUEBOLD}
  echo -e "Jack is using 16 GB of ram"
  echo -e ${RESTORE}
   export ANDROID_JACK_VM_ARGS="-Xmx16g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
elif
  echo -e ${BLUEBOLD}
  echo -e "Fuck jack amirite?"
  echo -e ${RESTORE}
  export ANDROID_COMPILE_WITH_JACK="false"
else
  echo -e ${BLUEBOLD}
  echo -e "Jack is using 5 GB of ram by default"
  echo -e ${RESTORE}
  export ANDROID_JACK_VM_ARGS="-Xmx5g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"
fi

# Runs a repo sync
if [[ ${SYNC} = "sync" ]]; then
  echo -e ${BLUEBOLD}
  echo -e  "-------"
  echo -e  "Syncing"
  echo -e "--------"
  echo -e ${BLUE}
  ${REPO_SYNC} ${RSFLAGS}
fi

# Switches between public and snapshot builds
if [[ ${PUBLIC} = "public" ]]; then
  export PUBLIC=true
else
  export PUBLIC=false
fi

# Starts up the build script
cd ${SOURCE_DIR}
. build/envsetup.sh

# Selects the device to use
echo -e ${BLUE}
lunch vanilla_${DEVICE}-userdebug
echo -e ${RESTORE}

# Clean the out directory
if [[ ${CLEAN} = "clean" ]]; then
  mka clobber
else
  mka installclean
fi

# Start the build
mka vanilla
./prebuilts/sdk/tools/jack-admin kill-server
# Was it succesful?
FILES=$( ls ${OUT_DIR}/${DEVICE}/*.zip 2>/dev/null | wc -l )
if [[ ${FILES} != 0 ]]; then
  BUILD_RESULT="S"
  SUCCESS=true
        
# Creates a out directory if missing
if [[ ! -d "${VANILLA_OUT_FOLDER}" ]]; then
   mkdir -p "${VANILLA_OUT_FOLDER}"
fi
  
# Copies the zip and md5sum to Vanilla_Out
  echo -e ${BLUEBOLD}
  echo -e  "---------------------------"
  echo -e  "Moving files to Vanilla_Out"
  echo -e "---------------------------"
  echo -e ${BLUE}
  cd ${VANILLA_OUT}
  for FILE in $( ls ${OUT_DIR}/${DEVICE}/*.zip* | grep -v ota ); do
     mv -v "${FILE}" "${VANILLA_OUT_FOLDER}"
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
    echo -e ${BLUEBOLD}"FILE LOCATION: $( ls ${VANILLA_OUT_FOLDER}/*.zip )"
    echo -e "SIZE: $( du -h ${VANILLA_OUT_FOLDER}/*.zip | awk '{print $1}' )"
fi
