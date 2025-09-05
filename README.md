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

MacBoot offers two approaches for customization, depending on your needs:

### 🔧 Quick Customization (Local Override)

For one-time or temporary changes, create a `config.yml` file in the project root to override defaults:

```yaml
# config.yml - overrides default.config.yml
homebrew_installed_packages:
  - go
  - rust
  - nodejs
  - docker

homebrew_cask_apps_user:
  - google-chrome
  - visual-studio-code
  - slack
  - notion
```

> ⚠️ **Note**: This approach doesn't persist across updates when you pull changes from the main repository.

### 🍴 Persistent Customization (Fork & Modify)

**Recommended for long-term use**: Fork the repository and modify `default.config.yml` directly:

1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/macboot.git
   cd macboot
   ```
3. **Edit `default.config.yml`** with your preferences:
   ```bash
   vim default.config.yml  # or use your preferred editor
   ```
4. **Commit your changes**:
   ```bash
   git add default.config.yml
   git commit -m "Customize default configuration"
   git push origin master
   ```

This approach ensures your customizations persist and can be version-controlled.

### 🎨 Customization Examples

#### Development Stack
```yaml
# Add your language toolchains
homebrew_installed_packages:
  - go
  - rust
  - nodejs
  - python@3.11
  - terraform
  - kubectl
  - helm

# Development applications
homebrew_cask_apps:
  - visual-studio-code
  - jetbrains-toolbox
  - docker
  - postman
  - tableplus
```

#### Design & Media
```yaml
# Creative tools
homebrew_cask_apps_user:
  - figma
  - sketch
  - adobe-creative-cloud
  - vlc
  - handbrake
  - imageoptim
```

#### Shell Customization
```yaml
# Zsh plugins for your workflow
oh_my_zsh_plugins:
  - git
  - docker
  - kubectl
  - terraform
  - aws
  - zsh-syntax-highlighting
  - zsh-autosuggestions
  - z

# Custom theme (optional)
oh_my_zsh_theme: "agnoster"  # Override powerlevel10k
```

#### System Preferences
```yaml
# Night Shift configuration
enable_night_shift: true
night_shift_strength: 0.7  # 0.0 = minimal, 1.0 = maximum warmth

# Add more system preferences as needed
```

### 🔄 Keeping Your Fork Updated

To sync with upstream changes:

```bash
# Add upstream remote (one-time setup)
git remote add upstream https://github.com/maximkir/macboot.git

# Update your fork with latest changes
git fetch upstream
git checkout master
git merge upstream/master
git push origin master
```

Then review and merge any conflicts with your customizations.

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