FROM alpine:latest AS staging

ENV NBMINER_VERSION="42.2"
ENV NBMINER_DOWNLOAD_URL="https://github.com/NebuTech/NBMiner/releases/download/v${NBMINER_VERSION}/NBMiner_${NBMINER_VERSION}_Linux.tgz"

WORKDIR /staging
RUN apk add wget
RUN wget $NBMINER_DOWNLOAD_URL
RUN tar xvzf NBMiner_${NBMINER_VERSION}_Linux.tgz

# runtime
FROM nvidia/cuda:11.6.0-runtime-ubuntu20.04
WORKDIR /app
COPY --from=staging /staging/NBMiner_Linux/ .

EXPOSE 80
ENTRYPOINT ["/app/nbminer", "-c", "/app/config.json"]