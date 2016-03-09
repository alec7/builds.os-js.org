#!/bin/bash

(cd www/installers;  md5sum *.sh *.exe > MD5SUMS)
(cd www/installers;  sha256sum *.sh *.exe > SHA256SUMS)

(cd www/debian/binary;  md5sum *.deb > MD5SUMS)
(cd www/debian/binary;  sha256sum *.deb > SHA256SUMS)

(cd www/nw;  md5sum *.zip > MD5SUMS)
(cd www/nw;  sha256sum *.zip > SHA256SUMS)

(cd www/standalone;  md5sum *.zip > MD5SUMS)
(cd www/standalone;  sha256sum *.zip > SHA256SUMS)

(cd www/opkg/arduino/ar71xx;  md5sum *.ipk > MD5SUMS)
(cd www/opkg/arduino/ar71xx;  sha256sum *.ipk > SHA256SUMS)

(cd www/opkg/edison/all;  md5sum *.ipk > MD5SUMS)
(cd www/opkg/edison/all;  sha256sum *.ipk > SHA256SUMS)
(cd www/opkg/edison/x86;  md5sum *.ipk > MD5SUMS)
(cd www/opkg/edison/x86;  sha256sum *.ipk > SHA256SUMS)
(cd www/opkg/edison/i586;  md5sum *.ipk > MD5SUMS)
(cd www/opkg/edison/i586;  sha256sum *.ipk > SHA256SUMS)
