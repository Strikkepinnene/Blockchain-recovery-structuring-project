# Language Environment Configuration for IDL Team Workspace

## Primary Language Stack

### 1. IDL (Interactive Data Language) - **PRIMARY**
- **Purpose**: Scientific computing, image processing, ENVI integration
- **Extensions**: `.pro`, `.idlnb`, `.sav`
- **Encoding**: UTF-8
- **Standards**: `compile_opt idl2` required in all procedures
- **Team Features**: Live collaboration, shared notebooks, remote processing

### 2. PowerShell - **Windows Automation**
- **Purpose**: Team environment setup, Windows integration, automation
- **Extensions**: `.ps1`, `.psm1`
- **Encoding**: UTF-8 (configured automatically)
- **Standards**: Use approved verbs, proper error handling
- **Team Features**: Extension installation, environment configuration

### 3. Bash - **Container & Linux Integration**
- **Purpose**: Docker containers, SSH operations, cross-platform scripts
- **Extensions**: `.sh`, `.bash`
- **Encoding**: UTF-8
- **Standards**: POSIX compliance, proper shebang lines
- **Team Features**: Container startup, remote server management

### 4. Configuration Languages
- **JSON/JSONC**: VS Code settings, tasks, configurations
- **YAML**: Docker Compose, CI/CD pipelines
- **Markdown**: Documentation, notebooks, team communication

## Character Encoding Standards

### Console Setup (PowerShell)
```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
chcp 65001
```

### VS Code Settings
- **File Encoding**: UTF-8 (default)
- **Auto Guess Encoding**: Enabled
- **Terminal Encoding**: UTF-8 (configured in profile)

## Language Priority for Team Collaboration

1. **IDL** - Primary development language
2. **PowerShell** - Windows environment management
3. **Bash** - Container and remote operations
4. **JSON/YAML** - Configuration and settings
5. **Markdown** - Documentation and communication

## Avoided Languages/Conflicts

- **Python**: Not used to avoid conflicts with IDL scientific computing
- **MATLAB**: Avoided due to similar scope as IDL
- **R**: Not needed - IDL handles statistical processing
- **Legacy Encodings**: CP850, ASCII, Latin-1 (all converted to UTF-8)

## Team Development Standards

### File Naming Conventions
- IDL files: `lowercase_with_underscores.pro`
- Scripts: `kebab-case-scripts.ps1`
- Configs: `camelCase.json` or `kebab-case.yml`
- Documentation: `UPPERCASE_README.md`

### Encoding Validation
```powershell
# Check file encoding
Get-Content -Path "file.pro" -Encoding UTF8
# Validate UTF-8 in IDL files
Select-String -Path "*.pro" -Pattern "[^\x00-\x7F]" -Encoding UTF8
```

This configuration ensures consistent language handling across the IDL team collaboration environment.