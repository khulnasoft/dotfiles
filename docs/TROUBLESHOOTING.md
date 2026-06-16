# KhulnaSoft Dotfiles - Troubleshooting Guide

This document provides comprehensive troubleshooting information for the KhulnaSoft dotfiles repository, including common issues, solutions, and debugging techniques.

## Overview

The KhulnaSoft dotfiles repository is a complex system with many components and configurations. While the installation process is generally straightforward, users may encounter various issues during setup, configuration, or runtime. This guide provides solutions to common problems and debugging techniques to help users resolve issues quickly.

## Common Issues and Solutions

### 1. Installation Issues

#### Issue: Homebrew not installed

**Problem**: Homebrew is not installed on macOS or Linux.

**Solution**:
```bash
# Install Homebrew (macOS)
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

# Install Homebrew (Linux)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Issue: Insufficient permissions

**Problem**: User does not have sufficient permissions to install packages or modify system files.

**Solution**:
```bash
# Check permissions
ls -ld $HOME

# If permissions are insufficient, use sudo for installation
# or install in user directory
sudo chown -R $(whoami) $HOME
```

#### Issue: GitHub authentication required

**Problem**: GitHub authentication is required to access the repository.

**Solution**:
```bash
# Authenticate with GitHub
gh auth login

# Or set up SSH keys
ssh-keygen -t ed25519 -C "your-email@example.com"
# Copy the public key to GitHub
```

#### Issue: Network connectivity problems

**Problem**: Network connectivity issues prevent downloading files or accessing repositories.

**Solution**:
```bash
# Check network connectivity
curl -I https://github.com

# If network is available, try again
# If network is not available, use a different network
```

### 2. Configuration Issues

#### Issue: Shell not loading configurations

**Problem**: Shell is not loading dotfiles configurations.

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

#### Issue: Editor not working

**Problem**: Editor (Neovim/Vim) is not working correctly.

**Solution**:
```bash
# Check if editor is installed
which nvim
which vim

# Install editor if not present
brew install neovim
brew install vim

# Reapply dotfiles
chzmoi apply -v

# Check for syntax errors
nvim --headless -c "syntax check" -c "quit"
vim --headless -c "syntax check" -c "quit"
```

#### Issue: Git configuration not applied

**Problem**: Git configuration is not applied correctly.

**Solution**:
```bash
# Check Git configuration
git config --list | grep user.name
git config --list | grep user.email

# If not set, create .gitconfig_local
if [ ! -f ~/.gitconfig_local ]; then
  cat > ~/.gitconfig_local << 'EOF'
[user]
  name = Your Name
  email = your.email@example.com
EOF
fi

# Reapply dotfiles
chzmoi apply -v
```

#### Issue: Terminal configuration not applied

**Problem**: Terminal (tmux) configuration is not applied correctly.

**Solution**:
```bash
# Check if tmux is installed
which tmux

# Install tmux if not present
brew install tmux

# Reapply dotfiles
chzmoi apply -v

# Check tmux configuration
tmux list-keys
```

### 3. Runtime Issues

#### Issue: Shell commands not working

**Problem**: Custom shell commands or aliases are not working.

**Solution**:
```bash
# Check if .zshrc_local is sourced
source ~/.zshrc_local

# Check for syntax errors in .zshrc_local
bash -n ~/.zshrc_local

# Test custom aliases
git status
ls -la
```

#### Issue: Editor commands not working

**Problem**: Custom editor commands or mappings are not working.

**Solution**:
```bash
# Check if editor configuration is loaded
nvim --headless -c "echo 'Neovim is working'"
vim --headless -c "echo 'Neovim is working'"

# Check for syntax errors
nvim --headless -c "syntax check" -c "quit"
```

#### Issue: Git commands not working

**Problem**: Git commands are not working correctly.

**Solution**:
```bash
# Check Git configuration
git config --list | grep user.name
git config --list | grep user.email

# Check Git status
git status

# Try a simple Git command
git log --oneline -1
```

### 4. Validation Issues

#### Issue: Validation script not working

**Problem**: The validation script is not working correctly.

**Solution**:
```bash
# Check if validation script exists
ls -la tools/bin/executable_validate.sh

# Make it executable
chmod +x tools/bin/executable_validate.sh

# Run validation script
./tools/bin/executable_validate.sh

# Check for errors
./tools/bin/executable_validate.sh 2>&1 | head -20
```

#### Issue: Validation script errors

**Problem**: The validation script is reporting errors.

**Solution**:
```bash
# Run validation script with verbose output
./tools/bin/executable_validate.sh -v

# Check validation script logs
./tools/bin/executable_validate.sh --log

# Fix any issues found
```

### 5. Performance Issues

#### Issue: Slow shell startup

**Problem**: Shell startup is slow.

**Solution**:
```bash
# Check for slow-loading configurations
# Disable unnecessary plugins
# Remove unused configurations
# Optimize shell configuration
```

#### Issue: Slow editor startup

**Problem**: Editor startup is slow.

**Solution**:
```bash
# Check for slow-loading plugins
# Disable unnecessary plugins
# Optimize editor configuration
```

#### Issue: Slow tmux startup

**Problem**: tmux startup is slow.

**Solution**:
```bash
# Check for slow-loading plugins
# Disable unnecessary plugins
# Optimize tmux configuration
```

### 6. Security Issues

#### Issue: Security vulnerabilities

**Problem**: Security vulnerabilities are present in configurations.

**Solution**:
```bash
# Check for hardcoded credentials
# Use environment variables for sensitive data
# Set proper file permissions
# Use GPG signing for critical configurations
```

#### Issue: Permission issues

**Problem**: Permission issues are present in configuration files.

**Solution**:
```bash
# Check file permissions
ls -la ~/.zshrc_local
ls -la ~/.vimrc_local
ls -la ~/.gitconfig_local

