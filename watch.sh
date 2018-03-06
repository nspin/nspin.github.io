#!/bin/sh

set -e

trap 'kill $(jobs -p)' EXIT

cd site
python3 -m http.server &
cd ..

# lol
while true; do
    make
    sleep .2
done | grep -v "make: Nothing to be done for 'all'."
