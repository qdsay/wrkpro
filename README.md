# wrkpro

First, install wrk, and then create a log directory  
Edit hosts.txt and paths.txt using your own configuration
for example:  

```
mkdir log //output path
./wrk.sh -c 20 -t 50 -d 120s -s wrkpro.lua //
```
