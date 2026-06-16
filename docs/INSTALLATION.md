# KhulnaSoft Dotfiles - Installation Guide

This document provides comprehensive instructions for installing and setting up the KhulnaSoft dotfiles repository on macOS and Linux systems.

## Overview

The KhulnaSoft dotfiles repository provides a comprehensive development environment setup that includes configurations for:

- **Shell**: Enhanced Zsh with fuzzy finding and vi mode
- **Editor**: Neovim/Vim with plugin ecosystem
- **Terminal**: tmux with smart session management
- **Development Tools**: Git, Go, Python with custom configurations
- **Package Management**: Homebrew with sync utilities

## Prerequisites

Before installing, ensure you have:

### System Requirements
- **Operating System**: macOS 10.15+ or Linux (Ubuntu 20.04+, CentOS 8+, Fedora 34+)
- **Shell**: Bash 4+ or Zsh 5+
- **Package Manager**: Homebrew (macOS) or apt/yum (Linux)
- **Development Tools**: git, curl, wget

### Optional Dependencies
- **GitHub CLI**: For repository operations
- **Nerd Fonts**: For icon support in terminals
- **iTerm2**: Enhanced terminal emulator (macOS)

## Installation Methods

### Method 1: Automatic Installation (Recommended)

This is the easiest method for most users. It will install all dependencies and apply the dotfiles configuration.

```bash
# Run the automatic installation script
curl -fsSL https://raw.githubusercontent.com/khulnasoft/dotfiles/master/install | bash
```

**What this script does:**
1. Installs Homebrew (or uses system Homebrew)
2. Installs required packages (GitHub CLI, chezmoi, zsh, etc.)
3. Configures shell and terminal settings
4. Applies dotfile configurations
5. Sets up development tools

### Method 2: Manual Installation

For advanced users who want more control over the installation process:

```bash
# Step 1: Install Homebrew (if not already installed)
# macOS
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# Linux (Ubuntu/Debian)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Step 2: Install required packages
brew install gh chezmoi zsh gum

# Step 3: Initialize chezmoi
chdir $HOME
chzmoi init git@github.com:khulnasoft/dotfiles.git

# Step 4: Show diff of changes
chzmoi diff

# Step 5: Apply changes (if satisfied)
chzmoi apply -v
```

### Method 3: Development Installation

For developers who want to modify the dotfiles:

```bash
# Clone the repository
git clone https://github.com/khulnasoft/dotfiles.git

# Navigate to the repository
cd dotfiles

# Run validation to check for issues
tools/bin/executable_validate.sh

# Make any desired modifications
# Test modifications locally
# Apply changes using chezmoi
```

## Installation Steps

### 1. Install Homebrew (macOS)

If you're on macOS and don't have Homebrew installed, run:

```bash
# macOS Big Sur and later
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# Older macOS versions
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Required Packages

The installation script will install the following packages:

```bash
# Core tools
brew install gh          # GitHub CLI
brew install chezmoi    # Dotfile manager
brew install zsh         # Enhanced shell
brew install gum         # TUI library for prompts

# Optional tools (recommended)
brew install fzf         # Fuzzy finding
brew install ripgrep     # Fast searching
brew install bat         # Enhanced cat
brew install vim         # Text editor
brew install neovim     # Modern editor
brew install tmux       # Terminal multiplexer
```

### 3. Initialize Chezmoi

Chezmoi is the dotfile manager used by this repository. It manages the configuration files in your home directory.

```bash
cd $HOME
chzmoi init git@github.com:khulnasoft/dotfiles.git
```

This command:
- Creates a `.chezmoi.toml` configuration file
- Downloads the dotfiles repository
- Sets up the template system for managing dotfiles

### 4. Review and Apply Changes

Before applying the changes, it's recommended to review what will be modified:

```bash
chzmoi diff
```

This command shows all the changes that will be made to your home directory. You can:

- Review each change
- Skip specific files if needed
- Accept all changes if you're satisfied

Once you're satisfied with the changes, apply them:

```bash
chzmoi apply -v
```

### 5. Configure Local Settings

After applying the dotfiles, you'll need to configure some local settings:

#### Git Configuration

Create a `.gitconfig_local` file in your home directory:

```bash
cat > $HOME/.gitconfig_local << 'EOF'
[user]
  name = Your Name
  email = your.email@example.com

[github]
  user = your-github-username
  token = your-github-personal-access-token
EOF
```

#### Shell Configuration

Create a `.zshrc_local` file for custom shell settings:

```bash
cat > $HOME/.zshrc_local << 'EOF'
# Add your custom shell settings here
# Example: alias for common commands
alias ll='ls -la'
alias gs='git status'

# Example: custom prompt
export PROMPT='%# '
EOF
```

#### Autoupdate Configuration

Create a `.autoupdate_local.zsh` file for custom autoupdate commands:

```bash
cat > $HOME/.autoupdate_local.zsh << 'EOF'
# Add your custom autoupdate commands here
# Example: custom update schedule
export AUTOUPDATE_SCHEDULE="0 2 * * 1"  # Weekly updates
EOF
```

### 6. Test Installation

After installation, test that everything is working correctly:

```bash
# Test shell configuration
echo "Hello from KhulnaSoft shell!"

# Test Git configuration
git config --get user.name
git config --get user.email

# Test editor configuration
if command -v nvim &> /dev/null; then
  echo "Neovim is available"
else
  echo "Neovim is not available"
fi

# Test terminal configuration
if command -v tmux &> /dev/null; then
  echo "tmux is available"
