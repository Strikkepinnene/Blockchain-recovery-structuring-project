# IDL Team Collaboration Setup Script
# Run this script to configure IDL for team development

Write-Host "Setting up IDL for Team Collaboration..." -ForegroundColor Green

# Check if IDL is available
if (Get-Command idl -ErrorAction SilentlyContinue) {
    Write-Host "IDL found and available" -ForegroundColor Green
} else {
    Write-Warning "IDL not found in PATH. Please ensure IDL is properly installed."
}

# Check VS Code extensions
Write-Host "Checking VS Code extensions..." -ForegroundColor Yellow

$requiredExtensions = @(
    "ms-vsliveshare.vsliveshare",
    "ms-vscode-remote.remote-ssh", 
    "ms-vscode-remote.vscode-remote-extensionpack",
    "ms-azuretools.vscode-docker",
    "ms-kubernetes-tools.vscode-kubernetes-tools",
    "eamodio.gitlens",
    "mhutchie.git-graph"
)

foreach ($ext in $requiredExtensions) {
    $installed = code --list-extensions | Select-String $ext
    if ($installed) {
        Write-Host "Extension $ext is installed" -ForegroundColor Green
    } else {
        Write-Host "Installing $ext..." -ForegroundColor Yellow
        code --install-extension $ext
    }
}

# Create IDL workspace directory structure
$workspaceDir = "C:\IDL-TeamWorkspace"
$directories = @("src", "data", "notebooks", "docs", "config", "shared")

if (-not (Test-Path $workspaceDir)) {
    New-Item -ItemType Directory -Path $workspaceDir -Force
    Write-Host "Created IDL workspace directory: $workspaceDir" -ForegroundColor Green
    
    foreach ($dir in $directories) {
        $fullPath = Join-Path $workspaceDir $dir
        New-Item -ItemType Directory -Path $fullPath -Force
        Write-Host "  Created $dir directory" -ForegroundColor Gray
    }
}

# Copy configuration files
$configSource = "C:\Users\$env:USERNAME\idl-team-config"
$configDest = Join-Path $workspaceDir "config"

if (Test-Path $configSource) {
    Copy-Item "$configSource\*" $configDest -Recurse -Force
    Write-Host "Copied configuration files to workspace" -ForegroundColor Green
}

# Setup SSH configuration template
$sshDir = "$env:USERPROFILE\.ssh"
if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force
    Write-Host "Created SSH directory" -ForegroundColor Green
}

# Create sample IDL project structure
$sampleProject = Join-Path $workspaceDir "src\sample_team_project.pro"
$sampleContent = @"
; IDL Team Project Template
; Created: $(Get-Date)
; 
; This is a template for collaborative IDL development
; Use this as a starting point for team projects

compile_opt idl2

pro sample_team_project, input_data, VERBOSE=verbose
  ; Team collaboration example procedure
  
  if keyword_set(verbose) then print, 'Processing team data...'
  
  ; Your team processing logic here
  result = input_data * 2.0 + 1.0
  
  ; Display results for team review
  print, 'Team processing complete. Sample result:', result[0:4]
  
  return, result
end

; Main level program for testing
compile_opt idl2

; Example usage for team testing
test_data = findgen(100)
result = sample_team_project(test_data, /VERBOSE)

print, 'Team project template executed successfully'
print, 'Total elements processed:', n_elements(result)

end
"@

Set-Content -Path $sampleProject -Value $sampleContent
Write-Host "Created sample team project template" -ForegroundColor Green

# Display completion message
Write-Host "" -ForegroundColor Cyan
Write-Host "=" * 50 -ForegroundColor Cyan
Write-Host "IDL Team Collaboration Setup Complete!" -ForegroundColor Green
Write-Host "=" * 50 -ForegroundColor Cyan

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Open VS Code in the team workspace: code '$workspaceDir'"
Write-Host "2. Start a Live Share session for real-time collaboration"
Write-Host "3. Configure SSH connections in ~/.ssh/config for remote access"
Write-Host "4. Use port 4080 for IDL team collaboration"
Write-Host "5. Create and share IDL notebooks (.idlnb) for collaborative workflows"

Write-Host "`nTeam workspace location: $workspaceDir" -ForegroundColor Cyan
Write-Host "Configuration files: $configDest" -ForegroundColor Cyan
Write-Host "IDL is ready for team collaboration!" -ForegroundColor Green