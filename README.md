<center><img src="https://s8.hostingkartinok.com/uploads/images/2017/03/b7c601dacee73c8f46cb95899ec9301b.png" height="100%" width="100%;"/></center>

### Lets document what these scripts do ###

## variables.xml ##
variables.xml is a script that holds our variables. 

In the current version nothing in there NEEDS to be edited unless you want to play around with colors

In later versions of this script that might change.

## InitalSetup.sh ##
This is our script that inatilizes ans syncs the repo.

To get the most current branches synced run:
```bash
bash rinit/InitalSetup.sh current
```
To get an older version synced run: 
```bash
bash rinit/InitalSetup.sh legacy <N1/7.1.2>
```
N1 is our 7.1.1 branch

7.1.2 is our 7.1.2 branch

Note: DO NOT just run n1/7.1.2 this is a choice

An example would be:
```bash
bash rinit/InitalSetup.sh legacy N1
```