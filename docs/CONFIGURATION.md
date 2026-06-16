# KhulnaSoft Dotfiles - Configuration Guide

This document provides comprehensive information about configuration options, settings, and customization for the KhulnaSoft dotfiles repository.

## Overview

The KhulnaSoft dotfiles repository provides extensive configuration options for:

- **Shell**: Zsh configuration, aliases, completions, and prompt customization
- **Terminal**: tmux configuration, session management, and key bindings
- **Editor**: Neovim/Vim configuration, plugins, and language server setup
- **Development Tools**: Git, Go, Python, and other development tool configurations
- **Package Management**: Homebrew configuration and package sync

## Configuration Management

### Configuration File Locations

Configuration files are organized in the following directory structure:

```
dotfiles/
├── shell/                            # Shell configuration
│   ├── .zshrc                        # Zsh configuration
│   ├── .zprofile                     # Zsh login profile
│   ├── .aliases                      # Zsh aliases
│   └── completions/                  # Completion scripts
├── terminal/                         # Terminal configuration
│   ├── .tmux.conf                    # Tmux configuration
│   └── .tmux.conf.settings           # Tmux settings
├── editor/                           # Editor configuration
│   ├── .vimrc                        # Vim configuration
│   ├── .vim/                         # Vim plugin/after configs
│   │   └── after/                    # After plugin scripts
│   │       └── autoload/             # Autoload scripts
│   │           └── coc/              # CoC integration
│   │               └── ui.vim         # UI configuration
│   └── nvim/                         # Neovim configuration
│       ├── init.vim                  # Main Neovim config
│       ├── ginit.vim                 # GUI-specific settings
│       └── coc-settings.json         # Language server config
├── dev/                              # Development tool configuration
│   ├── .gitconfig                    # Git configuration
│   ├── .gitconfig_themes             # Git color themes
│   ├── .golangci.yml                 # Go linter config
│   └── .prettierrc                   # Prettier JS formatter
├── config/                           # XDG configuration
│   ├── broot/                        # File tree browser
│   ├── fsh/                          # Fast Syntax Highlighting
│   ├── ghostty/                      # Terminal emulator
│   ├── pip/                          # Python package manager
│   └── smug/                         # Tmux session manager
└── tools/                            # Software utilities
    ├── bin/                          # Executable scripts
    ├── assets/                       # Images and install scripts
    └── lib/                          # Libraries and modules
```

### Configuration File Types

The repository uses different types of configuration files:

#### Shell Scripts (`.sh`, `.zsh`)
- **Purpose**: Runtime configuration and automation
- **Examples**: `tools/bin/executable_install.sh`, `tools/bin/executable_validate.sh`
- **Format**: Bash or Zsh scripts

#### JSON Configuration Files
- **Purpose**: Structured data configuration
- **Examples**: `editor/nvim/coc-settings.json`
- **Format**: JSON key-value pairs

#### YAML Configuration Files
- **Purpose**: Human-readable configuration
- **Examples**: `config/smug/dotfiles.yml`
- **Format**: YAML key-value pairs

#### Editor Configuration Files
- **Purpose**: Editor-specific settings
- **Examples**: `.vimrc`, `init.vim`
- **Format**: Editor-specific syntax

#### Git Configuration Files
- **Purpose**: Git client settings
- **Examples**: `.gitconfig`, `.gitconfig_themes`
- **Format**: Git configuration format

## Shell Configuration

### Zsh Configuration (`.zshrc`)

The main Zsh configuration file includes:

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

### Shell Completions

The repository includes custom completion scripts for various tools:

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

## Terminal Configuration

### Tmux Configuration (`.tmux.conf`)

The main tmux configuration file includes:

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

## Editor Configuration

### Vim Configuration (`.vimrc`)

The main Vim configuration file includes:

