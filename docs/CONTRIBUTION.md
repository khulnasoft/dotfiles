# KhulnaSoft Dotfiles - Contribution Guide

This document provides comprehensive information about contributing to the KhulnaSoft dotfiles repository, including contribution guidelines, code standards, and best practices.

## Overview

The KhulnaSoft dotfiles repository welcomes contributions from the community. This guide provides information about:

- **Contribution guidelines**: How to contribute to the repository
- **Code standards**: Code quality and style guidelines
- **Pull request process**: How to submit and review pull requests
- **Issue management**: How to report and track issues
- **Community guidelines**: Community standards and expectations

## Contribution Guidelines

### 1. Getting Started

#### Prerequisites

Before contributing, ensure you have:

- **Git**: Installed and configured
- **GitHub**: Account for submitting pull requests
- **Development environment**: Local development environment

#### Fork and Clone

1. **Fork the repository**:
   ```bash
   git clone https://github.com/khulnasoft/dotfiles.git
   cd dotfiles
   ```

2. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Set up your local environment**:
   ```bash
   # Install dependencies
   tools/bin/executable_install.sh

   # Run validation
   tools/bin/executable_validate.sh
   ```

### 2. Code Standards

#### Commit Message Guidelines

Follow these guidelines for commit messages:

```
<type>[scope]: <description>

[optional body]

[optional footer]:
  Co-authored-by: <name> <email>
```

**Commit types**:
- `feat`: New feature
- `fix`: Bug fix

**Commit scopes** (examples):
- `docs`: Documentation
- `style`: Code style
- `refactor`: Code refactoring
- `test`: Testing
- `chore`: Maintenance

**Example commit messages**:
```
feat(docs): add contribution guidelines

Add comprehensive contribution guidelines for the repository.

Co-authored-by: Your Name <your.email@example.com>

fix(style): correct indentation in shell scripts

Fix indentation issues in shell scripts to match project standards.

Co-authored-by: Your Name <your.email@example.com>
```

#### Code Style Guidelines

Follow these code style guidelines:

1. **Shell Scripts**:
   - Use proper indentation (2 spaces)
   - Use descriptive variable names
   - Add comments for complex logic
   - Use error handling
   - Validate input

2. **Configuration Files**:
   - Use consistent formatting
   - Follow YAML/JSON best practices
   - Use descriptive keys
   - Add comments for complex configurations

3. **Documentation**:
   - Use Markdown formatting
   - Follow project documentation standards
   - Provide clear explanations
   - Include examples

### 3. Pull Request Process

#### Creating a Pull Request

1. **Make changes**:
   - Implement your feature or fix
   - Write tests if applicable
   - Update documentation if necessary

2. **Stage changes**:
   ```bash
   git add .
   ```

3. **Commit changes**:
   ```bash
   git commit -m "feat(docs): add contribution guidelines"
   ```

4. **Push changes**:
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create a pull request**:
   - Go to the repository on GitHub
   - Click "Compare & pull request"
   - Fill in the pull request template
   - Review and submit

#### Pull Request Template

Use the following pull request template:

```markdown
## Description
Brief description of the changes.

## Changes
- List of changes made

## Testing
- Tests added/updated
- Manual testing performed

## Documentation
- Documentation updated
- Examples provided

## Checklist
- [ ] Code follows project standards
- [ ] Tests pass
- [ ] Documentation updated
- [ ] No linting errors
- [ ] Pull request reviewed
```

### 4. Code Review Process

#### Reviewing a Pull Request

1. **Check the description**: Read the pull request description
2. **Review the changes**: Check the changes made
3. **Run tests**: Run the tests if applicable
4. **Check code quality**: Review code quality and style
5. **Merge if ready**: Merge the pull request if it meets all requirements

#### Reviewing Guidelines

1. **Code quality**:
   - Code follows project standards
   - Code is readable and maintainable
   - Code has proper error handling
   - Code has appropriate comments

2. **Testing**:
   - Tests are comprehensive
   - Tests cover edge cases
   - Tests are easy to run

3. **Documentation**:
   - Documentation is clear and comprehensive
   - Examples are provided
   - Documentation follows project standards

4. **Integration**:
   - Changes integrate well with existing code
   - No conflicts with other features
   - Backward compatibility is maintained

### 5. Issue Management

#### Reporting Issues

1. **Check existing issues**: Check if the issue is already reported
2. **Create a new issue**: Create a new issue if the problem is not reported
3. **Provide information**: Provide detailed information about the issue
4. **Tag the issue**: Tag the issue with appropriate labels

#### Working on Issues

1. **Assign an issue**: Assign an issue to yourself
2. **Create a branch**: Create a branch for the issue
3. **Implement a solution**: Implement a solution for the issue
4. **Test the solution**: Test the solution thoroughly
5. **Create a pull request**: Create a pull request for the solution

