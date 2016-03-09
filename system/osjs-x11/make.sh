#!/bin/bash

REV=$(cd source; git rev-list --count master)

(cd source; rm -rf dist && git checkout -- dist dist-dev && git pull)

rm source/*.deb
(cd source; ./bin/build-deb.sh osjs 2.0.0-$REV amd64)
cp source/*.deb ../www/debian/binary/

(cd ../www/debian; dpkg-scanpackages binary /dev/null | gzip -9c > binary/Packages.gz)
(cd ../www/debian; dpkg-scanpackages source /dev/null | gzip -9c > source/Packages.gz)

exit 0
