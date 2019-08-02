#!/usr/bin/env bash

VENV_DIR=.venv
PYTHON_VERSION=3.6.8
PROMPT=$(basename "$PWD")

function pip_install()
{
    pip install --upgrade pip
}

function pip_install_dependencies()
{
	pip install -r requirements.txt
}

function create_venv()
{
	echo "Creating virtual env"
	python3 -m venv --prompt "${PROMPT}" "${VENV_DIR}"
}

echo "Installing python: $PYTHON_VERSION"
pyenv install --skip-existing "$PYTHON_VERSION"

# Allows pyenv to automatically change versions
eval "$(pyenv init -)"

pyenv local "$PYTHON_VERSION"
pyenv shell "$PYTHON_VERSION"

pip_install

# The environment python version is the current version of python (set above by pyenv).
create_venv

source ./activate.sh

# Install packages to the newly created virtual environment
pip_install_dependencies

deactivate
