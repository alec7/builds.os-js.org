#!/bin/bash

(cd source; git pull)
REV=$(cd source; git rev-list --count master)

#rm -rf source/.arduino
#(cd source; rm -rf dist && git checkout -- dist dist-dev && git pull && npm install)
#(cd source; ./bin/arduino-build.sh)
#(cd source; ./bin/arduino-mkipkg.sh)
#mv source/.arduino/*.ipk ../www/arduino/

(cd source; ./bin/build-opkg.sh arduinoos 2.0.0-$REV ar71xx arduino)
mv source/.build/opkg/*.ipk ../www/opkg/arduino/ar71xx/

(cd ../www/opkg/arduino; rm Packages*; rm */Packages*)
(cd ../www/opkg/arduino; ~/opkg-utils/opkg-make-index . > Packages && gzip Packages)
(cd ../www/opkg/arduino/ar71xx; ~/opkg-utils/opkg-make-index . > Packages && gzip Packages)
