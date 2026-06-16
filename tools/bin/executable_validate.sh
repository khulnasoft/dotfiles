#!/bin/bash

# Validation script for KhulnaSoft dotfiles
# Validates all configurations and scripts

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Validation results
VALIDATION_ERRORS=0
VALIDATION_WARNINGS=0

# Function to print colored output
print_status() {
    local status=$1
    local message=$2
    case $status in
        "error")
            echo -e "${RED}❌ ERROR${NC}: $message";;
        "warning")
            echo -e "${YELLOW}⚠️  WARNING${NC}: $message";;
        "success")
            echo -e "${GREEN}✅ SUCCESS${NC}: $message";;
        *)
            echo -e "${NC}$message";;
    esac
}

# Function to validate shell scripts
shellcheck_scripts() {
    print_status "success" "Validating shell scripts..."
    local script_count=0
    local error_count=0
    
    # Find all shell scripts
    while IFS= read -r script; do
        script_count=$((script_count + 1))
        if [[ -f "$script" ]]; then
            print_status "success" "Checking $script"
            if shellcheck "$script" > /dev/null 2>&1; then
                print_status "success" "  ✅ $script - No issues"
            else
                print_status "warning" "  ⚠️  $script - Shellcheck warnings"
                VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + 1))
            fi
        fi
    done < <(find . -name "*.sh" -o -name "*.zsh" | grep -v ".git" | grep -v "__pycache__")
    
    print_status "success" "Total shell scripts checked: $script_count"
}

# Function to validate JSON files
validate_json_files() {
    print_status "success" "Validating JSON files..."
    local json_count=0
    local error_count=0
    
    while IFS= read -r json_file; do
        json_count=$((json_count + 1))
        if [[ -f "$json_file" ]]; then
            print_status "success" "Checking $json_file"
            if python -m json.tool "$json_file" > /dev/null 2>&1; then
                print_status "success" "  ✅ $json_file - Valid JSON"
            else
                print_status "error" "  ❌ $json_file - Invalid JSON"
                VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
            fi
        fi
    done < <(find . -name "*.json" | grep -v ".git" | grep -v "__pycache__")
    
    print_status "success" "Total JSON files checked: $json_count"
}

# Function to validate YAML files
validate_yaml_files() {
    print_status "success" "Validating YAML files..."
    local yaml_count=0
    local error_count=0
    
    while IFS= read -r yaml_file; do
        yaml_count=$((yaml_count + 1))
        if [[ -f "$yaml_file" ]]; then
            print_status "success" "Checking $yaml_file"
            if command -v yamllint &> /dev/null; then
                if yamllint "$yaml_file" > /dev/null 2>&1; then
                    print_status "success" "  ✅ $yaml_file - Valid YAML"
                else
                    print_status "warning" "  ⚠️  $yaml_file - YAML lint warnings"
                    VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + 1))
                fi
            else
                print_status "warning" "  ⚠️  yamllint not installed, skipping $yaml_file"
            fi
        fi
    done < <(find . -name "*.yaml" -o -name "*.yml" | grep -v ".git" | grep -v "__pycache__")
    
    print_status "success" "Total YAML files checked: $yaml_count"
}

# Function to validate Vim/Neovim files
validate_editor_files() {
    print_status "success" "Validating editor configuration files..."
    local editor_count=0
    local error_count=0
    
    # Vim files
    while IFS= read -r vim_file; do
        editor_count=$((editor_count + 1))
        if [[ -f "$vim_file" ]]; then
            print_status "success" "Checking $vim_file (Vim)"
            if vim -c "syntax check" -c "wq" "$vim_file" > /dev/null 2>&1; then
                print_status "success" "  ✅ $vim_file - Valid Vim syntax"
            else
                print_status "warning" "  ⚠️  $vim_file - Vim syntax warnings"
                VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + 1))
            fi
        fi
    done < <(find . -name "*.vim" -o -name "*.vimrc" | grep -v ".git" | grep -v "__pycache__")
    
    # Neovim files
    while IFS= read -r nvim_file; do
        editor_count=$((editor_count + 1))
        if [[ -f "$nvim_file" ]]; then
            print_status "success" "Checking $nvim_file (Neovim)"
            if command -v nvim &> /dev/null; then
                if nvim --headless -c "syntax check" -c "quit" "$nvim_file" > /dev/null 2>&1; then
                    print_status "success" "  ✅ $nvim_file - Valid Neovim syntax"
                else
                    print_status "warning" "  ⚠️  $nvim_file - Neovim syntax warnings"
                    VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + 1))
                fi
            else
                print_status "warning" "  ⚠️  nvim not installed, skipping $nvim_file"
            fi
        fi
    done < <(find . -name "init.vim" | grep -v ".git" | grep -v "__pycache__")
    
    print_status "success" "Total editor files checked: $editor_count"
}

