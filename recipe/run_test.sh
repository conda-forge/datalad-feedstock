#!/bin/bash

set -eu

# no network should be assumed
export DATALAD_TESTS_NONETWORK=1
export http_proxy=http://127.0.0.1:9/
export https_proxy=http://127.0.0.1:9/

# To assure that all entry points built/made available
datalad --help
git-annex-remote-datalad-archives --help
git-annex-remote-datalad --help

if [ "$(uname)" = "Linux" ] || hash git-annex; then
    python -m nose -s -v -e test_system_ssh_version datalad
fi
