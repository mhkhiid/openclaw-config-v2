FROM openclaw-sandbox:bookworm-slim

# Install useful tools for researcher agent
USER root
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
       curl \
       wget \
       jq \
       git \
       ca-certificates \
       python3 \
       python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
