#!/bin/sh

set -e

targets=${@:-most}

# lol
while true; do
    make $targets
    sleep .2
done | grep -Ev "make: (Nothing to be done for '[^']+'|'[^']+' is up to date)."
