#!/bin/sh

# use this to catch up with submodule updates
git add -u
git commit -m "catch up: $(date)"
git push
