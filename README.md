# 💻 📦 🚀 MacBoot

[![Build Status](https://github.com/maximkir/macboot/workflows/ci-workflow/badge.svg?branch=master)](https://github.com/maximkir/macboot/actions)

This project helps me to bootstrap my development machines. During the last ten years of development, I've noticed a lot of time spent setting up a new appliance.
As a software engineer, the DRY principle echoed in my head. Hence, I decided to automate it to save some time for myself (and my colleagues).

This is a work in progress and is primarily a means to document my current Mac's setup. I'll be evolving this set of tools over time.

The project introduces no magic but a simple usage of the Ansible playbook that allows configuring various aspects of the machine.


*See also*:
  - [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

## ⚓ Requirements
* Python3 (3.3+)
* pyenv

## ✨ Installation

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
2. Clone this repository to your machine.
3. Execute `make zsh` or `make bash` to start a terminal with relevant depedencies.
4. Alternatively, for the first time execute `make run-all` to install all roles.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `iterm2`, `macos`, `ssh-keys`, `software`, `sublime` and `zsh`.

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

## ⚙️ Software

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
  - lastpass-cli
  - mas

## 🛠️ 🐢 Manual Steps

### 🔐 Download Private & Public Keys from LastPass

I have a set of public and private keys pairs that I use for different purposes. To avoid their re-creation or copying, I store them in a vault ([LastPass](https://www.lastpass.com/)) and fetch them once needed by the following commands:

Login:

``` bash
lpass login USERNAME
```

Upload Key Pair:

``` bash
entry_name="dummy_folder/dummy_note"
pub_key_path=~/.ssh/dummy_id_rsa.pub
pvt_key_path=~/.ssh/dummy_id_rsa

printf "Private Key: %s\nPublic Key: %s\n" \
  "$(cat ${pvt_key_path})" "$(cat ${pub_key_path})" \
    | lpass add --non-interactive --sync=now --note-type=ssh-key ${entry_name}
```

Download Key Pair:

``` bash
entry_name="dummy_folder/dummy_note"
pub_key_path=~/.ssh/dummy_id_rsa.pub
pvt_key_path=~/.ssh/dummy_id_rsa

lpass show ${entry_name} --field="Public Key" > ${pub_key_path}
lpass show ${entry_name} --field="Private Key" > ${pvt_key_path}
```

Add Keys to SSH Agent:

Add the following snippet to `~/.zshrc.local` file:

``` bash
for file in ~/.ssh/{id_rsa,id_rsa_work}; do
	[ -r "$file" ] && ssh-add "$file" > /dev/null 2>&1
done

unset file
```

### Mac App Store
Not all software is available for installation through brew. The [mas](https://github.com/mas-cli/mas) utility is handy for installing purchased software from the Mac App Store.


``` bash
# Xcode
mas install 497799835

# Magnet
mas install 441258766

# Todoist
mas install 585829637
```


## 📄 License

macboot was created by [@maximkir](https://github.com/maximkir).
Code is under the [Apache 2.0 license](LICENSE).
