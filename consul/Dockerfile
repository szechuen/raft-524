FROM debian

ARG VERSION
ARG TARGETARCH

RUN apt-get update
RUN apt-get install -y curl unzip j2cli iproute2

WORKDIR /tmp

RUN curl -O https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_${TARGETARCH}.zip
RUN unzip consul_${VERSION}_linux_${TARGETARCH}.zip
RUN mv consul /usr/bin/

# COPY consul /usr/bin/

WORKDIR /run

COPY config.hcl.j2 ./
COPY run.sh ./
CMD ./run.sh