### 6. Community Guidelines

#### Code of Conduct

The KhulnaSoft dotfiles repository follows these community guidelines:

1. **Be respectful**: Treat all contributors with respect
2. **Be collaborative**: Work together to solve problems
3. **Be inclusive**: Welcome contributions from all backgrounds
4. **Be professional**: Maintain professional conduct in all interactions

#### Communication Guidelines

1. **Use clear language**: Use clear and concise language
2. **Be constructive**: Provide constructive feedback
3. **Focus on code**: Focus on code quality and functionality
4. **Document decisions**: Document decisions and reasoning

### 7. Branching Strategy

The repository uses the following branching strategy:

#### Main Branch

- **Purpose**: Production-ready code
- **Protection**: Protected from direct commits
- **Merge strategy**: Merge pull requests

#### Feature Branches

- **Purpose**: New features and fixes
- **Naming**: `feature/<feature-name>`
- **Lifecycle**: Created from main, merged into main

#### Release Branches

- **Purpose**: Release preparation
- **Naming**: `release/<version>`
- **Lifecycle**: Created from main, merged into main after release

### 8. Testing and Validation

#### Running Tests

Run the validation script to check for issues:

```bash
# Run validation script
tools/bin/executable_validate.sh

# Check for errors
./tools/bin/executable_validate.sh --verbose
```

#### Running Shellcheck

Run Shellcheck to validate shell scripts:

```bash
# Install Shellcheck if not present
if ! command -v shellcheck &> /dev/null; then
  # Install Shellcheck based on your OS
  # For Ubuntu/Debian:
  sudo apt-get install shellcheck
  # For macOS:
  brew install shellcheck
fi

# Run Shellcheck
shellcheck tools/bin/executable_validate.sh
```

#### Running Editor Syntax Check

Run editor syntax check to validate editor configurations:

```bash
# Check Vim syntax
vim --headless -c "syntax check" -c "quit"

# Check Neovim syntax
nvim --headless -c "syntax check" -c "quit"
```

### 9. Documentation

#### Documentation Guidelines

1. **Use Markdown**: Use Markdown for all documentation
2. **Follow project standards**: Follow project documentation standards
3. **Provide examples**: Provide examples for complex concepts
4. **Include code snippets**: Include code snippets for examples

#### Documentation Structure

The documentation structure is as follows:

```
docs/
├── README.md                    # Main documentation
├── ARCHITECTURE.md              # Architecture overview
├── INSTALLATION.md              # Installation guide
├── CONFIGURATION.md             # Configuration guide
├── CUSTOMIZATION.md             # Customization guide
├── TROUBLESHOOTING.md           # Troubleshooting guide
├── CONTRIBUTING.md              # Contribution guide
└── tools/                       # Tool-specific documentation
    ├── zsh.md
    ├── tmux.md
    ├── neovim.md
    ├── git.md
    └── homebrew.md
```

### 10. Security

#### Security Guidelines

1. **Never commit sensitive data**: Never commit passwords, tokens, or other sensitive data
2. **Use environment variables**: Use environment variables for sensitive configuration
3. **Set proper permissions**: Set proper file permissions for sensitive files
4. **Use GPG signing**: Use GPG signing for critical configurations

#### Security Checklist

- [ ] No hardcoded credentials in configuration files
- [ ] Environment variables used for sensitive data
- [ ] Proper file permissions for sensitive files
- [ ] GPG signing for critical configurations
- [ ] Input validation for all scripts
- [ ] Error handling for security-sensitive operations

## Conclusion

Contributing to the KhulnaSoft dotfiles repository is a collaborative process that requires:

- **Respect**: Treat all contributors with respect
- **Collaboration**: Work together to solve problems
- **Quality**: Maintain high standards for code and documentation
- **Communication**: Communicate clearly and professionally

The contribution guide provides:

- **Clear guidelines**: Guidelines for contributing to the repository
- **Best practices**: Best practices for code and documentation
- **Process**: Process for submitting and reviewing contributions
- **Support**: Support for contributors

This contribution guide is designed to help contributors:

- **Get started**: Get started with contributing to the repository
- **Follow standards**: Follow project standards and guidelines
- **Submit contributions**: Submit contributions effectively
- **Collaborate**: Collaborate with other contributors

**Welcome to the KhulnaSoft dotfiles repository!** 🎉

## Acknowledgments

The KhulnaSoft dotfiles repository is built on the contributions of many developers. We thank all contributors for their valuable contributions.

## License

This contribution guide is licensed under the terms of the MIT License.

## Version

Version: 1.0.0
Last Updated: June 16, 2026
