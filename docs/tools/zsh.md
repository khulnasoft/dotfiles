# KhulnaSoft Dotfiles - Zsh Configuration Guide

This document provides comprehensive information about Zsh configuration in the KhulnaSoft dotfiles repository, including setup, features, and customization options.

## Overview

Zsh is the enhanced shell used in the KhulnaSoft dotfiles repository. It provides advanced features such as:

- **Fuzzy finding**: Command and history completion with fzf
- **Vi mode**: Vi-style editing in the shell
- **Forgit**: Interactive frontend for various git commands
- **Prompt customization**: Advanced prompt configuration
- **Completion system**: Intelligent command completion

## Installation

### Automatic Installation

The Zsh configuration is automatically installed as part of the main installation process:

```bash
# Run the automatic installation script
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/khulnasoft/dotfiles/master/tools/assets/executable_install.sh)"
```

### Manual Installation

For manual installation:

```bash
# Install Zsh
brew install zsh

# Install Oh My Zsh (if not already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/robbyrussell/oh-my-zsh $HOME/.oh-my-zsh
```

## Configuration Files

### Main Zsh Configuration (`.zshrc`)

The main Zsh configuration file is located at `$HOME/.zshrc`. It includes:

#### Basic Settings
```bash
# Shell options
setopt PROMPT_SUBST
unsetopt correct_all

# History settings
HISTSIZE=10000
SAVEHIST=10000
hist -f ~/.zsh_history

# Completion settings
autoload -Uz compinit
compinit -C
zstyle :compadd compat all
```

#### Prompt Configuration
```bash
# Prompt theme
PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{yellow}%~%f %F{blue}%(1..)%f%# '
RPROMPT='%F{cyan}→%f '

# Prompt functions
function prompt_name() {
  echo "KhulnaSoft"
}
```

#### Completion System
```bash
# Fuzzy completion
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SAt %p%s'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache/

# Command completion
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' ignore-parents $SHELL
```

#### Alias Configuration
```bash
# Git aliases
alias gl='git log --oneline'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
aliass='git status'
alias gb='git branch'

# Utility aliases
alias ll='ls -la'
alias la='ls -la'
alias l='ls -la'
alias cat='bat'
alias less='lf'
```

### Zsh Login Profile (`.zprofile`)

The Zsh login profile is loaded for interactive shells:

```bash
# Load environment variables
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# Load custom functions
if [ -f ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

# Set up shell history
if [ -f ~/.zsh_history ]; then
  source ~/.zsh_history
fi
```

### Zsh Completions (`.zshrc_completions/`)

Custom completion scripts for various tools:

#### Git Completions
```bash
# Git completion script
_git() {
  local cur prev opts base
  cur="$(git ${git_parms[@]}, --zsh)"
  prev="$(git ${git_parms[@]}, --zsh)"
  opts="$(git -P ${git_parms[@]}, --completewords)"

  if [[ ${#opts} -eq 0 ]]; then
    return 0
  fi

  case $cur in
    --*)
      COMPREPLY=(${(f)(echo $opts | sed 's/ /
/g')} )
      return 0
      ;;
  esac

  COMPREPLY=(${(f)(echo $opts | sed 's/ /
/g')} )
  return 0
}
```

## Features

### 1. Fuzzy Menus

Zsh provides fuzzy menus for command completion and command history:

#### Command Completion
```bash
# Enable fuzzy completion
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SAt %p%s'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache/
```

#### Command History
```bash
# Enable fuzzy history search
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' ignore-parents $SHELL
```

### 2. Vi Mode

Zsh provides Vi mode for shell editing:

#### Vi Mode Configuration
```bash
# Enable Vi mode
set -o vi

# Vi key bindings
bindkey -v
bindkey -v '^[[H' beginning-of-line
bindkey -v '^[[F' end-of-line
bindkey -v '^[[3~' delete-char
bindkey -v '^[[2~' down-line-or-history
bindkey -v '^[[4~' up-line-or-history
bind
```

#### Visual Mode
```bash
# Visual mode commands
bindkey -v 'vv' visual-mode
bindkey -v 'dd' kill-line
bindkey -v 'yy' yank-line
bindkey -v 'pp' put
bindkey -v 'dd' delete-line
```

### 3. Forgit

Forgit is an interactive frontend for various git commands:

#### Installation
```bash
# Install forgit
brew install forgit

# Add forgit to Zsh
if [ -f "$(brew --prefix)/opt/forgit/share/forgit/forgit.plugin.sh" ]; then
  source "$(brew --prefix)/opt/forgit/share/forgit/forgit.plugin.sh"
fi
```

#### Usage
```bash
# Use forgit for git operations
git forgit log
git forgit status
git forgit diff
git forgit add
```

### 4. Prompt Customization

Zsh provides advanced prompt customization:

