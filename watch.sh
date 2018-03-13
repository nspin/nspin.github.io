#!/bin/sh

set -e

trap 'kill $(jobs -p)' EXIT

python3 -m http.server &

# lol
while true; do
    make
    sleep .2
done | grep -v "make: Nothing to be done for 'all'."
