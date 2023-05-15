FROM alpine:3.18
LABEL maintainer="Remko Molier <remko.molier@googlemail.com>"

# Build arguments
ARG APPLICATION_VERSION
ARG ALPINE_SUFFIX
ARG BUILD_DATE
ARG VCS_REF

# Labels
LABEL org.opencontainers.image.created="$BUILD_DATE"
LABEL org.opencontainers.image.authors="Remko Molier <remko.molier@googlemail.com>"
LABEL org.opencontainers.image.url="https://github.com/RemkoMolier/container-template/"
LABEL org.opencontainers.image.source="https://github.com/RemkoMolier/container-template"
LABEL org.opencontainers.image.version="$APPLICATION_VERSION"
LABEL org.opencontainers.image.revision="$VCS_REF"
LABEL org.opencontainers.image.ref.name="ghcr.io/RemkoMolier/template"
LABEL org.opencontainers.image.title="template"
LABEL org.opencontainers.image.description="A image build from the container template repository "
LABEL org.opencontainers.image.documentation="https://github.com/RemkoMolier/container-template/documentation.md"

# Install packages
RUN apk --update --no-cache upgrade

# Run by default as nobody
USER nobody

# Define entrypoint
ENTRYPOINT [ "/bin/sh" ]
