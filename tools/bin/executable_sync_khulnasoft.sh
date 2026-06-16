#!/usr/bin/env bash

gh_clone_all.sh khulnasoft ~/Work
pull_all.sh ~/Work/khulnasoft

# go through all the directories in ~/Work/khulnasoft
# look for package.json files in the subdirectories
# and run pnpm install in those directories
find ~/Work/khulnasoft -depth 2 -name package.json -exec dirname {} \; | while read dir; do
  # if the directory contains a pnpm-lock.yaml file use pnpm
  # otherwise look for a yarn.lock file and use yarn
  # otherwise look for a package-lock.json file and use npm
  if [ -f "$dir/pnpm-lock.yaml" ]; then
    echo "Running pnpm install in $dir"
    (cd $dir && pnpm install)
  elif [ -f "$dir/yarn.lock" ]; then
    echo "Running yarn install in $dir"
    (cd $dir && yarn install)
  elif [ -f "$dir/package-lock.json" ]; then
    echo "Running npm install in $dir"
    (cd $dir && npm install)
  fi
done

# install husky git hooks in khulnasoft/mono
if [ -d ~/Work/khulnasoft/mono ]; then
  echo "Installing husky git hooks in ~/Work/khulnasoft/mono"
  (cd ~/Work/khulnasoft/mono && husky)
fi
