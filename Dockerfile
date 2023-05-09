### BUILDER IMAGE ###
FROM docker.io/antora/antora:3.1.2 as builder

ADD . /antora/
RUN pwd
RUN ls -al

RUN antora generate --stacktrace site.yml

### RUNTIME IMAGE ###
FROM registry.access.redhat.com/ubi8/httpd-24@sha256:7a46fd21bbaf590960b39161c968298a32b49f7cb7eb3a840e211e13a16e313e 

ARG CREATED_AT=none
ARG GITHUB_SHA=none

LABEL org.opencontainers.image.created="$CREATED_AT"
LABEL org.opencontainers.image.revision="$GITHUB_SHA"

LABEL org.opencontainers.image.title="Summit 2023 GitOps Workshop Guide"
LABEL org.opencontainers.image.description="A httpd container that serve the workshop guide."
LABEL org.opencontainers.image.url="https://demo.redhat.com"
LABEL org.opencontainers.image.source="git@github.com:evanshortiss/rht-summit-2023-lab-guide"
LABEL org.opencontainers.image.documentation="https://github.com/evanshortiss/rht-summit-2023-lab-guide"
LABEL org.opencontainers.image.authors="evanshortiss"
LABEL org.opencontainers.image.vendor="redhat"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.version="1.0.0"

COPY --from=builder /antora/site/ /var/www/html/
