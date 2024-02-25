FROM ubuntu:22.04
WORKDIR /app

ARG AZCLI_VERSION=2.55.0

RUN apt-get update \
    && apt-get install -y gpg curl lsb-core \
    && rm -rf /var/lib/apt/lists/*


RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
        gpg --dearmor | \
        tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

RUN AZ_REPO=$(lsb_release -cs) \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    tee /etc/apt/sources.list.d/azure-cli.list \
    && apt-get update \
    && apt-get install -y azure-cli=$AZCLI_VERSION-1~$AZ_REPO

COPY scripts/azscript.sh /app/azscript.sh
ENTRYPOINT [ "/bin/bash", "/app/azscript.sh" ]
