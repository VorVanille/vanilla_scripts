<center><img src="https://s8.hostingkartinok.com/uploads/images/2017/03/b7c601dacee73c8f46cb95899ec9301b.png" height="100%" width="100%;"/></center>

# Lets document what these scripts do #

## This is our 7.1.1 branch ##

## variables.xml ##
variables.xml is a script that holds our variables. 

In the current version nothing in there NEEDS to be edited unless you want to play around with colors

In later versions of this script that might change.

## InitalSetup.sh ##
This is our script that inatilizes ans syncs the repo.

To get the 7.1.1 branch synced run:
```bash
bash rinit/InitalSetup.sh legacy N1
```

## vanilla.sh ##
vanilla.sh is our building script

This script has many features.

The command looks like
```bash
bash scripts/vanilla.sh <sync/nosync> <clean/noclean> <device> <pixel/nopixel> <public/nopublic>
```

An example of this would be:
```bash
bash scripts/vanilla.sh sync clean angler pixel 
```

Setting sync will sync the repo (always recommended before building)

Setting clean will remove all the junk from the old build(if you have a slow computer we don't recommend doing this often)

Setting device is needed every time. We only have 2 devices offically supported right now

nexus 6= shamu

nexus6p=angler

Setting pixel will build a build with round icons and pixel blue theme

Seting public will change the build version from git-built to public. DO NOT DO THIS. THIS WAS PUT HERE FOR OFFICAL MAINTAINERS. 

If you are knowledgable enough to support a device dm me on telegram or XDA