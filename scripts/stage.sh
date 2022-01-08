#!/bin/sh
set -e

prefix=_site
remote=staging
branch=site
url="git@github.com:nspin/www-staging.git"

git remote get-url $remote > /dev/null || git remote add $remote $url
git subtree push --prefix $prefix $remote $branch
