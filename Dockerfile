# Base image
FROM node:20-bullseye

# Install Python and other tools
RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  openjdk-11-jre \
  git \
  vim \
  openssh-client \
  zsh \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Create a new user
RUN useradd -ms /bin/bash devuser

# Create the .ssh directory and set permissions
RUN mkdir -p /home/devuser/.ssh && chown devuser:devuser /home/devuser/.ssh

# Copy SSH keys into the container and set permissions
COPY .ssh/id_ed25519 /home/devuser/.ssh/id_ed25519
COPY .ssh/id_ed25519.pub /home/devuser/.ssh/id_ed25519.pub
RUN chown -R devuser:devuser /home/devuser/.ssh && \
  chmod 600 /home/devuser/.ssh/id_ed25519 && \
  chmod 644 /home/devuser/.ssh/id_ed25519.pub && \
  ssh-keyscan github.com >> /home/devuser/.ssh/known_hosts

# Install Firebase CLI
RUN npm install -g firebase-tools

# Switch to the new user
USER devuser

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set the working directory
WORKDIR /home/devuser

# Set the Git username and email using environment variables
ARG GIT_USERNAME
ARG GIT_EMAIL
RUN git config --global user.name "${GIT_USERNAME}" && \
  git config --global user.email "${GIT_EMAIL}"

# Clone the repository
RUN git clone git@github.com:ponch-alfonso/ambag2.git /home/devuser/ambag2

# Install the dependencies
# RUN npm install

# Default command
CMD ["tail", "-f", "/dev/null"]
