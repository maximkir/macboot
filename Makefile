
OS = $(shell uname)

SHASUM = sha256sum # Linux GNU

ifeq ($(OS), Darwin)
	SHASUM = shasum --algorithm 256
endif

.PHONY: test-syntax run-all

PYTHON_VERSION?=3.9.0

VENV_ACTIVATE=. $(VENV)/activate

test-syntax:
	$(VENV_ACTIVATE); \
	ansible-playbook -vvv -i inventory --syntax-check local_env.yml


run-all:
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml --tags macos; \
	ansible-playbook -i inventory local_env.yml --tags zsh; \
	zsh --version; \
	ansible-playbook -i inventory local_env.yml --tags iterm2; \
	ansible-playbook -i inventory local_env.yml --tags dotfiles


include Makefile.venv
Makefile.venv:
	curl \
		-o Makefile.fetched \
		-L "https://raw.githubusercontent.com/maximkir/python-venv-template/v2020.12.20/Makefile"
	echo "1c79f371eda3c40441efaf59ecb830bd8c6b6f31ae0cac3f772626dcc498ac06 *Makefile.fetched" \
		| $(SHASUM) --check - \
		&& mv Makefile.fetched Makefile.venv
