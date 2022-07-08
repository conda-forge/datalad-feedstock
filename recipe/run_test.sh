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
    # workaround https://github.com/datalad/datalad/issues/6623
    export PYTHON_KEYRING_BACKEND=keyrings.alt.file.PlaintextKeyring
    # test_test would be removed as 0.17.1
    # test_subprocess_return_code_capture - https://github.com/datalad/datalad/issues/6109
    python -m pytest -s -v -k 'not test_test and not test_subprocess_return_code_capture' --pyargs datalad
fi