#### Basic Settings
```bash
# Vim basic settings
set runtimepath^=~/.vim runtimepath+=~/.vim/after
set packpath=&runtimepath

# Note: Plugins are listed in ~/.vimrc

# GUI settings
if has("gui_running")
  set guioptions=aei
  set guioptions-=T
  set guioptions-=m
  set guioptions-=R
  set guioptions-=L
  set guitablabel=%M
endif

# Colorscheme
set background=dark
if (&term =~ "256color")
  set t_Co=256
endif

# Syntax highlighting
if has("syntax")
  syntax on
endif

# Line numbers
set number

# Tabs
set tabstop=4
set shiftwidth=4
set expandtab

# Backup and swap files
set backupdir=~/.vim/backup
set directory=~/.vim/swap
```

### Neovim Configuration (`nvim/init.vim`)

The main Neovim configuration file includes:

#### Basic Settings
```bash
" Note: Plugins are listed in ~/.vimrc
source ~/.vimrc

lua << EOF

-- update remote plugins to make wilder work
local UpdatePlugs = vim.api.nvim_create_augroup("UpdateRemotePlugs", {})
vim.api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
  pattern = "*",
  group = UpdatePlugs,
  command = "runtime! plugin/rplugin.vim",
})
vim.api.nvim_create_autocmd({ "VimEnter", "VimLeave" }, {
  pattern = "*",
  group = UpdatePlugs,
  command = "silent! UpdateRemotePlugins",
})

require'nvim-web-devicons'.setup {
 color_icons = true;
 default = true;
 strict = true;
}

require'nvim-treesitter'.setup {
  ensure_installed = { "go", "rust", "c", "python", "lua", "javascript", "bash", "cpp", "css", "dockerfile", "gomod", "gowork", "graphql", "hcl", "http", "html", "java", "json", "proto", "regex", "rego", "toml", "tsx", "typescript", "vim", "yaml", "make"},
  sync_install = false,
  highlight = {
    enable = true,
    disable {"yaml"},
  },
  indent = {
    enable = true,
  }
}

require('telescope').load_extension('fzf')

EOF
```

#### Language Server Configuration
```bash
" Language server configuration
let g:coc_nodejs_host_node_args = ['--max-old-space-size=4096']
let g:coc_global_extensions = [
  'coc-clangd',
  'coc-css',
  'coc-emoji',
  'coc-eslint',
 
```

## Development Tool Configuration

### Git Configuration (`.gitconfig`)

The main Git configuration file includes:

```bash
[user]
  name = KhulnaSoft User
  email = khulnasoft@khulnasoft.com

[github]
  user = khulnasoft
  token = your-github-personal-access-token

[core]
  editor = nvim
  autocrlf = input
  eol = lf

[alias]
  st = status
  ci = commit
  co = checkout
  br = branch
  lg = log --oneline
  diff = diff --no-color
  df = diff
  unstage = reset HEAD --
  stage = add
  push = push --set-upstream
  pull = pull --rebase
  rebase = rebase --interactive
  merge = merge --no-edit

[color]
  ui = true
  diff = auto
  status = auto
  branch = auto

[push]
  default = current
  autoSetupRemote = true

[fetch]
  prune = true
  recurseSubmodules = no

[pull]
  rebase = true
  ff = only

[log]
  pretty = oneline
  graph = true
  decorate = short
  source = git://github.com/
  abbrev = 8

[status]
  showUntrackedFiles = no
  ignoreSubmodules = dirty

[diff]
  subscript = log
  externalTool = diff-so-fancy

[merge]
  conflictStyle = diff3
  ff = only

[rebase]
  autosquash = always
  autosquash-rebase = always

[credential]
  helper = cache --timeout=3600
  helper = store --file=~/.git-credentials

[apply]
  whitespace = fix

[interactive]
  diffFilter = -w

[sequencer]
  finishAction = rebase --continue
  abortAction = reset --hard
  skipAction = next

[advice]
  resolved = false
  detachedHead = false
  implicitIdentity = false
  ambiguous = false
  noMatchingCommand = false
  patchEmptyFirstLine = false
  commitBeforeMerge = false
  pushSpecialRefNames = false
  updateChildSubmodule = false
  submoduleSeriesUpdate = false
  submoduleAlternateWarning = false

[fetchRecurseSubmodules]
  content = "check"

[gc]
  auto = true
  aggressive = false

[pack]
  windowSize = 1000
  delta = true

[receive]
  maxPackSize = 100m
  fsckObjects = true
  advertisePushOptions = true

[remote]
  pushDefault = current

[url "https://github.com/"]
  insteadOf = git://github.com/

[url "git@github.com:"]
  insteadOf = https://github.com/

[init]
  defaultBranch = main
  sharedTemplateDir = /etc/git-init

[mergetool]
  keepBackup = false
  prompt = false

[pull-request]
  autoSetupBranch = true
  allowRebase = true
  allowSquash = true
  allowFastForward = true

[branch]
  sort = alphabetical
  trackRemote = true

[reset]
  autoStash = true
  safeCrashing = true

[rebase]
  autosquash = always
  autosquash-rebase = always
  updateRefs = true

[checkout]
  default = current
  autoStash = true
  recurseSubmodules = content

[status]
  showUntrackedFiles = no
  ignoreSubmodules = dirty

[diff]
  subscript = log
  externalTool = diff-so-fancy

[merge]
  conflictStyle = diff3
  ff = only

[log]
  pretty = oneline
  graph = true
  decorate = short
  source = git://github.com/
  abbrev = 8

[status]
  showUntrackedFiles = no
  ignoreSubmodules = dirty

[diff]
  subscript = log
  externalTool = diff-so-fancy

[merge]
  conflictStyle = diff3
  ff = only

[log]
  pretty = oneline
  graph = true
  decorate = short
  source = git://github.com/
  abbrev = 8
```

