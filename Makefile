
OS = $(shell uname)

.PHONY: help init clean
PYTHON_VERSION=3.6.8
PROMPT="ansible-playbooks"
VENV_DIR?=.venv
VENV_ACTIVATE=. $(VENV_DIR)/bin/activate
PYTHON=${VENV_DIR}/bin/python3


prerequisites: $(OS)

Darwin:
	brew update
	brew install pyenv


.DEFAULT: help

help:
	@echo "TBD"

pyenv:
	@echo "creating virtual env"
	pyenv install --skip-existing ${PYTHON_VERSION}

	@eval $$(pyenv init -); \
	pyenv local ${PYTHON_VERSION}; \
	python -m venv --prompt ${PROMPT} ${VENV_DIR}

	$(VENV_ACTIVATE); \
	pip install --upgrade pip

dependencies:
	$(VENV_ACTIVATE); pip install -Ur requirements.txt


setup: pyenv dependencies

clean:
	rm -rf ${VENV_DIR}
