# 💻 MacBoot - Automated macOS Development Environment

![Build Status](https://github.com/maximkir/macboot/actions/workflows/macbook-workflows.yaml/badge.svg?branch=master)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

> **Automate your macOS development setup with Ansible**

MacBoot is an opinionated, yet customizable Ansible playbook that transforms a fresh macOS installation into a fully configured development environment. Born from years of manually setting up development machines, this tool embodies the DRY principle by automating the tedious process of configuring a new Mac.

## ✨ Features

- 🏗️ **Complete Environment Setup**: Installs and configures essential development tools
- 🍺 **Homebrew Integration**: Manages packages and cask applications
- ⚡ **Modern CLI Tools**: Includes productivity tools like `ripgrep`, `fzf`, `bat`, and more
- 🐚 **Zsh Enhancement**: Sets up Oh My Zsh with popular plugins and themes
- 🔧 **Git Configuration**: Configures Git with sensible defaults
- 🖥️ **iTerm2 Setup**: Configures iTerm2 with custom profiles
- 🎨 **macOS Customization**: Applies system preferences and UI tweaks
- 🔄 **Idempotent**: Safe to run multiple times without side effects
- 📝 **Highly Customizable**: Override defaults with your own configuration

## 🚀 Quick Start

### Prerequisites

Before running MacBoot, ensure you have:

- **macOS** (tested on recent versions)
- **Python 3.3+** (usually pre-installed)
- **Command Line Tools**: Install with `xcode-select --install`

### One-Line Installation

```bash
git clone https://github.com/maximkir/macboot.git && cd macboot && ./setup.sh
```

### Step-by-Step Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/maximkir/macboot.git
   cd macboot
   ```

2. **Install dependencies**:
   ```bash
   ./setup.sh
   ```

3. **Run the playbook**:
   ```bash
   source activate.sh
   ansible-playbook main.yml -K
   ```

4. **Restart your Mac** after the provisioning completes.

## 📦 What Gets Installed

### Homebrew Packages
- **Core utilities**: `coreutils`, `findutils`, `curl`, `wget`
- **Development tools**: `git`, `git-lfs`, `gh` (GitHub CLI), `pyenv`
- **Modern CLI replacements**: `bat`, `ripgrep`, `fd`, `fzf`, `jq`
- **System monitoring**: `bpytop`, `ctop`, `procs`, `duf`, `bandwhich`
- **Productivity**: `tldr`, `lazygit`, `starship` prompt

### Applications (Cask)
- **Terminal**: iTerm2 with custom configuration
- **Development**: Zed editor, OrbStack (Docker alternative)
- **Utilities**: Meld (diff tool)
- **Fonts**: Fira Code

### Shell Enhancement
- **Oh My Zsh** with curated plugins:
  - `zsh-syntax-highlighting`
  - `zsh-autosuggestions` 
  - `zsh-completions`
  - `zsh-nvm`
- **Powerlevel10k** theme for a beautiful prompt

## ⚙️ Customization

Create a `config.yml` file in the project root to override any defaults from `default.config.yml`.

### Example: Custom Package List

```yaml
# Add your preferred packages
homebrew_installed_packages:
  - go
  - rust
  - nodejs
  - docker

# Add your preferred applications
homebrew_cask_apps_user:
  - google-chrome
  - visual-studio-code
  - slack
  - notion
```

### Example: Custom Zsh Plugins

```yaml
oh_my_zsh_plugins:
  - git
  - docker
  - kubectl
  - terraform
  - zsh-syntax-highlighting
  - zsh-autosuggestions
```

## 🏷️ Running Specific Tasks

Use Ansible tags to run only specific parts of the setup:

```bash
# Install only Homebrew packages
ansible-playbook main.yml --tags "homebrew"

# Configure only Git and terminal
ansible-playbook main.yml --tags "git,terminal"

# Set up macOS preferences only
ansible-playbook main.yml --tags "osx"
```

### Available Tags

| Tag | Description |
|-----|-------------|
| `osx` | macOS system preferences and tweaks |
| `homebrew` | Homebrew installation and package management |
| `terminal` | Zsh and Oh My Zsh configuration |
| `iterm` | iTerm2 setup and profiles |
| `git` | Git configuration |
| `extra-packages` | Additional package installations |

## 🛠️ Manual Steps

Some configurations require manual intervention:

### SSH Key Management

Add to `~/.zshrc.local`:

```bash
# Auto-load SSH keys
for file in ~/.ssh/{id_rsa,id_rsa_work}; do
    [ -r "$file" ] && ssh-add "$file" > /dev/null 2>&1
done
unset file
```

### Mac App Store Applications

Use `mas` (installed via Homebrew) for App Store purchases:

```bash
# Xcode (if needed)
mas install 497799835

# Magnet (window manager)
mas install 441258766
```

## 🔍 Troubleshooting

### Common Issues

**Virtual Environment Error**: If you see a virtualenv warning, deactivate it:
```bash
deactivate
./setup.sh
```

**Permission Denied**: The playbook needs sudo access for some operations:
```bash
ansible-playbook main.yml -K  # -K prompts for sudo password
```

**Homebrew Path Issues**: The playbook automatically detects Intel vs Apple Silicon Macs.

### Getting Help

1. Check the [Issues](https://github.com/maximkir/macboot/issues) page
2. Review the Ansible output for specific error messages
3. Ensure all prerequisites are met

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on a clean macOS installation
5. Submit a pull request

## 🙏 Acknowledgments

- Inspired by [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook)
- Built with [Ansible](https://www.ansible.com/)
- CLI tools recommendations from [CLI tools you can't live without](https://dev.to/lissy93/cli-tools-you-cant-live-without-57f6)

## 📄 License

This project is licensed under the [Apache 2.0 License](LICENSE).

---

**MacBoot** - Because setting up a new Mac shouldn't take all day ☕

*Created with ❤️ by [@maximkir](https://github.com/maximkir)*