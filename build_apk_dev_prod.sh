#!/bin/bash
set -e

# Find and increment the version number.
perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+)(\+)(\d+)$/$1.($2+1).$3.($4+1)/e' pubspec.yaml

# Commit and tag this change.
version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`
git commit -m "Bump version to $version" pubspec.yaml
#git tag $version

flutter build apk  --flavor dev --target-platform android-arm,android-arm64 --release --split-debug-info --obfuscate -t lib/main.dart
flutter build apk  --flavor prod --target-platform android-arm,android-arm64 --release --split-debug-info --obfuscate -t lib/main_prod.dart