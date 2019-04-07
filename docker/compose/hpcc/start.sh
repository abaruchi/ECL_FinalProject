#!/bin/sh
set -e

/usr/bin/ssh-keygen -A

echo "Starting SSH"
/etc/init.d/ssh start

echo "Starting HPCC"
/etc/init.d/hpcc-init start

while true; do
  sleep 30
done
