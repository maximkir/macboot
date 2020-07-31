


OS = $(shell uname)

define brew_install_or_upgrade
	if brew ls --versions "$(1)" >/dev/null; then
	    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$(1)"
	else
	    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$(1)"
	fi
endef


.PHONY: help init clean
PYTHON_VERSION=3.6.8
PROMPT="ansible-playbooks"
VENV_DIR?=.venv
VENV_ACTIVATE=. $(VENV_DIR)/bin/activate
PYTHON=${VENV_DIR}/bin/python3


prerequisites: $(OS)

Darwin:
	brew update
	$(call brew_install_or_upgrade,pyenv)


.DEFAULT: help

help:
	@echo "TBD"

pyenv:
	@echo "creating virtual env"
	pyenv install --skip-existing ${PYTHON_VERSION}

	@eval "$$(pyenv init -)"; \
	pyenv local ${PYTHON_VERSION}; \
	python -m venv --prompt ${PROMPT} ${VENV_DIR}


	$(VENV_ACTIVATE); \
	pip install --upgrade pip

dependencies:
	$(VENV_ACTIVATE); \
	pip install -Ur requirements.txt


setup: pyenv dependencies

clean:
	rm -rf ${VENV_DIR}
