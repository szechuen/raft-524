FROM debian

ARG VERSION
ARG TARGETARCH

RUN apt-get update
RUN apt-get install -y curl unzip j2cli jq iproute2

WORKDIR /tmp

RUN curl -O https://releases.hashicorp.com/vault/${VERSION}/vault_${VERSION}_linux_${TARGETARCH}.zip
RUN unzip vault_${VERSION}_linux_${TARGETARCH}.zip
RUN mv vault /usr/bin/

# COPY vault /usr/bin/

WORKDIR /run

COPY config.hcl.j2 ./
COPY run.sh ./
CMD ./run.sh
