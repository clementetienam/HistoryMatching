#!/usr/bin/env bash

# Colab doesn't provide functionality for working with full packages/repos, including
# - defining python environments (e.g. requirements.txt)
# - pre-loading data/scripts other than what's in the notebook.
# We therefore make this script for bootstrapping the notebooks by cloning the full repo.
#!wget -qO- $URL | bash -s -- --debug


setup () {
    set -e

    # Install requirements
    URL=https://github.com/patricknraanes/HistoryMatching.git
    if [[ ! -d REPO ]]; then git clone --depth=1 $URL REPO; fi
    pip install -r REPO/requirements.txt
    cp -r REPO/* ./
}

# Only run if we're on colab
if python -c "import colab"; then
    # Quiet execution
    if echo $@ | grep -- '--debug' > /dev/null ; then
        setup
    else
        setup > /dev/null 2>&1
    fi
    echo "Initialization for Colab done."
fi
