#!/bin/bash

#build
hugo

cd public 
msg="update $(date +"%Y%m%d")"
#add
git add .
if [ $# -eq 1 ]; then
  msg=$1
fi
git commit -m "$msg"
git push


cd ../
git add .
git commit -m "$msg"
git push
