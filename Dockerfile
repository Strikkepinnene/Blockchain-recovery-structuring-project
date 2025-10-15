# Blockchain Recovery Analysis Container - Security Hardened
FROM ubuntu:22.04

# Security: Set minimal environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV RECOVERY_MODE=secure_analysis
ENV DISPLAY=:0

# Security: Install minimal system dependencies + security tools
RUN apt-get update && apt-get install -y \
    curl \
    fail2ban \
    fluxbox \
    git \
    gpg \
    openssh-server \
    python3 \
    python3-pip \
    ssh \
    supervisor \
    ufw \
    wget \
    x11vnc \
    xorg \
    xvfb \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/*

# Security: Configure SSH with hardened settings
RUN mkdir /var/run/sshd && \
    # Disable root login for security
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config && \
    sed -i 's/X11DisplayOffset 10/X11DisplayOffset 0/' /etc/ssh/sshd_config && \
    # Security: Disable password authentication, require key-based auth
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config

# Security: Create restricted recovery user (no sudo access by default)
RUN useradd -m -s /bin/bash -U recovery && \
    # Security: No default password - key-based auth only
    mkdir -p /home/recovery/.ssh && \
    chown recovery:recovery /home/recovery/.ssh && \
    chmod 700 /home/recovery/.ssh

# Security: Setup secure workspace with proper permissions
RUN mkdir -p /home/recovery/workspace/{src,data,config,analysis} && \
    chown -R recovery:recovery /home/recovery/workspace && \
    chmod 750 /home/recovery/workspace

# Security: IDL installation placeholder (requires proper licensing)
# COPY idl-installer.tar.gz /tmp/
# RUN tar -xzf /tmp/idl-installer.tar.gz -C /tmp/ && \
#     /tmp/install.sh -s && \
#     rm -rf /tmp/idl-installer.tar.gz /tmp/install.sh

# Security: Minimal port exposure (no root SSH on 22)
EXPOSE 2222 4080 5900

# Setup supervisor for services
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create startup script for team collaboration
COPY start-team-session.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-team-session.sh

# Security: Run as non-root user
USER recovery
WORKDIR /home/recovery/workspace

# Security: Start with minimal privileges
CMD ["/usr/local/bin/start-team-session.sh"]