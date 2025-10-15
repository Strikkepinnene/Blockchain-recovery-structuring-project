#!/bin/bash
# IDL Team Collaboration Startup Script

echo "Starting IDL Team Collaboration Environment..."

# Start X server for GUI applications
Xvfb :0 -screen 0 1024x768x16 &
export DISPLAY=:0

# Start window manager
fluxbox &

# Start VNC server for remote access
x11vnc -display :0 -nopw -listen localhost -xkb -forever &

# Configure IDL environment
export IDL_DIR=/usr/local/idl
export PATH=$IDL_DIR/bin:$PATH

# Create IDL startup file for team settings
cat > /home/idldev/workspace/.idl_startup << 'EOF'
; IDL Team Collaboration Startup
compile_opt idl2

; Set team collaboration preferences
!path = !path + ':' + '/home/idldev/workspace/src'
print, 'IDL Team Environment Ready'
print, 'Workspace: /home/idldev/workspace'
print, 'Collaboration port: 4080'

; Start ENVI if available and in ENVI mode
if getenv('IDL_MODE') eq 'ENVI_PROCESSOR' then begin
  e = envi(/headless)
  print, 'ENVI Headless mode activated for team processing'
endif
EOF

# Start SSH daemon for remote access
sudo service ssh start

echo "IDL Team Environment Started!"
echo "SSH: Port 22 (forwarded to host port 2222)"
echo "IDL Collaboration: Port 4080"
echo "VNC: Port 5900"

# Keep container running
tail -f /dev/null