# KhulnaSoft Dotfiles - Tmux Configuration Guide

This document provides comprehensive information about tmux configuration in the KhulnaSoft dotfiles repository, including setup, features, and customization options.

## Overview

tmux is the terminal multiplexer used in the KhulnaSoft dotfiles repository. It provides advanced terminal management features such as:

- **Session management**: Create, attach, and manage tmux sessions
- **Window management**: Create and manage tmux windows
- **Pane management**: Create and manage tmux panes
- **Fuzzy menus**: Fuzzy menu for quick tmux management
- **Plugin integration**: Integration with tmux plugins
- **Customization**: Extensive customization options

## Installation

### Automatic Installation

The tmux configuration is automatically installed as part of the main installation process:

```bash
# Run the automatic installation script
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/khulnasoft/dotfiles/master/tools/assets/executable_install.sh)"
```

### Manual Installation

For manual installation:

```bash
# Install tmux
brew install tmux

# Install tmux plugin manager
brew install tmux-plugin-manager

# Create tmux configuration directory
mkdir -p ~/.config/tmux
```

## Configuration Files

### Main Tmux Configuration (`.tmux.conf`)

The main tmux configuration file is located at `$HOME/.tmux.conf`. It includes:

#### Basic Settings
```bash
# Basic tmux settings
set -g history-limit 10000
set -g max-panes 20
set -g default-shell /bin/zsh
set -g default-command /bin/zsh

# Session management
set -g attach-on-new on
set -g create-on-window-for-panes on

# Window management
set -g pane-border-status top
set -g pane-border-format '#P'
set -g window-style 'status-bg=#282c34'
set -g window-active-style 'status-bg=#3e4452'
```

#### Status Line
```bash
# Status line configuration
set -g status on
set -g status-justify left
set -g status-bg default
set -g status-fg white

set -g status-left-length 30
set -g status-right-length 90

set -g status-left "#S"
set -g status-right "#H %l:%v"

# Status line colors
set -g pane-active-border-fg blue
set -g pane-border-fg darkgray
```

#### Key Bindings
```bash
# Custom key bindings
unbind-key -T copy-mode-vi vi-copy-mode
bind-key -T copy-mode-vi vi-copy-mode

# Window management
bind-key -r C-a C-a swap-window
bind-key -r C-a C-n new-window
bind-key -r C-a C-p select-window

# Pane management
bind-key -r C-a C-h select-pane -L
bind-key -r C-a C-j select-pane -D
bind-key -r C-a C-k select-pane -U
bind-key -r C-a C-l select-pane -R
```

#### Plugin Configuration
```bash
# Plugin management
run -g 'set -g @plugin "https://github.com/ivaaaan/smug"'
run -g 'set -g @plugin "https://github.com/tmux-plugins/tmux-fzf"'
run -g 'set -g @plugin "https://github.com/tmux-plugins/tmux-resurrect"'

# Plugin configuration
run -g 'set -g @smug_start_at_login on'
run -g 'set -g @smug_auto_restore on'
run -g 'set -g @smug_auto_save on'
```

### Tmux Settings (`.tmux.conf.settings`)

Additional tmux settings for specific configurations:

```bash
# Theme settings
set -g @tmux_theme "default"
set -g @tmux_status_bg "#282c34"
set -g @tmux_status_fg "#ebdbb2"

# Session management
set -g @smug_start_at_login on
set -g @smug_auto_restore on

# Fuzzy menu settings
set -g @fzf_menu_mode "command"
set -g @fzf_menu_command "tmux new-window -n %s"
```

## Features

### 1. Session Management

tmux provides comprehensive session management:

#### Session Creation
```bash
# Create a new session
tmux new-session -s mysession

# Create a new session with a specific window
tmux new-session -s mysession -n "Main Window" "vim"

# Create a new session with multiple windows
tmux new-session -s mysession \
  -n "Main Window" "vim" \
  -n "Terminal" "bash" \
  -n "Runner" "echo "Runner window""
```

#### Session Attachment
```bash
# Attach to a session
tmux attach-session -t mysession

# Attach to a session in the current terminal
tmux a -t mysession

# List all sessions
tmux list-sessions

# Kill a session
tmux kill-session -t mysession
```

#### Session Management with Smug
```bash
# Start smug (tmux session manager)
smug start

# Stop smug
smug stop

# List smug sessions
smug list

# Restore smug sessions
smug restore
```

### 2. Window Management

tmux provides comprehensive window management:

