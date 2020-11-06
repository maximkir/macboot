
OS = $(shell uname)

define brew_install_or_upgrade
	if brew ls --versions "$(1)" >/dev/null; then \
	    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$(1)"; \
	else \
	    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$(1)"; \
	fi
endef


.PHONY: help dependencies pyenv setup clean

PYTHON_VERSION?=3.6.8
VENV_PROMT=$(basename "${PWD}")
VENV_DIR?=.venv
VENV_ACTIVATE=. $(VENV_DIR)/bin/activate


prerequisites: $(OS)

Darwin:
	brew update
	$(call brew_install_or_upgrade,pyenv)


.DEFAULT: help

help:
	@echo "Please choose one of the following targets: \n"\
          "    prerequisites: Installs prerequisites software\n"\
          "    pyenv: Sets up pyenv and a virtualenv for this project\n"\
          "    dependencies: Installs dependencies for this project\n"\
          "    setup: Setup your development environment and install dependencies\n"\
          "    clean: Cleans any generated files"

pyenv:
	@echo "Creating virtual env, python version is: ${PYTHON_VERSION}"
	pyenv install --skip-existing ${PYTHON_VERSION}

	@eval "$$(pyenv init -)"; \
	pyenv local ${PYTHON_VERSION}; \
	python3 -m venv --prompt ${VENV_PROMT} ${VENV_DIR}

	$(VENV_ACTIVATE); \
	pip install --upgrade pip

dependencies:
	$(VENV_ACTIVATE); \
	pip install -Ur requirements.txt


setup: prerequisites pyenv dependencies

test:
	$(VENV_ACTIVATE); \
	ansible-playbook -vvv -i inventory --syntax-check local_env.yml


run_all:
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml --tags macos; \
	ansible-playbook -i inventory local_env.yml --tags zsh; \
	ansible-playbook -i inventory local_env.yml --tags iterm2; \
	ansible-playbook -i inventory local_env.yml --tags dotfiles

clean:
	rm -rf ${VENV_DIR}
	rm -f .python-version