### Git Color Themes (`.gitconfig_themes`)

Git color themes for enhanced terminal output:

```bash
[color "bright"]
  color = true
  ui = true
  diff = true
  status = true
  branch = true

[color "normal"]
  user = true
  author = true
  subject = true
  body = true
  footer = true

[color "ui"]
  added = green
  modified = yellow
  deleted = red
  renamed = cyan
  copied = cyan
  typechange = yellow
  untracked = blue
  deletedByUs = red
  deletedByThem = red

[color "diff"]
  added = green
  deleted = red
  changed = yellow
  old = red
  new = green

[color "status"]
  added = green
  modified = yellow
  deleted = red
  untracked = blue
  ignored = gray

[color "branch"]
  current = green
  local = yellow
  remote = blue
  upstream = cyan
  merged = green
  rebasing = yellow
  merging = red
  conflict = red

[color "log"]
  oneline = green
  short = yellow
  full = cyan
  email = blue
  date = gray
  format = "%Cgreen%h%Creset %s (%cr)"

[color "grep"]
  matched = green
  selected = yellow
  context = gray

[color "apply"]
  on = green
  reset = red

[color "checkout"]
  on = green
  off = red

[color "reset"]
  on = green
  off = red

[color "fetch"]
  on = green
  off = red

[color "merge"]
  on = green
  off = red

[color "rebase"]
  on = green
  off = red

[color "push"]
  on = green
  off = red

[color "pull"]
  on = green
  off = red

[color "tag"]
  on = green
  off = red

[color "cherry-pick"]
  on = green
  off = red

[color "revert"]
  on = green
  off = red

[color "worktree"]
  on = green
  off = red

[color "reflog"]
  on = green
  off = red

[color "blame"]
  on = green
  off = red

[color "interactive"]
  on = green
  off = red

[color "submodule"]
  on = green
  off = red

[color "submodule-status"]
  on = green
  off = red

[color "submodule-summary"]
  on = green
  off = red

[color "submodule-sync"]
  on = green
  off = red

[color "submodule-update"]
  on = green
  off = red

[color "submodule-add"]
  on = green
  off = red

[color "submodule-deinit"]
  on = green
  off = red

[color "submodule-init"]
  on = green
  off = red

[color "submodule-register"]
  on = green
  off = red

[color "submodule-set-url"]
  on = green
  off = red

[color "submodule-summarize"]
  on = green
  off = red

[color "submodule-update"]
  on = green
  off = red

[color "submodule-status"]
  on = green
  off = red

[color "submodule-summary"]
  on = green
  off = red

[color "submodule-sync"]
  on = green
  off = red

[color "submodule-update"]
  on = green
  off = red

[color "submodule-add"]
  on = green
  off = red

[color "submodule-deinit"]
  on = green
  off = red

[color "submodule-init"]
  on = green
  off = red

[color "submodule-set-url"]
  on = green
  off = red

[color "submodule-summarize"]
  on = green
  off = red

[color "submodule-update"]
  on = green
  off = red
```

