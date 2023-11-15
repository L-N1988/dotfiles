#!/bin/sh -e

set -e

rand=$(date '+%F-%T') 
cp ~/shotfig.png ./$rand.png 
echo -n $rand.png
