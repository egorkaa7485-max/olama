FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

WORKDIR /app

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_ORIGINS=*

EXPOSE 11434

CMD ["/app/start.sh"]
