#!/bin/bash

(cd /home/anders/osjs-standalone; ./make.sh)
(cd /home/anders/osjs-edison/; ./make.sh)
(cd /home/anders/osjs-arduino/; ./make.sh)
(cd /home/anders/osjs-x11/; ./make.sh)
(cd /home/anders/osjs-nw/; ./make.sh)

./sums.sh
