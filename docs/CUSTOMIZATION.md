# KhulnaSoft Dotfiles - Customization Guide

This document provides comprehensive information about customizing and extending the KhulnaSoft dotfiles repository to meet specific requirements and workflows.

## Overview

The KhulnaSoft dotfiles repository is designed to be highly customizable, allowing users to:

- **Extend existing tools** with custom configurations
- **Add new tools** to the repository
- **Override default settings** for specific use cases
- **Create custom workflows** and automation
- **Integrate with external services** and tools

## Customization Methods

### 1. Local Overrides

The easiest way to customize the dotfiles is to create local override files in your home directory:

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
EOF
```

#### Editor Configuration Override

Create `.vimrc_local` for Vim or `~/.config/nvim/lua/custom.lua` for Neovim:

```bash
# For Vim
cat > ~/.vimrc_local << 'EOF'
" Custom Vim configuration
set number
set tabstop=4
set shiftwidth=4
set expandtab

" Custom colorscheme
set background=dark
colorscheme desert

" Custom plugins
if has("win16") || has("win32") || has("win64")
  set g:python_host_prog = expand($HOME . '/.venvs/py2/venv/bin/python')
  set g:python3_host_prog = expand($HOME . '/.venvs/py3/venv/bin/python')
endif
EOF

# For Neovim
cat > ~/.config/nvim/lua/custom.lua << 'EOF'
-- Custom Neovim configuration
vim.notify("Custom Neovim configuration loaded", "info")

-- Custom key mappings
vim.keymap.set('n', '<leader>e', ':Neogit<CR>')
vim.keymap.set('n', '<leader>f', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>g', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>h', ':Telescope help_tags<CR>')

-- Custom plugins
local ok, custom = pcall(require, 'custom')
if ok then
  custom.setup()
end
EOF
```

### 2. Environment Variables

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
export PYTHONPATH="$HOME/.local/lib/python3.9/site-packages:$PYTHONPATH"

# Tool-specific variables
export FZF_DEFAULT_COMMAND='find . -type f -name "*.py" -o -name "*.js" -o -name "*.ts" -o -name "*.md"'
export FZF_CTRL_T_COMMAND='find . -type f'
export FZF_ALT_C_COMMAND='find . -type d'
EOF
```

### 3. Custom Scripts

Add custom scripts to your `tools/bin/` directory:

```bash
# Create a custom script
cat > ~/tools/bin/custom_script.sh << 'EOF'
#!/bin/bash
# Custom script description

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --help|-h)
      echo "Usage: $0 [options]"
      echo "Options:"
      echo "  --help, -h    Show this help message"
      echo "  --version     Show version information"
      exit 0
      ;;
    --version)
      echo "Custom script version 1.0.0"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
 done

# Main script logic
echo "Custom script executed"

# Example: Process files
for file in "$@"; do
  if [[ -f "$file" ]]; then
    echo "Processing file: $file"
    # Add your processing logic here
  else
    echo "Warning: File not found: $file"
  fi
done
EOF

# Make it executable
chmod +x ~/tools/bin/custom_script.sh
```

### 4. Custom Plugins

Add custom plugins to your editor configuration:

#### Vim Plugin

Create a `.vimrc_local` file with custom plugin configuration:

```bash
cat > ~/.vimrc_local << 'EOF'
" Custom Vim plugins
" Example: Add a custom plugin
Plugin 'tpope/vim-sensible'

" Example: Configure a plugin
let g:python_host_prog = '/usr/bin/python3'
let g:python3_host_prog = '/usr/bin/python3'

" Example: Set up plugin management
if ! exists('g:loaded_plugin_system')
  source ~/.vim/plugins.vim
endif
EOF

# Create plugins.vim file
cat > ~/.vim/plugins.vim << 'EOF'
" Plugin management
if has('nvim')
  call plug#begin('~/.vim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Essential plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Editor enhancements
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/pangu.vim'
Plug 'vim-airline/vim-airline'

" Language support
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'

" Completion
Plug 'valloric/YouCompleteMe'

" Formatting
Plug 'sirtux/vim-autopep8'
Plug 'styled-components/vim-styled-components'

call plug#end()

" Plugin configuration
let g:airline#extensions#tabline#enable = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#fnamemod = ':s'
let g:airline#extensions#tabline#formatter = 'unique_tail'
EOF
```