### Go Linter Configuration (`.golangci.yml`)

Go linter configuration:

```yaml
linters:
  enable:
    - bodyclose
    - deadcode
    - depguard
    - dogsled
    - dupl
    - errcheck
    - exportloopref
    - forbidigo
    - funlen
    - gci
    - gochecknoinits
    - gochecknoglobals
    - gocognit
    - goconst
    - gocritic
    - gocyclo
    - godot
    - godox
    - gofmt
    - goimports
    - golint
    - gomnd
    - goprints
    - gosec
    - gosimple
    - govet
    - grouper
    - importas
    - ineffassign
    - interfacer
    - lll
    - loggercheck
    - misspell
    - nilnil
    - nlreturn
    - noctx
    - nolint
    - nonamedreturns
    - nosnakecase
    - paralleltest
    - prealloc
    - predeclared
    - testpackage
    - thelper
    - unparam
    - unused
    - varcheck
    - whitespace
    - wrapcheck
    - wsl

  disable:
    - all

linters-settings:
  funlen:
    lines: 100
    statements: 50
  gci:
    local-prefixes: khulnasoft
  golint:
    min-confidence: 0
  gosec:
    excludes:
      - G104
      - G106
      - G107
      - G201
      - G202
      - G203
      - G204
      - G301
      - G302
      - G303
      - G304
      - G305
      - G306
      - G307
      - G308
      - G309
      - G31
```

### Prettier Configuration (`.prettierrc`)

JavaScript formatter configuration:

```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "bracketSpacing": true,
  "arrowParens": "avoid",
  "endOfLine": "lf",
  "printWidth": 80,
  "useTabs": false
}
```

## XDG Configuration

### XDG Base Directory Specification

The repository follows the XDG Base Directory specification for configuration files:

```bash
# XDG directories
~/.config/          # Configuration files
~/.local/share/     # User data
~/.cache/           # Cache files
~/.state/           # State information
```

### Tool-Specific XDG Configuration

#### broot Configuration (`config/broot/`)

File tree browser configuration:

```bash
# broot.conf
[display]
  default_layout = "tree"
  show_hidden = false
  show_git_status = true

[colors]
  default_color = "#ebdbb2"
  directory_color = "#458588"
  executable_color = "#98971a"
  symlink_color = "#83a598"

[keys]
  :help = "?"
  :quit = "q"
  :cd = "c"
  :back = "h"
  :refresh = "r"
  :search = "/"
```

#### fsh Configuration (`config/fsh/`)

Fast Syntax Highlighting configuration:

```bash
# current_theme.zsh
current_theme="base16-gruvbox-dark-medium"

# secondary_theme.zsh
current_theme="base16-gruvbox-light-medium"
```

#### ghostty Configuration (`config/ghostty/`)

Terminal emulator configuration:

```bash
# ghostty.conf
font-family = "Hack Nerd Font"
font-size = 12
background = "#282828"
foreground = "#ebdbb2"

[colors]
  red = "#cc241d"
  green = "#98971a"
  yellow = "#d79921"
  blue = "#458588"
  magenta = "#b16286"
  cyan = "#689d6a"
  white = "#ebdbb2"
```

#### nvim Configuration (`config/nvim/`)

Neovim configuration:

```bash
# coc-settings.json
{
  "python.pythonPath": "/usr/local/bin/python3",
  "eslint.enable": true,
  "tsserver.enable": true,
  "phpactor.enable": true,
  "intelephense.enable": true,
  "vimtex.enable": true,
  "lua.enable": true,
  "rust-analyzer.enable": true,
  "go.gopath": "/home/linuxbrew/.linuxbrew/opt/go"
}
```

