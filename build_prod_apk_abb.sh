##!/bin/bash
set -e

# Find and increment the version number.
perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' client/pubspec.yaml

# Commit and tag this change.
version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`
git commit -m "Bump build version to $version" pubspec.yaml
git tag $version

flutter build apk  --flavor prod --target-platform android-arm,android-arm64 --release --tree-shake-icons --split-debug-info --obfuscate -t lib/main_prod.dart
flutter build appbundle --flavor prod --target-platform android-arm,android-arm64,android-x64 --release --tree-shake-icons --split-debug-info --obfuscate -t lib/main_prod.dart