#### Neovim Plugin

Create a `~/.config/nvim/lua/plugins.lua` file with custom plugin configuration:

```bash
cat > ~/.config/nvim/lua/plugins.lua << 'EOF'
-- Custom Neovim plugins
local plug = require('plenary.reloadable')(vim.api.nvim_get_current_buf, { 'plugins' })

plug.load_modules('plugins')

-- Plugin configuration
local M = {}

function M.setup()
  -- Configure plugins
  vim.notify("Custom Neovim plugins loaded", "info")
end

return M
EOF

# Create plugins/init.lua file
cat > ~/.config/nvim/lua/plugins/init.lua << 'EOF'
-- Plugin management
local plug = require('plenary.reloadable')(vim.api.nvim_get_current_buf, { 'plugins' })

plug.load_modules('plugins')

-- Plugin configuration
local M = {}

function M.setup()
  -- Configure plugins
  vim.notify("Custom Neovim plugins loaded", "info")
end

return M
EOF
```

### 5. Custom Workflows

Create custom workflows in your `tools/bin/` directory:

```bash
# Create a custom workflow
cat > ~/tools/bin/custom_workflow.sh << 'EOF'
#!/bin/bash
# Custom workflow script

# Workflow description
# This script performs a custom workflow for the project

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --help|-h)
      echo "Usage: $0 [options]"
      echo "Options:"
      echo "  --help, -h    Show this help message"
      echo "  --env <env>   Set environment (dev/staging/prod)"
      echo "  --verbose     Enable verbose output"
      exit 0
      ;;
    --env)
      shift
      ENVIRONMENT="$1"
      ;;
    --verbose)
      set -x
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
 done

# Set default values
ENVIRONMENT="dev"
VERBOSE=false

# Main workflow logic
echo "Starting custom workflow..."
echo "Environment: $ENVIRONMENT"

echo "Step 1: Setting up environment"
# Add environment setup logic here

echo "Step 2: Running pre-checks"
# Add pre-check logic here

if [ "$VERBOSE" = true ]; then
  echo "Verbose mode enabled"
fi

echo "Workflow completed successfully"
EOF

# Make it executable
chmod +x ~/tools/bin/custom_workflow.sh
```

## Extending the Repository

### Adding New Tools

To add a new tool to the repository:

1. **Create a new directory** in the appropriate category
2. **Add configuration files** for the tool
3. **Update documentation** with tool-specific guides
4. **Add integration** to shell or terminal if needed
5. **Test** the tool with existing workflows

### Example: Adding a New Tool

#### Step 1: Create Tool Directory

```bash
# Create a new tool directory
mkdir -p ~/tools/bin/newtool
mkdir -p ~/tools/assets/newtool
```

#### Step 2: Create Configuration Files

```bash
# Create tool configuration
cat > ~/tools/bin/newtool/executable_newtool.sh << 'EOF'
#!/bin/bash
# New tool executable

echo "New tool executed"

# Add tool-specific logic here
EOF

# Create tool assets
cat > ~/tools/assets/newtool/icon.png << 'EOF'
# Tool icon (binary data)
EOF

# Create tool documentation
cat > ~/tools/bin/newtool/README.md << 'EOF'
# New Tool

## Overview
This is a new tool for the KhulnaSoft dotfiles repository.

## Installation
Add the tool to your PATH or use the provided scripts.

## Usage
Use the executable script with appropriate options.

## Configuration
Configure the tool in your local configuration files.
EOF
```

#### Step 3: Update Documentation

Add documentation for the new tool:

```bash
# Add to docs/tools/newtool.md
cat > docs/tools/newtool.md << 'EOF'
# New Tool Guide

## Overview
This guide provides information about the new tool.

## Installation
Instructions for installing the new tool.

## Configuration
Configuration options for the new tool.

## Usage
Usage examples and commands.

## Troubleshooting
Common issues and solutions.
EOF
```

#### Step 4: Update Main Documentation

Update the main documentation to reference the new tool:

```bash
# Update docs/README.md
cat >> docs/README.md << 'EOF'

## Additional Tools

The repository includes additional tools beyond the core set:

- **New Tool**: Brief description of the new tool
- **Tool Name**: Another tool description
- **Tool Name**: Yet another tool description

For detailed documentation on each tool, see the tool-specific guides.
EOF
```

## Customization Best Practices

### 1. Keep Changes Minimal

- Make only the necessary changes
- Avoid modifying core configuration files
- Use local overrides instead of modifying original files

### 2. Document Changes

- Document all customizations
- Keep track of changes made
- Share customizations with the community

### 3. Test Changes

- Test customizations in a development environment
- Ensure customizations don't break existing functionality
- Validate customizations with the validation script

### 4. Use Version Control

- Commit customizations to version control
- Use Git for configuration management
- Track changes over time

### 5. Secure Customizations

- Never commit sensitive data to version control
- Use environment variables for sensitive configuration
- Set proper file permissions for custom files

## Migration Guide

### From Previous Versions

Migration from previous versions involves:

1. **Backup existing configurations**
2. **Update to new directory structure**
3. **Migrate configuration files** to new locations
4. **Test all configurations**
5. **Update documentation references**

### For New Users

New users can:

1. **Run the installation script**
2. **Follow the setup guide**
3. **Customize as needed**
4. **Explore tool guides**
5. **Join the community**

## Troubleshooting Customization

### Common Customization Issues

**Issue: Customization not working**

Solution:
```bash
# Check if customization files are in the correct location
ls -la ~/.zshrc_local
ls -la ~/.vimrc_local
ls -la ~/.gitconfig_local

# Source the customization files
source ~/.zshrc_local
source ~/.vimrc_local
```

**Issue: Customization conflicts with existing settings**

Solution:
```bash
# Check for conflicts
# Modify customization to avoid conflicts
# Use different configuration options
```

**Issue: Customization breaks existing functionality**

Solution:
```bash
# Test customization in a development environment
# Revert changes if necessary
# Seek help from the community
```

### Getting Help

If you encounter issues:

1. **Check the documentation** for customization instructions
2. **Review the troubleshooting guide** for common issues
3. **Submit an issue** if you can't find a solution
4. **Contribute** by sharing your customizations

## Conclusion

The KhulnaSoft dotfiles repository provides extensive customization options:

- **Flexibility**: Support for user-specific customizations
- **Extensibility**: Easy to add new tools and features
- **Maintainability**: Clear separation of concerns
- **Security**: Secure customization practices

The customization system is designed to be:

- **User-friendly**: Easy to customize and extend
- **Maintainable**: Well-documented and organized
- **Scalable**: Easy to add new customizations
- **Secure**: Protects sensitive data and configurations

This customization approach ensures that users can easily extend and modify the dotfiles to meet their specific requirements while maintaining consistency and security across different platforms and projects.

## References

- [Chezmoi Documentation](https://www.chezmoi.io)
- [ShellScript Best Practices](https://www.shellscript.sh)
- [Git Configuration Documentation](https://git-scm.com/docs/git-config)
- [Vim Configuration Guide](https://vim.fandom.com/wiki/Vim_Tips)
- [Neovim Documentation](https://neovim.io/doc/)
- [Tmux Configuration Guide](https://tmuxcheatsheet.com)
- [Homebrew Documentation](https://brew.sh)
- [JSON Schema](https://json-schema.org)
- [YAML Specification](https://yaml.org/spec/1.2/spec.html)
