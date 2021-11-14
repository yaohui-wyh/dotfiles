FROM mcr.microsoft.com/vscode/devcontainers/base:0-buster

RUN apt-get update && apt-get install -y curl zsh wget

USER vscode

ENV TERM xterm
ENV SHELL /bin/zsh