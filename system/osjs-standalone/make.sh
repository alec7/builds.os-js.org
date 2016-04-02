#!/bin/bash

rm -rf nightly/*
rm -f nightly.zip
rm -rf source/.standalone

(cd source; git checkout -- dist)
(cd source; git pull)

REV=$(cd source; git rev-list --count master)

(cd source; npm install)
(cd source; grunt all standalone)

mkdir nightly
cp source/CHANGELOG.md nightly/
cp source/README.md nightly/
cp source/LICENSE nightly/
cp source/AUTHORS nightly/
cp -r source/.standalone/packages nightly/
cp -r source/.standalone/themes nightly/
cp -r source/.standalone/vendor nightly/
cp -r source/.standalone/favicon.* nightly/
cp -r source/.standalone/index.html nightly/
cp -r source/.standalone/osjs.* nightly/
cp -r source/.standalone/locales.js nightly/
cp -r source/.standalone/schemes.js nightly/
cp -r source/.standalone/osjs-logo.png nightly/
cp -r source/.standalone/packages.js nightly/
cp -r source/.standalone/settings.js nightly/

(cd nightly; zip -r ../nightly.zip *)
mv nightly.zip ../www/standalone/osjs-standalone-${REV}.zip
