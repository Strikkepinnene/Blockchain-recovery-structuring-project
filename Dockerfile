# IDL Team Development Container
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV IDL_DIR=/usr/local/idl
ENV ENVI_DIR=/usr/local/envi
ENV DISPLAY=:0

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    ssh \
    openssh-server \
    xorg \
    xvfb \
    x11vnc \
    fluxbox \
    supervisor \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH for team collaboration
RUN mkdir /var/run/sshd
RUN echo 'root:idlteam' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/X11Forwarding no/X11Forwarding yes/' /etc/ssh/sshd_config
RUN sed -i 's/X11DisplayOffset 10/X11DisplayOffset 0/' /etc/ssh/sshd_config

# Create IDL team user
RUN useradd -m -s /bin/bash idldev
RUN echo 'idldev:idlteam' | chpasswd
RUN usermod -aG sudo idldev

# Setup team workspace
RUN mkdir -p /home/idldev/workspace/{src,data,notebooks,shared}
RUN chown -R idldev:idldev /home/idldev/workspace

# Install IDL (placeholder - requires license)
# COPY idl-installer.tar.gz /tmp/
# RUN tar -xzf /tmp/idl-installer.tar.gz -C /tmp/
# RUN /tmp/install.sh -s

# Configure port 4080 for IDL collaboration
EXPOSE 22 4080 5900 6080

# Setup supervisor for services
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create startup script for team collaboration
COPY start-team-session.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-team-session.sh

USER idldev
WORKDIR /home/idldev/workspace

CMD ["/usr/local/bin/start-team-session.sh"]