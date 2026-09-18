#!/bin/bash
msg="aus-c-$1"
git stage .
git commit -m "$msg"
git push

# git stage .
# git commit -m ""
