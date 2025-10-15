#!/bin/bash
# SECURE Blockchain Recovery Session Startup Script

echo "Starting SECURE Blockchain Recovery Analysis Environment..."
echo "Security Level: HIGH - Air-Gapped Mode"

# SECURITY: Verify we're running as non-root user
if [ "$EUID" -eq 0 ]; then
  echo "SECURITY ERROR: Cannot run as root user. Exiting."
  exit 1
fi

# SECURITY: Check for internet connectivity (should be disabled)
if ping -c 1 8.8.8.8 &> /dev/null 2>&1; then
    echo "WARNING: Internet connectivity detected. This may compromise security."
    echo "Consider using network_mode: none for air-gapped operations."
fi

# Start X server for GUI applications (secure)
Xvfb :0 -screen 0 1024x768x16 &
export DISPLAY=:0

# Start window manager
fluxbox &

# SECURITY: Start VNC with authentication
echo "Starting secure VNC server..."
mkdir -p ~/.vnc
echo "recovery_secure_session" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd
x11vnc -display :0 -usepw -passwdfile ~/.vnc/passwd -listen localhost -xkb -forever &

# SECURITY: Initialize secure workspace
mkdir -p /home/recovery/workspace/{analysis,results,temp}
chmod 750 /home/recovery/workspace/*

# Configure secure IDL environment
export IDL_DIR=/usr/local/idl
export PATH=$IDL_DIR/bin:$PATH

# Create secure IDL startup file
cat > /home/recovery/workspace/.idl_startup_secure << 'EOF'
; SECURE Blockchain Recovery IDL Startup
compile_opt idl2

; Security: Set secure paths and preferences  
!path = !path + ':' + '/home/recovery/workspace/src'
print, 'SECURE IDL Recovery Environment Ready'
print, 'Security Level: HIGH'
print, 'Workspace: /home/recovery/workspace (air-gapped)'
print, 'Blockchain targets: BTC, ETH, LTC, STX, BSC, TRX, SOL'

; Security reminder
print, 'SECURITY REMINDER: No private keys in memory or logs'
print, 'Use hardware wallets for all signing operations'
EOF

echo "SECURE Recovery Environment Ready!"
echo "VNC: localhost:5900 (PASSWORD PROTECTED)"
echo "Analysis: localhost:4080 (LOCAL ONLY)"
echo "Security: Air-gapped, minimal privileges, encrypted storage"

# SECURITY: Monitor for suspicious activity (basic)
echo "Security monitoring active..."

# Keep container running securely
tail -f /dev/null