else
  echo "tmux is not available"
fi
```

### 7. Close and Reopen Terminal

After applying the dotfiles, it's important to close and reopen your terminal to ensure all configurations are loaded:

```bash
# On macOS
killall Terminal

# On Linux
pkill -HUP bash
```

## Post-Installation Setup

### Configure Development Environment

After installation, you may want to set up additional development tools:

#### Python Development

```bash
# Install Python and common packages
brew install python3
pip3 install --user black isort flake8

# Create Python configuration
mkdir -p $HOME/.config/python
```

#### Node.js Development

```bash
# Install Node.js (using Homebrew)
brew install node

# Install npm packages globally
npm install -g eslint prettier typescript
```

#### Go Development

```bash
# Install Go
brew install go

# Set up Go configuration
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

### Set Up Git Aliases

The dotfiles include enhanced Git aliases. You can add your own:

```bash
cat >> $HOME/.zshrc_local << 'EOF'
# Git aliases
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log'
alias gd='git diff'
alias gb='git branch'

# Git status alias with colors
alias gs='git status --color=always'
EOF
```

### Configure Editor Settings

Customize your editor settings to match your preferences:

#### Neovim Configuration

Create a `nvim/` directory in your home directory for custom Neovim settings:

```bash
mkdir -p $HOME/.config/nvim
cat > $HOME/.config/nvim/lua/custom.lua << 'EOF'
-- Your custom Neovim configuration
vim.notify("KhulnaSoft Neovim loaded", "info", { title = "Setup" })
EOF
```

#### Vim Configuration

Create a `.vimrc_local` file for custom Vim settings:

```bash
cat > $HOME/.vimrc_local << 'EOF'
" Your custom Vim settings
" Example: set number for line numbers
set number

" Example: set tab width
set tabstop=4
set shiftwidth=4
set expandtab
EOF
```

### Configure Terminal Settings

Customize your terminal settings for optimal experience:

#### Tmux Configuration

Create a `.tmux.conf_local` file for custom tmux settings:

```bash
cat > $HOME/.tmux.conf_local << 'EOF'
# Custom tmux settings
# Example: set prefix key to Ctrl+A
set -g prefix C-a

# Example: set status line format
set -g status-style rounded
set -g status-left-length 30
set -g status-right-length 90
EOF
```

### Troubleshooting

#### Common Issues

**Issue: Shell not loading configurations**

Solution:
```bash
# Close and reopen terminal
# Or restart shell
source $HOME/.zshrc
```

**Issue: Editor not working**

Solution:
```bash
# Check if Neovim is installed
which nvim

# Install Neovim if not present
brew install neovim

# Reapply dotfiles
chzmoi apply -v
```

**Issue: Git configuration not applied**

Solution:
```bash
# Check Git configuration
git config --list | grep user.name
git config --list | grep user.email

# If not set, create .gitconfig_local
```

#### Getting Help

If you encounter issues:

1. **Check the logs**: Look for error messages in your terminal
2. **Review the documentation**: Check the tool-specific guides
3. **Check GitHub issues**: Look for existing issues and solutions
4. **Submit a new issue**: If you can't find a solution

### Advanced Configuration

#### Environment Variables

Set environment variables in your shell configuration:

```bash
cat >> $HOME/.zshrc_local << 'EOF'
# Environment variables
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Path settings
export PATH="$HOME/.local/bin:$PATH"
EOF
```

#### Custom Scripts

Add custom scripts to your `tools/bin/` directory:

```bash
# Create a custom script
cat > $HOME/tools/bin/custom_script.sh << 'EOF'
#!/bin/bash
# Your custom script here
echo "Custom script executed"
EOF

# Make it executable
chmod +x $HOME/tools/bin/custom_script.sh
```

## Verification

After installation, run the validation script to ensure everything is working:

```bash
# Run validation
tools/bin/executable_validate.sh

# Check for any errors or warnings
# Fix any issues found
```

## Support

### Documentation
- [Installation Guide](INSTALLATION.md) - This document
- [Configuration Guide](CONFIGURATION.md) - Configuration options
- [Customization Guide](CUSTOMIZATION.md) - How to extend and override
- [Tool Guides](tools/) - Tool-specific documentation

### Getting Help

1. **Check the documentation** for setup and configuration instructions
2. **Review the troubleshooting guide** for common issues
3. **Submit an issue** on GitHub if you encounter problems
4. **Contribute** by improving documentation and scripts

## Troubleshooting

### Common Installation Issues

**Issue: Homebrew not installed**

Solution:
```bash
# Install Homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
```

**Issue: GitHub authentication required**

Solution:
```bash
# Authenticate with GitHub
gh auth login
```

**Issue: Insufficient permissions**

Solution:
```bash
# Check if you have write permissions to your home directory
ls -ld $HOME
```

### Common Runtime Issues

**Issue: Shell not loading configurations**

Solution:
```bash
# Close and reopen terminal
# Or restart shell
source $HOME/.zshrc
```

**Issue: Editor not working**

Solution:
```bash
# Check if Neovim is installed
which nvim

# Install Neovim if not present
brew install neovim

# Reapply dotfiles
chzmoi apply -v
```

## Conclusion

The installation process is straightforward and well-documented. By following these steps, you'll have a comprehensive development environment with enhanced shell, editor, terminal, and development tool configurations.

The installation script handles all the complex setup automatically, while the manual installation option gives you more control over the process. Both methods result in a fully functional development environment that's ready for immediate use.

**Enjoy your enhanced development environment with KhulnaSoft!** 🚀
