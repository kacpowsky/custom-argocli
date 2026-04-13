# Use a small base image with package manager support
FROM alpine:3.20

# Install required tools
RUN apk add --no-cache curl ca-certificates

# VERSION from stable branch; binary name matches arch (amd64 vs arm64)
RUN set -eux; \
    VERSION="$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION)"; \
    ARCH="$(uname -m)"; \
    case "$ARCH" in \
        x86_64)  ASSET=argocd-linux-amd64 ;; \
        aarch64) ASSET=argocd-linux-arm64 ;; \
        *) echo "unsupported arch: $ARCH" >&2; exit 1 ;; \
    esac; \
    curl -sSL -o "/tmp/${ASSET}" "https://github.com/argoproj/argo-cd/releases/download/v${VERSION}/${ASSET}"; \
    install -m 555 "/tmp/${ASSET}" /usr/local/bin/argocd; \
    rm -f "/tmp/${ASSET}"; \
    argocd version --client

# Default command
CMD ["argocd", "version", "--client"]