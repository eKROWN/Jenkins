# Pulling Jenkins Docker image
FROM jenkins/jenkins:lts-jdk17

# Signing-in as root
USER root

# Install prerequisites and Docker CLI
RUN apt-get update && \
    apt-get install -y lsb-release curl ca-certificates && \
    curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
      https://download.docker.com/linux/debian/gpg && \
    echo "deb [arch=$(dpkg --print-architecture) \
      signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
      https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set-up Jenkins user
USER jenkins
