FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    python3-venv \
    python3-pip \
    ca-certificates \
    gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pm2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER jenkins