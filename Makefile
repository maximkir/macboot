
OS = $(shell uname)

SHASUM = sha256sum # Linux GNU

ifeq ($(OS), Darwin)
	SHASUM = shasum --algorithm 256
endif

ifeq ($(ANSIBLE_DONT_ASK_BECOME_PASS),)
	ANSIBLE_ASK_BECOME_PASS_FLAG="--ask-become-pass"
endif


.PHONY: test-syntax macos zsh-setup dotfiles ssh-keys software iterm sublime run-all

PYTHON_VERSION?=3.9.12
PIP_VERSION?=21.2.4

VENV_ACTIVATE=. $(VENV)/activate

test-syntax: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -vvv -i inventory --syntax-check local_env.yml


macos: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml ${ANSIBLE_ASK_BECOME_PASS_FLAG} --tags macos

zsh-setup: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml ${ANSIBLE_ASK_BECOME_PASS_FLAG} --tags zsh
	zsh --version

dotfiles: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml --tags dotfiles

ssh-keys: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml --tags ssh-keys

software: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml --tags software

iterm: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml --tags iterm2

sublime: venv
	$(VENV_ACTIVATE); \
	ansible-playbook -i inventory local_env.yml --tags sublime


run-all: venv macos zsh-setup dotfiles ssh-keys software iterm sublime



include Makefile.venv
Makefile.venv:
	curl \
		-o Makefile.fetched \
		-L "https://raw.githubusercontent.com/maximkir/python-venv/v2021.07.01/Makefile.venv"
	echo "5644e1077060d9330dd0435277bdf3db0789a9445c601c192d5b8da0c455a7a2 *Makefile.fetched" \
		| $(SHASUM) --check - \
		&& mv Makefile.fetched Makefile.venv