#### Window Creation
```bash
# Create a new window
tmux new-window -n "Main Window"

# Create a new window with a command
tmux new-window -n "Terminal" "bash"

# Create a new window with multiple panes
tmux new-window -n "Split" "vim" \
  -t mysession:1 -h split-window -v split-window
```

#### Window Navigation
```bash
# Navigate to a window
tmux select-window -t mysession:1
tmux select-window -t mysession:2

# List windows
tmux list-windows -t mysession

# Rename a window
tmux rename-window -t mysession:1 "Main Window"

# Kill a window
tmux kill-window -t mysession:1
```

#### Window Management with Shortcuts
```bash
# Create a new window
C-a C-n

# Navigate to the previous window
C-a C-p

# Navigate to the next window
C-a C-n

# Swap the current window with the previous window
C-a C-a

# Move to the leftmost window
C-a C-h

# Move to the rightmost window
C-a C-l
```

### 3. Pane Management

tmux provides comprehensive pane management:

#### Pane Creation
```bash
# Create a horizontal split
tmux split-window -h

# Create a vertical split
tmux split-window -v

# Create a pane in the current window
tmux new-pane -h

# Create a pane in the current window
tmux new-pane -v
```

#### Pane Navigation
```bash
# Navigate to the left pane
C-a C-h

# Navigate to the right pane
C-a C-l

# Navigate to the top pane
C-a C-k

# Navigate to the bottom pane
C-a C-j

# Swap the current pane with the left pane
C-a C-h

# Swap the current pane with the right pane
C-a C-l

# Resize panes
C-a C-h: resize-pane -L 5
C-a C-j: resize-pane -D 5
C
```

#### Pane Management with Shortcuts
```bash
# Create a new pane
C-a C-% (horizontal split)
C-a C-" (vertical split)

# Navigate to a pane
C-a [arrow key]

# Resize panes
C-a : resize-pane -L 5
C-a ; resize-pane -R 5
C-a , resize-pane -U 5
C-a . resize-pane -D 5

# Close a pane
C-a : kill-pane
```

### 4. Fuzzy Menus

tmux provides fuzzy menus for quick tmux management:

#### Fuzzy Menu for Windows
```bash
# Open fuzzy menu for windows
C-a C-Space

# Search for a window
# Type the window name and press Enter
```

#### Fuzzy Menu for Panes
```bash
# Open fuzzy menu for panes
C-a C-/ (if configured)

# Search for a pane
# Type the pane content and press Enter
```

#### Fuzzy Menu for Sessions
```bash
# Open fuzzy menu for sessions
C-a C-Space (if configured)

# Search for a session
# Type the session name and press Enter
```\n
### 5. Plugin Integration

tmux provides integration with various plugins:

#### Plugin Management with TPM
```bash
# Install tmux plugin manager (TPM)
# Add the following to ~/.tmux.conf
run -g 'set -g @plugin "https://github.com/tmux-plugins/tmux-plugin-manager"'
run -g 'set -g @plugin "https://github.com/tmux-plugins/tmux-fzf"'
run -g 'set -g @plugin "https://github.com/tmux-plugins/tmux-resurrect"'

# Initialize TPM
source ~/.tmux/plugins/tpm/tpm.sh
```

#### Plugin Configuration
```bash
# Configure tmux plugins
run -g 'set -g @plugin "https://github.com/ivaaaan/smug"'
run -g 'set -g @smug_start_at_login on'
run -g 'set -g @smug_auto_restore on'
run -g 'set -g @smug_auto_save on'

# Configure tmux-fzf
run -g 'set -g @fzf_menu_mode "command"'
run -g 'set -g @fzf_menu_command "tmux new-window -n %s"'

# Configure tmux-resurrect
run -g 'set -g @resurrect-auto-save on'
run -g 'set -g @resurrect-auto-restore on'
```

### 6. Customization

#### Theme Configuration
```bash
# Set tmux theme
run -g 'set -g @tmux_theme "default"'

# Set status line colors
run -g 'set -g @tmux_status_bg "#282c34"'
run -g 'set -g @tmux_status_fg "#ebdbb2"'

# Set pane colors
run -g 'set -g @pane_active_border_fg "#458588"'
run -g 'set -g @pane_border_fg "#3e4452"'
```

#### Key Binding Customization
```bash
# Customize key bindings
bind-key -r C-a C-a swap-window
bind-key -r C-a C-n new-window
bind-key -r C-a C-p select-window

# Add custom key bindings
bind-key -r C-a C-s run-shell "tmux new-window -n 'Search' 'grep -r \"pattern\" ."
```

## Configuration Customization

