##!/bin/bash
set -e

# Find and increment the version number.
perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' client/pubspec.yaml

# Commit and tag this change.
version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`
git commit -m "Bump build version to $version" pubspec.yaml
git tag $version

flutter build ios --flavor prod  --release --tree-shake-icons --split-debug-info --obfuscate -t lib/main_prod.dart