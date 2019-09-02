#!/usr/bin/env bash
set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately
# export pages
hugo -d ../joppevos.github.io/

cd ../joppevos.github.io/
git add --all
git commit -m "updated blog"
git push

