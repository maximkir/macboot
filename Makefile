
OS = $(shell uname)

SHASUM = sha256sum # Linux GNU

ifeq ($(OS), Darwin)
	SHASUM = shasum --algorithm 256
endif

.PHONY: test-syntax run-all

PYTHON_VERSION?=3.9.0

VENV_ACTIVATE=. $(VENV)/activate

test-syntax: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -vvv -i inventory --syntax-check local_env.yml


run-all: venv
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
		-L "https://raw.githubusercontent.com/maximkir/python-venv/v2021.07.01/Makefile.venv"
	echo "5644e1077060d9330dd0435277bdf3db0789a9445c601c192d5b8da0c455a7a2 *Makefile.fetched" \
		| $(SHASUM) --check - \
		&& mv Makefile.fetched Makefile.venv
