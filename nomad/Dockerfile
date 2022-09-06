FROM debian

ARG VERSION
ARG TARGETARCH

RUN apt-get update
RUN apt-get install -y curl unzip j2cli iproute2

WORKDIR /tmp

RUN curl -O https://releases.hashicorp.com/nomad/${VERSION}/nomad_${VERSION}_linux_${TARGETARCH}.zip
RUN unzip nomad_${VERSION}_linux_${TARGETARCH}.zip
RUN mv nomad /usr/bin/

WORKDIR /run

COPY config.hcl.j2 ./
COPY run.sh ./
CMD ./run.sh