### Local Overrides

Create `.tmux.conf_local` in your home directory to override tmux configuration:

```bash
cat > ~/.tmux.conf_local << 'EOF'
# Custom tmux configuration
run -g 'set -g @tmux_theme "dark"'
run -g 'set -g @smug_start_at_login on'
run -g 'set -g @fzf_menu_mode "command"'

# Custom key bindings
bind-key -r C-a C-s run-shell "tmux new-window -n 'Search' 'grep -r \"pattern\" ."
EOF
```

### Environment Variables

Set environment variables in your shell configuration:

```bash
cat >> ~/.zshrc_local << 'EOF'
# Environment variables
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/tpm"
export TMUX_PLUGIN_MANAGER_AUTO_SETUP="on"

# Tmux configuration
export TMUX_DEFAULT_SHELL="/bin/zsh"
export TMUX_DEFAULT_COMMAND="/bin/zsh"
EOF
```

## Troubleshooting

### Common Issues

#### Tmux Not Working

**Issue**: tmux is not working.

**Solution**:
```bash
# Check if tmux is installed
which tmux

# Install tmux if not present
brew install tmux

# Reapply dotfiles
chzmoi apply -v

# Check tmux version
tmux -V
```

#### Tmux Configuration Not Applied

**Issue**: tmux configuration is not applied.

**Solution**:
```bash
# Check tmux configuration
tmux list-keys

# Check tmux status
tmux list-sessions

# Reapply dotfiles
chzmoi apply -v
```

#### Tmux Plugin Not Working

**Issue**: tmux plugin is not working.

**Solution**:
```bash
# Check if plugin is installed
ls -la ~/.tmux/plugins/

# Reinstall plugin
rm -rf ~/.tmux/plugins/tmux-plugin-manager
source ~/.tmux/plugins/tmux-plugin-manager/tpm.sh

# Reapply dotfiles
chzmoi apply -v
```

### Debugging Commands

```bash
# Check tmux configuration
tmux list-keys

# Check tmux sessions
tmux list-sessions

# Check tmux windows
tmux list-windows

# Check tmux panes
tmux list-panes

# Run tmux with debug mode
tmux -2 -f ~/.tmux.conf.debug
```

## Configuration Examples

### Example Tmux Configuration

```bash
# Example .tmux.conf_local
cat > ~/.tmux.conf_local << 'EOF'
# Custom tmux configuration
run -g 'set -g @tmux_theme "dark"'
run -g 'set -g @smug_start_at_login on'
run -g 'set -g @fzf_menu_mode "command"'

# Custom key bindings
bind-key -r C-a C-s run-shell "tmux new-window -n 'Search' 'grep -r \"pattern\" ."

# Custom window management
bind-key -r C-a C-a swap-window
bind-key -r C-a C-n new-window
bind-key -r C-a C-p select-window
EOF
```

### Example Tmux Plugin Configuration

```bash
# Example .tmux.conf_local with plugins
cat >> ~/.tmux.conf_local << 'EOF'
# Plugin configuration
run -g 'set -g @plugin "https://github.com/ivaaaan/smug"'
run -g 'set -g @smug_start_at_login on'
run -g 'set -g @smug_auto_restore on'
run -g 'set -g @smug_auto_save on'

# Plugin configuration
run -g 'set -g @fzf_menu_mode "command"'
run -g 'set -g @fzf_menu_command "tmux new-window -n %s"'

# Plugin configuration
run -g 'set -g @resurrect-auto-save on'
run -g 'set -g @resurrect-auto-restore on'
EOF
```

## Conclusion

tmux is the terminal multiplexer used in the KhulnaSoft dotfiles repository. It provides advanced terminal management features such as:

- **Session management**: Create, attach, and manage tmux sessions
- **Window management**: Create and manage tmux windows
- **Pane management**: Create and manage tmux panes
- **Fuzzy menus**: Fuzzy menu for quick tmux management
- **Plugin integration**: Integration with tmux plugins
- **Customization**: Extensive customization options

The tmux configuration is designed to be:

- **User-friendly**: Easy to configure and customize
- **Feature-rich**: Provides advanced terminal management features
- **Extensible**: Supports plugins and extensions
- **Secure**: Follows security best practices

This tmux configuration guide provides:

- **Comprehensive setup**: Detailed instructions for tmux configuration
- **Feature documentation**: Documentation of all tmux features
- **Customization options**: Options for customizing tmux
- **Troubleshooting**: Solutions to common issues

**Enjoy tmux with KhulnaSoft!** 🎉
