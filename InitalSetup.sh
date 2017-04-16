#!/usr/bin/env bash
#
#Copyright (c) VanillaNexus
#
#Credit to Nathan for the help
#This script will initalize the repo and then sync the current version

# Source our variables script.
source $( dirname ${BASH_SOURCE} )/variables.sh

DISTRO=${1}
BOPT=${2}
BNAME=${3}

  #Creates a out directory if missing
if [[ ! -d "${SOURCE_DIR}" ]]; then
   mkdir -p "${SOURCE_DIR}"
fi

if [[ ${DISTRO} = "ubuntu" ]]; then
  echo -e ${BLUEBOLD}"Installing req. packages for ${DISTRO}"
  cd ${HOME}
  git clone https://github.com/akhilnarang/scripts
  cd scripts
  bash ubuntu1604linuxmint18.sh
  echo -e ${RESTORE}
elif [[ ${DISTRO} = "mint" ]]; then
  echo -e ${BLUEBOLD}"Installing req. packages for ${DISTRO}"
  cd ${HOME}
  git clone https://github.com/akhilnarang/scripts
  cd scripts
  bash ubuntu1604linuxmint18.sh
  echo -e ${RESTORE}
elif [[ ${DISTRO} = "deepin" ]]; then
  echo -e ${BLUEBOLD}"Installing req. packages for ${DISTRO}"
  git clone https://github.com/akhilnarang/scripts
  cd scripts
  bash ubuntu1604linuxmint18.sh
  cd utils
  echo -e "Installing repo"
  sudo install repo /usr/bin/
  echo -e "Installing ccache"
  sudo install ccache /usr/bin/
  echo -e "Installing ninja 1.7.2, please make sure your ROM includes the commit to use host ninja"
  sudo install ninja /usr/bin/
  echo -e ${RESTORE}
elif [[ ${DISTRO} = "arch" ]]; then
  echo -e ${BLUEBOLD}"Installing req. packages for ${DISTRO}"
  git clone https://github.com/akhilnarang/scripts
  cd scripts
  bash arch-manjaro-apricity-build-environment-setup.sh
  echo -e ${RESTORE}
elif [[ ${DISTRO} = "manjaro" ]]; then
  echo -e ${BLUEBOLD}"Installing req. packages for ${DISTRO}"
  echo -e ${BLUEBOLD}"Installing req. packages for ${DISTRO}"
  git clone https://github.com/akhilnarang/scripts
  cd scripts
  bash arch-manjaro-apricity-build-environment-setup.sh
  echo -e ${RESTORE}
elif [[ ${DISTRO} = "none" ]]; then
  echo -e ${BLUEBOLD}"Installing nothing"
  echo -e ${RESTORE}
else
  echo -e ${REDBOLD}
  echo -e "${DISTRO} is not a real distro/typed incorrectly or not currently supported by the script. Contact Skye for help."
  echo -e ${RESTORE}
fi

if [[ ${2} = "current" ]]; then
  BRANCH=${CURRENT_VERSION}
else
  BRANCH=${3}
fi

cd ${SOURCE_DIR}
REPO_INIT="repo init"
RIFLAGS="-u https://github.com/VanillaNexusSource/android_manifest -b ${BRANCH} --no-clone-bundle"

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