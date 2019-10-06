# Ansible Playbooks For My Development Machines 

[![Build Status](https://travis-ci.org/maximkir/ansible-playbooks.svg?branch=master)](https://travis-ci.org/maximkir/ansible-playbooks)

This playbook installs and configures most of the software I use on my Mac for software development. Some things in macOS are slightly difficult to automate, so I still have some manual installation steps, but at least it's all documented here.

This is a work in progress, and is mostly a means for me to document my current Mac's setup. I'll be evolving this set of playbooks over time.

*See also*:

	- [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

## Requirements
* Python3 (3.3+)
* pyenv

## Installation

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
2. Clone this repository to your local drive.
3. Create new virtual environment via the terminal command: `./prepare_venv.sh`
4. Activate it with: `source activate.sh`

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `iterm2`, `macos`, `ssh-keys` and `zsh`.

    `ansible-playbook local_env.yml -i inventory -K --tags "dotfiles,macos"`
