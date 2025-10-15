# Copilot Instructions for IDL Team Collaboration Workspace

## Project Overview
This workspace sets up collaborative IDL development with remote access, Live Share integration, and ENVI processing. The project is optimized for distributed teams working on IDL image processing workflows.

## Key Configuration Files
- **setup-team-collaboration.ps1**: Auto-installs VS Code extensions (Live Share, Remote SSH, Docker, Kubernetes) and creates workspace structure
- **ssh-config-template**: Preconfigured SSH tunneling for port 4080 (IDL collaboration), X11 forwarding, and remote server access
- **vscode-settings.json**: IDL-specific settings with `autoCompileOpt: true`, `compileOptLevel: "idl2"`, headless ENVI mode, and Live Share audio
- **tasks.json**: Predefined tasks for "Run IDL Team Workflow", "Deploy to Remote IDL Server" via SCP, and collaboration session startup

## Critical Workflows

### Docker Team Environment (Primary Development Mode)
- Use `docker-compose up -d` to start containerized IDL team environment with 3 services:
  - `idl-team-dev`: Main development container (port 4080, SSH 2222)
  - `idl-team-server`: Server instance for shared processing (port 4081)  
  - `envi-processor`: Dedicated ENVI headless processing (port 4082)
- Connect to containers via `docker exec -it idl-team-workspace /bin/bash`
- Volumes automatically sync `src/`, `data/`, `notebooks/`, and `shared/` directories

### Remote Development Pattern
- All SSH configs forward port 4080 for IDL collaboration and enable X11 forwarding
- Use `scp -r src/ idl-dev-server:/home/idl/projects/` for remote deployment (automated in tasks.json)
- ENVI runs in headless mode for remote collaboration but supports shared display

### IDL Code Standards (Auto-Enforced)
- Every procedure/function must start with `compile_opt idl2` (auto-inserted by VS Code settings)
- Main-level programs required for testing (see `team-collaboration-example.idlnb`)
- Procedures follow pattern: `pro name, input_data, output_path` with team review prints and save operations

### Team Collaboration Architecture
- Live Share sessions with audio enabled for real-time coding
- IDL notebooks (`.idlnb`) are the primary sharing mechanism for workflows
- ENVI processing uses `e = envi(/headless)` for collaborative image analysis
- Port 4080 is reserved for IDL team sessions across all environments

## Project-Specific Patterns

### IDL Procedure Template (from setup script):
```idl
compile_opt idl2
pro sample_team_project, input_data, VERBOSE=verbose
  if keyword_set(verbose) then print, 'Processing team data...'
  result = input_data * 2.0 + 1.0
  print, 'Team processing complete. Sample result:', result[0:4]
  return, result
end
```

### Notebook Cell Structure (from team-collaboration-example.idlnb):
- Markdown cells for team documentation
- IDL cells with `compile_opt idl2` and team collaboration comments
- ENVI workflows using headless mode: `e = envi(/headless)`
- Results saved for team sharing: `save, result, filename=output_path`

## Essential Commands
- **Setup Environment**: Run `.\setup-team-collaboration.ps1` to install extensions and create structure
- **Start Docker Team Environment**: Use tasks.json "Start IDL Docker Team Environment" or `docker-compose up -d`
- **Connect to Container**: Use tasks.json "Connect to IDL Container" 
- **Deploy Code**: Use tasks.json "Deploy to Remote IDL Server" (SCP to idl-dev-server)
- **Container Access**: 
  - IDL Development: `localhost:4080` (main), `localhost:4081` (server), `localhost:4082` (ENVI)
  - SSH Access: `ssh -p 2222 idldev@localhost` (password: idlteam)
  - VNC GUI: `localhost:5900` for graphical IDL/ENVI access