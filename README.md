# 💻 📦 🚀 MacBoot

[![Build Status](https://github.com/maximkir/macboot/workflows/ci-workflow/badge.svg?branch=master)](https://github.com/maximkir/macboot/actions)

This project helped me bootstrap my development machines. During the last ten years of development, I've noticed a lot of time spent setting up a new appliance.
As a software engineer, I've always kept the DRY principle in mind. Therefore, I decided to automate the process, which could save time for myself and my colleagues.

This is a work in progress and mainly serves as a means to document my current Mac setup. I will be updating this set of tools over time.

The project introduces no magic but a simple usage of the Ansible playbook that allows configuring various aspects of the machine.

The MacBoot automation tool execution is idempotent; subsequent runs won't change anything.

*See also*:
  - [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)

## ⚓ Requirements
* Python3 (3.3+)
* pyenv

## ✨ Installation

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
2. Clone this repository to your machine.
3. Open a terminal and execute `./setup.sh` to install relevant dependencies.


## Running a specific set of tagged tasks

### First Time Execution
If you are already familiar with the brew software manager and have your preferred picks, see [this](#overriding-defaults) section on extending the default apps list.

For the first time, run the entire play by executing:  

> Note that your computer password is required for the initial provisioning process. The `-K` flag instructs `ansible` to request it.

  ```bash
  source activate.sh
  ansible-playbook main.yml -K
  ```

Once the provisioning is running, it's time for coffee.

**Restart your computer once the provisioning process is finished.**

### On-Demand Execution

You can filter which part of the provisioning process to run by specifying a set of tags using the flag of `ansible-playbook` `--tags`. Check the [main.yml](main.yml) file for the list of all available tags.

  ``` bash
  source activate.sh
  ansible-playbook main.yml --tags "homebrew,git"
  ```

---
# Overriding Defaults

Some people's development environments and preferred software configurations are different.

You can override any defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed apps with something like:

```yaml
homebrew_installed_packages:
  - go

```

Similar options available for extending the apps list:

```yaml
homebrew_cask_apps_user:
  - google-chrome
  - alfred
  - pycharm
  - webstorm
```

## 🛠️ 🐢 Manual Steps

### Add Keys to SSH Agent

Add the following snippet to the `~/.zshrc.local` file:

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

```


## 📄 License

macboot was created by [@maximkir](https://github.com/maximkir).
Code is under the [Apache 2.0 license](LICENSE).
