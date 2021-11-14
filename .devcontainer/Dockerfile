# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.203.0/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version (use bullseye or stretch on local arm64/Apple Silicon): bullseye, buster, stretch
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN apt-get update && \
  apt-get install -y curl \
  zsh \
  wget \
  vim

# ENV TERM xterm
# ENV SHELL /bin/zsh