#### Prompt Themes
```bash
# Prompt theme configuration
PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{yellow}%~%f %F{blue}%(1..)%f%# '
RPROMPT='%F{cyan}→%f '

# Custom prompt functions
function prompt_name() {
  echo "KhulnaSoft"
}

function prompt_time() {
  echo "$(date '+%H:%M:%S')"
}
```

#### Dynamic Prompt Elements
```bash
# Dynamic prompt elements
PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{yellow}%~%f %F{blue}%(1..)%f%# %{"(%{")%#$(prompt_time)%{")%}"

# Git status in prompt
PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{yellow}%~%f %{"%{")%#$(git_status)%{")%}"
```

### 5. Completion System

Zsh provides intelligent completion for various tools:

#### Command Completion
```bash
# Enable completion for various tools
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' ignore-parents $SHELL
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SAt %p%s'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.zsh/cache/
```

#### File Completion
```bash
# File completion
zstyle ':completion:*' fileSort true
zstyle ':completion:*' min-size 0
zstyle ':completion:*' max-size 100k
zstyle ':completion:*' compress true
```

## Configuration Customization

### Local Overrides

Create `.zshrc_local` in your home directory to override Zsh configuration:

```bash
cat > ~/.zshrc_local << 'EOF'
# Custom Zsh configuration
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# Custom aliases
alias ll='ls -la'
alias gs='git status'

# Custom prompt
export PROMPT='%# '
EOF
```

### Environment Variables

Set environment variables in your Zsh configuration:

```bash
cat >> ~/.zshrc_local << 'EOF'
# Environment variables
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Zsh-specific variables
export ZSH_THEME="agnoster"
export OH_MY_ZSH_THEME="agnoster"

# Completion variables
export COMPINIT_FLAGS="-C"
export COMPADD_FLAGS="--all"
EOF
```

## Troubleshooting

### Common Issues

#### Shell Not Loading Configuration

**Issue**: Zsh is not loading the configuration.

**Solution**:
```bash
# Close and reopen terminal
# Or restart shell
source ~/.zshrc

# Check if .zshrc_local exists
ls -la ~/.zshrc_local

# Source the local configuration
if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi
```

#### Custom Aliases Not Working

**Issue**: Custom aliases are not working.

**Solution**:
```bash
# Check if .zshrc_local is sourced
source ~/.zshrc_local

# Test custom aliases
git status
ls -la
```

#### Fuzzy Completion Not Working

**Issue**: Fuzzy completion is not working.

**Solution**:
```bash
# Check if fzf is installed
which fzf

# Install fzf if not present
brew install fzf

# Source fzf configuration
source /usr/local/opt/fzf/shell/completion.bash

# Add to .zshrc_local
cat >> ~/.zshrc_local << 'EOF'
# Fzf configuration
export FZF_DEFAULT_COMMAND='find . -type f'
export FZF_CTRL_T_COMMAND='find . -type f'
export FZF_ALT_C_COMMAND='find . -type d'
EOF
```

### Debugging Commands

```bash
# Check Zsh configuration
zsh --version
zsh -c 'echo "Zsh is working"'

# Check for syntax errors
zsh -n ~/.zshrc

# Test custom configuration
source ~/.zshrc_local

# Check aliases
alias

# Check completion
compdef
```

## Configuration Examples

### Example Zsh Configuration

```bash
# Example .zshrc_local
cat > ~/.zshrc_local << 'EOF'
# Custom Zsh configuration
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# Custom aliases
alias ll='ls -la'
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline'

# Custom prompt
export PROMPT='%F{cyan}%n%f@%F{green}%m%f %F{yellow}%~%f %F{blue}%(1..)%f%# '

# Custom functions
my_function() {
  echo "Custom function executed"
}
EOF
```

### Example Zsh Plugin Configuration

```bash
# Example .zshrc_local with plugins
cat >> ~/.zshrc_local << 'EOF'
# Plugin configuration
plugins=(git)
source $HOME/.oh-my-zsh/plugins/git

# Plugin options
zstyle ':omz:plugins:git' alias-dispatch true
zstyle ':omz:plugins:git' color true
zstyle ':omz:plugins:git' verbose true
EOF
```

## Conclusion

Zsh is the enhanced shell used in the KhulnaSoft dotfiles repository. It provides advanced features such as:

- **Fuzzy finding**: Command and history completion with fzf
- **Vi mode**: Vi-style editing in the shell
- **Forgit**: Interactive frontend for various git commands
- **Prompt customization**: Advanced prompt configuration
- **Completion system**: Intelligent command completion

The Zsh configuration is designed to be:

- **User-friendly**: Easy to configure and customize
- **Feature-rich**: Provides advanced shell features
- **Extensible**: Supports plugins and extensions
- **Secure**: Follows security best practices

This Zsh configuration guide provides:

- **Comprehensive setup**: Detailed instructions for Zsh configuration
- **Feature documentation**: Documentation of all Zsh features
- **Customization options**: Options for customizing Zsh
- **Troubleshooting**: Solutions to common issues

**Enjoy Zsh with KhulnaSoft!** 🎉
