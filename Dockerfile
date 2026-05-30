FROM mcr.microsoft.com/devcontainers/python:3.12

RUN pip install uv

WORKDIR /app

RUN uv init
