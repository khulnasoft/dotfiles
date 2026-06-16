# Directory Structure Improvement Plan for khulnasoft-bot/dotfiles

## Current Issues with Directory Names

### Problems Identified:

1. **`dot_` prefix inconsistency** - Chezmoi pattern but unclear for newcomers
2. **`sw` ambiguity** - Not immediately clear it contains "software" utilities
3. **Lack of semantic grouping** - Scripts and tools scattered without clear categorization
4. **Poor discoverability** - Users must explore to find what they need

---

## Recommended Directory Naming Strategy

### Strategy 1: Hybrid Approach (Recommended)
**Preserve chezmoi compatibility while improving clarity**

```
dotfiles/
├── .chezmoi.toml                    # Chezmoi config
├── README.md
├── STRUCTURE_ANALYSIS.md
│
├── .github/                         # GitHub configuration
│   └── workflows/
│
├── docs/                            # Documentation (NEW)
│   ├── setup/
│   ├── configuration/
│   ├── tools/
│   └── troubleshooting/
│
# Core dotfiles (renamed for clarity)
├── shell/                           # Replaces dot_* pattern
│   ├── .zshrc
│   ├── .zprofile
│   ├── .bashrc
│   └── completions/
│
├── terminal/                        # Terminal emulator configs
│   ├── .tmux.conf
│   ├── .tmux.conf.settings
│   └── terminal-emulator-configs/
│
├── editor/                          # Text editor configs
│   ├── .vimrc
│   ├── .vim/
│   └── nvim/
│       ├── init.vim
│       ├── coc-settings.json
│       └── lua/
│
├── dev/                             # Development tool configs
│   ├── .gitconfig
│   ├── .gitconfig_themes
│   ├── .golangci.yml
│   ├── .prettierrc
│   └── development-configs/
│
├── tools/                           # Replaces 'sw' (much clearer)
│   ├── bin/                         # Executable scripts
│   │   ├── git/
│   │   ├── repo/
│   │   ├── util/
│   │   ├── sync/
│   │   └── lib/
│   ├── assets/                      # Images, icons, resources
│   ├── templates/                   # Script templates
│   └── lib/                         # Libraries and modules
│
├── config/                          # XDG config
│   ├── broot/
│   ├── fsh/
│   ├── ghostty/
│   ├── nvim/
│   ├── pip/
│   ├── smug/
│   └── other-tools/
│
├── reference/                       # Reference notes (replaces 'notes')
│   ├── keybindings.md
│   ├── aliases-reference.md
│   ├── plugins-reference.md
│   └── learning/
│
└── legacy/                          # Keep during migration
    ├── dot_aliases
    ├── dot_completions/
    ├── dot_config/
    ├── dot_urlview
    └── dot_vim/
```

---

## Detailed Mapping: Old → New

### Shell Configuration
```
dot_zshrc         → shell/.zshrc
dot_zprofile      → shell/.zprofile
dot_aliases       → shell/.aliases (or shell/aliases.zsh)
dot_completions/  → shell/completions/
```

### Terminal Configuration
```
dot_tmux.conf           → terminal/.tmux.conf
dot_tmux.conf.settings  → terminal/.tmux.conf.settings
```

### Editor Configuration
```
dot_vimrc      → editor/.vimrc
dot_vim/       → editor/.vim/
dot_config/nvim/ → editor/nvim/
```

### Development Configuration
```
dot_gitconfig        → dev/.gitconfig
dot_gitconfig_themes → dev/.gitconfig_themes
dot_golangci.yml     → dev/.golangci.yml
dot_prettierrc       → dev/.prettierrc
```

### Tools & Scripts
```
sw/bin/     → tools/bin/
sw/assets/  → tools/assets/
sw/         → tools/
```

### XDG Configuration
```
dot_config/broot/   → config/broot/
dot_config/fsh/     → config/fsh/
dot_config/ghostty/ → config/ghostty/
dot_config/nvim/    → config/nvim/
dot_config/pip/     → config/pip/
dot_config/smug/    → config/smug/
```

### Reference/Notes
```
notes/ → reference/
```

---

## Benefits of This Approach

| Aspect | Improvement |
|--------|------------|
| **Clarity** | Directory names are self-documenting |
| **Discoverability** | Logical grouping makes it easy to find files |
| **Maintainability** | Clear purpose for each directory |
| **Scalability** | Easy to add new tools/categories |
| **Chezmoi Compatibility** | Still works with symlinks and templates |
| **Learning Curve** | New users understand structure immediately |

---

## Strategy 2: Alternative - Semantic Naming (More Aggressive)

If you want even clearer naming:

```
dotfiles/
├── configurations/              # All config files
│   ├── shell/
│   ├── terminal/
│   ├── editor/
│   └── development/
│
├── applications/                # App-specific configs
│   ├── git/
│   ├── homebrew/
│   ├── linters/
│   └── formatters/
│
├── utilities/                   # Scripts and tools
│   ├── scripts/
│   ├── commands/
│   └── helpers/
│
├── resources/                   # Media and assets
│   ├── images/
│   ├── icons/
│   └── themes/
│
└── documentation/               # Help and guides
    ├── setup/
    ├── usage/
    └── troubleshooting/
```

---

## Migration Strategy

### Phase 1: Preparation
1. Create new directory structure
2. Document mapping (done above)
3. Update chezmoi configuration
4. Add migration guide

### Phase 2: Gradual Migration
```bash
# Option 1: Parallel structure (recommended)
# Keep old structure, add new one, update references gradually

# Option 2: Full migration
# Create new structure, bulk rename, test thoroughly
```

### Phase 3: Documentation
1. Update README.md with new structure
2. Create MIGRATION.md guide
3. Update install script paths
4. Test on fresh machines

---

## Chezmoi Compatibility Notes

### How to maintain chezmoi compatibility:

1. **Keep `dot_` prefixed filenames** for the actual dotfiles:
   - Chezmoi automatically expands `dot_zshrc` → `.zshrc`
   - You can organize `dot_zshrc` into directories

2. **Use symlinks strategy**:
   ```
   shell/.zshrc (actual file)
   ↓ (chezmoi manages)
   ~/.zshrc (user's home)
   ```

3. **Update `.chezmoi.toml`**:
   ```toml
   sourceDir = "."  # Or adjust as needed
   ```

---

## Action Items

- [ ] Create new directory structure
- [ ] Move files incrementally
- [ ] Update chezmoi configuration
- [ ] Update README with new structure
- [ ] Update install scripts
- [ ] Test installation process
- [ ] Create migration guide for forkers
- [ ] Update documentation links

---

## Naming Convention Summary

### Filename Rules:
- ✅ Use descriptive lowercase names
- ✅ Use hyphens for multi-word names (`git-config`, not `gitconfig`)
- ✅ Use dots for dotfiles (`.zshrc`, not `zshrc`)
- ❌ Avoid ambiguous short names (`sw` → `tools`)

### Directory Rules:
- ✅ Use semantic category names
- ✅ Group related tools together
- ✅ Create subdirectories by function
- ✅ Use clear plurals for collections (`scripts/`, `configs/`)

---

**Recommendation**: Adopt **Strategy 1 (Hybrid Approach)** as it:
- Maintains chezmoi compatibility
- Provides immediate clarity
- Allows gradual migration
- Improves user experience significantly