#### pip Configuration (`config/pip/`)

Python package manager configuration:

```bash
# pip.conf
[global]
  user = true
  require-virtualenv = true
  no-cache-dir = true
```

#### smug Configuration (`config/smug/`)

Tmux session manager configuration:

```bash
# dotfiles.yml
defaults:
  session: "default"
  window: "main"
  pane: "main"

sessions:
  default:
    windows:
      - name: "main"
        panes:
          - cd ~
          - echo "Welcome to KhulnaSoft tmux sessions"

  development:
    windows:
      - name: "editor"
        panes:
          - nvim
      - name: "terminal"
        panes:
          - bash
      - name: "runner"
        panes:
          - echo "Runner window"

  testing:
    windows:
      - name: "tests"
        panes:
          - echo "Test runner"
      - name: "coverage"
        panes:
          - echo "Coverage report"
```

## Configuration Validation

### Validation Rules

#### Shell Script Validation
- **Syntax Check**: Validates bash/zsh syntax
- **Shebang Check**: Ensures proper shebang lines
- **Metadata Check**: Validates script metadata headers
- **Error Handling**: Checks for proper error handling

#### JSON Validation
- **Syntax Check**: Validates JSON syntax
- **Schema Validation**: Validates against JSON schema
- **Required Fields**: Checks for required fields

#### YAML Validation
- **Syntax Check**: Validates YAML syntax
- **Schema Validation**: Validates against YAML schema
- **Indentation**: Checks for proper indentation

#### Editor Configuration Validation
- **Syntax Check**: Validates Vim/Neovim syntax
- **Plugin Validation**: Checks for plugin availability
- **Settings Validation**: Validates configuration settings

#### Git Configuration Validation
- **Syntax Check**: Validates Git configuration syntax
- **Required Settings**: Checks for required Git settings
- **Alias Validation**: Validates Git aliases

### Validation Script

The repository includes a validation script `tools/bin/executable_validate.sh` that performs comprehensive validation of all configuration files.

## Configuration Customization

### Local Overrides

Users can override configurations by creating local configuration files:

#### Shell Configuration Override

Create `.zshrc_local` in your home directory:

```bash
cat > ~/.zshrc_local << 'EOF'
# Custom shell configuration
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

#### Git Configuration Override

Create `.gitconfig_local` in your home directory:

```bash
cat > ~/.gitconfig_local << 'EOF'
[user]
  name = Your Name
  email = your.email@example.com

[github]
  user = your-github-username
  token = your-github-personal-access-token
EOF
```

#### Editor Configuration Override

Create `.vimrc_local` or `~/.config/nvim/lua/custom.lua` for custom editor settings:

```bash
# For Vim
cat > ~/.vimrc_local << 'EOF'
" Custom Vim configuration
set number
set tabstop=4
set shiftwidth=4
set expandtab
EOF

# For Neovim
cat > ~/.config/nvim/lua/custom.lua << 'EOF'
-- Custom Neovim configuration
vim.notify("Custom Neovim configuration loaded", "info")
EOF
```

### Environment Variables

Set environment variables in your shell configuration:

```bash
cat >> ~/.zshrc_local << 'EOF'
# Environment variables
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Path settings
export PATH="$HOME/.local/bin:$PATH"
EOF
```

## Configuration Security

### Secure Configuration Practices

1. **Never commit sensitive data** to the repository
2. **Use environment variables** for sensitive configuration
3. **Set proper file permissions** for configuration files
4. **Use GPG signing** for critical configurations
5. **Implement access controls** for shared configurations

### Configuration Validation

The repository includes comprehensive validation to ensure configuration security:

- **Syntax validation** for all configuration files
- **Required field validation** for critical settings
- **Path validation** for file references
- **Permission validation** for sensitive files

## Configuration Examples

### Example Shell Configuration

```bash
# Example .zshrc_local
cat > ~/.zshrc_local << 'EOF'
# Custom shell settings
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
EOF
```

### Example Git Configuration

```bash
# Example .gitconfig_local
cat > ~/.gitconfig_local << 'EOF'
[user]
  name = John Doe
  email = john.doe@example.com

