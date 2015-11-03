#!/usr/bin/env bash

set -e

: ${TRAVIS:?'This should only be run on Travis CI'}

npm run build

cp -u *.md dist/
cp -u *.json dist/
cd dist

tar -zcvf "../dist.tar.gz" * > /dev/null 2>&1
zip "../dist.zip" * > /dev/null 2>&1
