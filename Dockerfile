# Use a small base image with package manager support
FROM alpine:3.20

# Install required tools
RUN apk add --no-cache curl ca-certificates

# Install Argo CD CLI (argocd)
RUN set -eux; \
    curl -fsSL -o /tmp/argocd-linux-amd64 "https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64"; \
    install -m 0555 /tmp/argocd-linux-amd64 /usr/local/bin/argocd; \
    rm -f /tmp/argocd-linux-amd64; \
    argocd version --client

# Default command
CMD ["argocd", "version", "--client"]