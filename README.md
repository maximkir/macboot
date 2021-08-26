# Ansible Playbooks For My Development Machines

[![Build Status](https://github.com/maximkir/ansible-playbooks/workflows/ci-workflow/badge.svg?branch=master)](https://github.com/maximkir/ansible-playbooks/actions)

This playbook installs and configures most of the software I use on my Mac for software development. Some things in macOS are slightly difficult to automate, so I still have some manual installation steps, but at least it's all documented here.

This is a work in progress, and is mostly a means for me to document my current Mac's setup. I'll be evolving this set of playbooks over time.

*See also*:
  - [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

## Requirements
* Python3 (3.3+)
* pyenv

## Installation

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
2. Clone this repository to your machine.
3. Execute `make zsh` or `make bash` to start a terminal with relevant depedencies.
4. Alternatively, for the first time execute `make run-all` to install all roles.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `iterm2`, `macos`, `ssh-keys` and `zsh`.

    `ansible-playbook local_env.yml -i inventory -K --tags "dotfiles,macos"`

## Dotfiles

The 'dotfiles' tag will install my [dotfiles](https://github.com/maximkir/dotfiles) into the current user's home directory.


## iTerm2

The 'iterm2' tag will install extensions for the [iTerm2](https://www.iterm2.com/) terminal:
* [A set of color schemes for iTerm2](https://github.com/mbadolato/iTerm2-Color-Schemes)


## ZSH

The 'zsh' tag will:
* Install zsh
* Install [oh-my-zsh](https://ohmyz.sh/), plugins and themes
* Install [Powerline](https://github.com/powerline/fonts) fonts
* Configure [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme

## MacOS

The 'macos' tag will set some defaults in macos operating system.

## Software

The 'software' tag will install applications as follows:

### Included Applications / Configuration (Default)

Applications (installed with Homebrew Cask):

  - [Docker](https://www.docker.com/)
  - [Google Chrome](https://www.google.com/chrome/)
  - [Homebrew](http://brew.sh/)
  - [Sublime Text](https://www.sublimetext.com/)
  - [Intellij-idea](https://www.jetbrains.com/idea/)
  - [Pycharm-ce](https://www.jetbrains.com/pycharm/)
  - [Visualvm](https://visualvm.github.io/)
  - [iterm2](https://www.iterm2.com/)
  - [Alfred](https://www.alfredapp.com/)
  - [Postman](https://www.getpostman.com/)
  - [Spotify](https://www.spotify.com/)

Packages (installed with Homebrew):

  - coreutils
  - duf
  - findutils
  - htop
  - ack
  - git
  - curl
  - wget
  - zsh
  - gnupg
  - tree
  - awscli
  - pyenv
  - kubectl

## Manual Steps
TBD