# Set proper permissions
chmod 600 ~/.zshrc_local
chmod 600 ~/.vimrc_local
chmod 600 ~/.gitconfig_local
```

## Debugging Techniques

### 1. Check Logs

Check for error messages in log files:

```bash
# Check shell history
cat ~/.zsh_history | tail -20

# Check editor logs
ls -la ~/.local/share/nvim*

# Check tmux logs
ls -la ~/.tmux/log

# Check Git logs
git log --oneline -10
```

### 2. Use Debug Mode

Enable debug mode for troubleshooting:

```bash
# Enable debug mode for shell
source ~/.zshrc_local

# Enable debug mode for editor
nvim --headless -c "set verbose" -c "quit"

# Enable debug mode for tmux
tmux -2 -f ~/.tmux.conf.debug
```

### 3. Test Configurations

Test configurations individually:

```bash
# Test shell configuration
source ~/.zshrc_local

# Test editor configuration
nvim --headless -c "syntax check" -c "quit"

# Test Git configuration
git config --list | grep user.name

# Test terminal configuration
tmux list-keys
```

### 4. Use Validation Script

Use the validation script to check for issues:

```bash
# Run validation script
./tools/bin/executable_validate.sh

# Check validation results
./tools/bin/executable_validate.sh --report
```

### 5. Use Help Commands

Use help commands to get more information:

```bash
# Get help for shell commands
man bash
man zsh

# Get help for editor commands
nvim --help
vim --help

# Get help for Git commands
git --help
```

## Common Error Messages

### Shell Configuration Errors

**Error**: "command not found"

**Solution**: Check if the command is available in the PATH or install the required package.

**Error**: "permission denied"

**Solution**: Check file permissions and ensure the file is readable.

**Error**: "syntax error"

**Solution**: Check the syntax of the configuration file.

### Editor Configuration Errors

**Error**: "E185: circular dependency"

**Solution**: Check for circular dependencies in plugin configuration.

**Error**: "E5: ‘{’ expected"

**Solution**: Check for syntax errors in configuration files.

**Error**: "E211: 'space' before colon"

**Solution**: Check for indentation issues in configuration files.

### Git Configuration Errors

**Error**: "fatal: bad config value for key"

**Solution**: Check the configuration file for invalid values.

**Error**: "fatal: unable to read config file"

**Solution**: Check if the configuration file exists and is readable.

### Terminal Configuration Errors

**Error**: "unknown option"

**Solution**: Check the tmux configuration file for syntax errors.

**Error**: "session not found"

**Solution**: Check if the tmux session is running.

## Troubleshooting Checklist

### Before Reporting an Issue

1. **Check the documentation**: Review the troubleshooting guide and documentation
2. **Reproduce the issue**: Try to reproduce the issue before reporting
3. **Gather information**: Collect relevant information about the issue
4. **Test in a clean environment**: Test in a clean environment if possible
5. **Check for known issues**: Check if the issue is already known

### When Reporting an Issue

1. **Provide detailed information**: Include all relevant information
2. **Include error messages**: Include all error messages and stack traces
3. **Provide steps to reproduce**: Include steps to reproduce the issue
4. **Include configuration details**: Include configuration details
5. **Attach logs**: Attach relevant log files

### After Fixing an Issue

1. **Test the fix**: Test the fix thoroughly
2. **Update documentation**: Update documentation if necessary
3. **Share the fix**: Share the fix with the community
4. **Create a pull request**: Create a pull request if the fix is ready

## Community Support

### Getting Help

1. **Check the documentation**: Review the troubleshooting guide and documentation
2. **Check GitHub issues**: Check if the issue is already reported
3. **Submit an issue**: Submit a new issue if the problem is not reported
4. **Join the community**: Join the community for support

### Contributing

1. **Report issues**: Report issues and bugs
2. **Fix issues**: Fix issues and submit pull requests
3. **Improve documentation**: Improve documentation and guides
4. **Share knowledge**: Share knowledge and best practices

### Support Channels

- **GitHub Issues**: Report issues and bugs
- **GitHub Discussions**: Discuss features and improvements
- **Community Forums**: Discuss with other users
- **Social Media**: Follow on social media for updates

## Conclusion

Troubleshooting is an essential part of using the KhulnaSoft dotfiles repository. By following the troubleshooting guide and using the debugging techniques, you can quickly resolve issues and ensure your development environment is working correctly.

The troubleshooting guide provides:

- **Comprehensive solutions**: Solutions to common issues
- **Debugging techniques**: Techniques for debugging issues
- **Error messages**: Common error messages and solutions
- **Community support**: Channels for getting help

This troubleshooting guide is designed to help users:

- **Resolve issues quickly**: Find solutions to common issues
- **Debug problems**: Use debugging techniques to identify issues
- **Get help**: Get help from the community
- **Contribute**: Contribute to the repository

**Enjoy troubleshooting with KhulnaSoft!** 🛠️
