#!/bin/sh

set -e

# lol
while true; do
    make
    sleep .2
done | grep -v "make: Nothing to be done for 'all'."
