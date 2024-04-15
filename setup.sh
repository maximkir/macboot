#!/bin/bash

if [[ "$VIRTUAL_ENV" != "" ]]; then
    echo "Please run this script outside of a virtualenv (run 'deactivate')"
    exit 1
fi

set -xe

python3 -m venv .venv
source activate.sh
pip install -r requirements.txt
ansible-galaxy collection install -r requirements.yml
