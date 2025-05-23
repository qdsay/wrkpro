# wrkpro

First, install wrk, and then create a log directory  
Second，edit hosts.txt and paths.txt using your own configuration

Example:  
```
mkdir log //log output path
./wrk.sh -c 20 -t 50 -d 120s -s wrkpro.lua //run
```
