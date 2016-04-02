#!/bin/bash

rm nightly-*.zip
rm -rf source/.standalone
rm -rf source/.nw

(cd source; git checkout -- dist)
(cd source; git pull)

REV=$(cd source; git rev-list --count master)

(cd source; npm install)
(cd source; grunt nw)

(cd source/.nw/OS.js/linux64; zip -r ../../../../nightly-linux64.zip *)
(cd source/.nw/OS.js/win64; zip -r ../../../../nightly-win64.zip *)
mv nightly-linux64.zip ../www/nw/osjs-nw-${REV}-linux64.zip
mv nightly-win64.zip ../www/nw/osjs-nw-${REV}-win64.zip
