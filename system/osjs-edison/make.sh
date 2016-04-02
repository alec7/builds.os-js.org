#!/bin/bash

(cd source && git pull)
(cd source/src/packages/system && git pull)

REV=$(cd source; git rev-list --count master)

(cd source; ./bin/build-opkg.sh osjs 2.0.0-$REV all intel-edison)
mv source/.build/opkg/*.ipk ../www/opkg/edison/all/

(cd source; ./bin/build-opkg.sh osjs 2.0.0-$REV x86 intel-edison)
mv source/.build/opkg/*.ipk ../www/opkg/edison/x86/

(cd source; ./bin/build-opkg.sh osjs 2.0.0-$REV i586 intel-edison)
mv source/.build/opkg/*.ipk ../www/opkg/edison/i586/

(cd ../www/opkg/edison; rm Packages*; rm */Packages*)
(cd ../www/opkg/edison; /www/system/opkg-utils/opkg-make-index . > Packages && gzip Packages)
(cd ../www/opkg/edison/all; /www/system/opkg-utils/opkg-make-index . > Packages && gzip Packages)
(cd ../www/opkg/edison/x86; /www/system/opkg-utils/opkg-make-index . > Packages && gzip Packages)
(cd ../www/opkg/edison/i586; /www/system/opkg-utils/opkg-make-index . > Packages && gzip Packages)
