#!/usr/bin/env bash
set -eou pipefail

curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs
