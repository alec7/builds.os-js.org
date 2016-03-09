#!/bin/bash

REV=$(cd source; git rev-list --count master)

(cd source; rm -rf dist && git checkout -- dist dist-dev && git pull)

(cd source; ./bin/build-opkg.sh osjs 2.0.0-$REV all intel-edison)
mv source/.build/opkg/*.ipk ../www/opkg/edison/all/

(cd source; ./bin/build-opkg.sh osjs 2.0.0-$REV x86 intel-edison)
mv source/.build/opkg/*.ipk ../www/opkg/edison/x86/

(cd source; ./bin/build-opkg.sh osjs 2.0.0-$REV i586 intel-edison)
mv source/.build/opkg/*.ipk ../www/opkg/edison/i586/

(cd ../www/opkg/edison; rm Packages*; rm */Packages*)
(cd ../www/opkg/edison; ~/opkg-utils/opkg-make-index . > Packages && gzip Packages)
(cd ../www/opkg/edison/all; ~/opkg-utils/opkg-make-index . > Packages && gzip Packages)
(cd ../www/opkg/edison/x86; ~/opkg-utils/opkg-make-index . > Packages && gzip Packages)
(cd ../www/opkg/edison/i586; ~/opkg-utils/opkg-make-index . > Packages && gzip Packages)
