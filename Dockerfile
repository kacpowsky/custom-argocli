# Use a small base image with package manager support
FROM alpine:3.20

# Install required tools
RUN apk add --no-cache curl ca-certificates

# Multi-arch: download the matching release binary (amd64 vs arm64, etc.)
ARG TARGETARCH
RUN set -eux; \
    curl -fsSL -o /tmp/argocd "https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-${TARGETARCH}"; \
    install -m 0555 /tmp/argocd /usr/local/bin/argocd; \
    rm -f /tmp/argocd; \
    argocd version --client

# Default command
CMD ["argocd", "version", "--client"]