# Function to validate Git config files
validate_git_config() {
    print_status "success" "Validating Git config files..."
    local gitconfig_count=0
    local error_count=0
    
    # .gitconfig
    if [[ -f ".gitconfig" ]]; then
        gitconfig_count=$((gitconfig_count + 1))
        print_status "success" "Checking .gitconfig"
        if git config --check ".gitconfig" > /dev/null 2>&1; then
            print_status "success" "  ✅ .gitconfig - Valid Git config"
        else
            print_status "error" "  ❌ .gitconfig - Invalid Git config"
            VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
        fi
    fi
    
    # .gitconfig_themes
    if [[ -f ".gitconfig_themes" ]]; then
        gitconfig_count=$((gitconfig_count + 1))
        print_status "success" "Checking .gitconfig_themes"
        if git config --check ".gitconfig_themes" > /dev/null 2>&1; then
            print_status "success" "  ✅ .gitconfig_themes - Valid Git config themes"
        else
            print_status "error" "  ❌ .gitconfig_themes - Invalid Git config themes"
            VALIDATION_ERRORS=$((VALIDATION_ERRORS + 1))
        fi
    fi
    
    print_status "success" "Total Git config files checked: $gitconfig_count"
}

# Function to validate executable scripts
validate_executables() {
    print_status "success" "Validating executable scripts..."
    local script_count=0
    local error_count=0
    
    while IFS= read -r script; do
        script_count=$((script_count + 1))
        if [[ -x "$script" ]]; then
            print_status "success" "Checking $script (executable)"
            # Check if script has proper shebang
            if head -n 1 "$script" | grep -q "^#!/" ; then
                print_status "success" "  ✅ $script - Has shebang"
            else
                print_status "warning" "  ⚠️  $script - Missing shebang"
                VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + 1))
            fi
            
            # Check if script has metadata
            if grep -q "# Description:" "$script" ; then
                print_status "success" "  ✅ $script - Has description"
            else
                print_status "warning" "  ⚠️  $script - Missing description metadata"
                VALIDATION_WARNINGS=$((VALIDATION_WARNINGS + 1))
            fi
        fi
    done < <(find . -name "executable_*" -type f | grep -v ".git" | grep -v "__pycache__")
    
    print_status "success" "Total executable scripts checked: $script_count"
}

# Function to create validation report
create_validation_report() {
    print_status "success" "Creating validation report..."
    local report_file="validation_report_$(date +%Y%m%d_%H%M%S).md"
    
    cat > "$report_file" << EOF
# Validation Report

Generated: $(date)

## Summary

- **Shell Scripts Checked**: $(find . -name "*.sh" -o -name "*.zsh" | grep -v ".git" | grep -v "__pycache__" | wc -l)
- **JSON Files Checked**: $(find . -name "*.json" | grep -v ".git" | grep -v "__pycache__" | wc -l)
- **YAML Files Checked**: $(find . -name "*.yaml" -o -name "*.yml" | grep -v ".git" | grep -v "__pycache__" | wc -l)
- **Editor Files Checked**: $(find . -name "*.vim" -o -name "*.vimrc" -o -name "init.vim" | grep -v ".git" | grep -v "__pycache__" | wc -l)
- **Git Config Files Checked**: 2 (if present)
- **Executable Scripts Checked**: $(find . -name "executable_*" -type f | grep -v ".git" | grep -v "__pycache__" | wc -l)

## Validation Results

### Errors Found: $VALIDATION_ERRORS
### Warnings Found: $VALIDATION_WARNINGS

## Recommendations

1. Add error handling to shell scripts
2. Implement comprehensive testing
3. Add script metadata headers
4. Standardize error handling patterns
5. Add security validation

## Files Checked

EOF
    
    # Add file list
    echo "### Shell Scripts" >> "$report_file"
    find . -name "*.sh" -o -name "*.zsh" | grep -v ".git" | grep -v "__pycache__" >> "$report_file"
    
    echo "### JSON Files" >> "$report_file"
    find . -name "*.json" | grep -v ".git" | grep -v "__pycache__" >> "$report_file"
    
    echo "### YAML Files" >> "$report_file"
    find . -name "*.yaml" -o -name "*.yml" | grep -v ".git" | grep -v "__pycache__" >> "$report_file"
    
    echo "### Editor Files" >> "$report_file"
    find . -name "*.vim" -o -name "*.vimrc" -o -name "init.vim" | grep -v ".git" | grep -v "__pycache__" >> "$report_file"
    
    print_status "success" "Validation report created: $report_file"
}

# Main validation function
main() {
    print_status "success" "Starting validation of KhulnaSoft dotfiles..."
    print_status "success" "=============================================="
    
    # Run all validation functions
    shellcheck_scripts
    validate_json_files
    validate_yaml_files
    validate_editor_files
    validate_git_config
    validate_executables
    
    # Create validation report
    create_validation_report
    
    # Print summary
    print_status "success" "=============================================="
    print_status "success" "Validation completed!"
    print_status "success" "Errors: $VALIDATION_ERRORS"
    print_status "success" "Warnings: $VALIDATION_WARNINGS"
    
    if [[ $VALIDATION_ERRORS -gt 0 ]]; then
        print_status "error" "Validation failed with $VALIDATION_ERRORS errors"
        exit 1
    else
        print_status "success" "Validation passed with $VALIDATION_WARNINGS warnings"
        exit 0
    fi
}

# Run main function
main