[github]
  user = johndoe
  token = ghp_xxxxxxxxxxxxxxxxxxxx

[core]
  editor = nvim
  autocrlf = input
  eol = lf

[color]
  ui = true
  diff = auto
  status = auto
  branch = auto
EOF
```

### Example Editor Configuration

```bash
# Example .vimrc_local
cat > ~/.vimrc_local << 'EOF'
" Custom Vim configuration
set number
set tabstop=4
set shiftwidth=4
set expandtab

" Custom colorscheme
set background=dark
colorscheme desert
EOF

# Example ~/.config/nvim/lua/custom.lua
cat > ~/.config/nvim/lua/custom.lua << 'EOF'
-- Custom Neovim configuration
vim.notify("Custom Neovim configuration loaded", "info")

-- Custom key mappings
vim.keymap.set('n', '<leader>e', ':Neogit<CR>')
EOF
```

## Configuration Troubleshooting

### Common Issues

#### Shell Configuration Issues

**Issue**: Shell not loading configurations
**Solution**: Close and reopen terminal or run `source ~/.zshrc`

**Issue**: Custom aliases not working
**Solution**: Ensure `.zshrc_local` is sourced in `.zshrc`

#### Editor Configuration Issues

**Issue**: Editor not loading custom settings
**Solution**: Check that custom configuration files are in the correct location

**Issue**: Syntax errors in editor configuration
**Solution**: Validate editor configuration syntax

#### Git Configuration Issues

**Issue**: Git configuration not applied
**Solution**: Check that `.gitconfig_local` is in the correct location

**Issue**: Git aliases not working
**Solution**: Validate Git configuration syntax

### Troubleshooting Commands

```bash
# Check shell configuration
source ~/.zshrc

# Check editor configuration
nvim --version
vim --version

# Check Git configuration
git config --list | grep user.name
git config --list | grep user.email

# Run validation script
tools/bin/executable_validate.sh
```

## Configuration Best Practices

### 1. Keep Configurations Modular

- Use separate configuration files for different tools
- Keep configuration files focused on specific settings
- Use environment variables for sensitive data

### 2. Use Version Control

- Commit configuration files to version control
- Use Git for configuration management
- Track configuration changes over time

### 3. Validate Configurations

- Use validation scripts to check configuration syntax
- Test configurations in a development environment
- Validate configurations before applying to production

### 4. Document Configurations

- Document configuration options and settings
- Provide examples for common configurations
- Document troubleshooting steps

### 5. Secure Configurations

- Never commit sensitive data to version control
- Use environment variables for sensitive configuration
- Set proper file permissions for configuration files
- Use GPG signing for critical configurations

## Conclusion

The KhulnaSoft dotfiles repository provides comprehensive configuration management with:

- **Modular Design**: Clear separation of concerns for different tools
- **Extensive Customization**: Support for user-specific configurations
- **Validation**: Comprehensive validation of all configuration files
- **Security**: Secure configuration management practices
- **Documentation**: Detailed documentation and examples

The configuration system is designed to be:

- **User-friendly**: Easy to set up and customize
- **Maintainable**: Well-organized and documented
- **Scalable**: Easy to add new tools and configurations
- **Secure**: Protects sensitive data and configurations

This configuration management approach ensures that users can easily customize their development environment while maintaining consistency and security across different platforms and projects.

## References

- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
- [ShellScript Best Practices](https://www.shellscript.sh)
- [Git Configuration Documentation](https://git-scm.com/docs/git-config)
- [Vim Configuration Guide](https://vim.fandom.com/wiki/Vim_Tips)
- [Neovim Documentation](https://neovim.io/doc/)
- [Tmux Configuration Guide](https://tmuxcheatsheet.com)
- [Homebrew Documentation](https://brew.sh)
- [JSON Schema](https://json-schema.org)
- [YAML Specification](https://yaml.org/spec/1.2/spec.html)
