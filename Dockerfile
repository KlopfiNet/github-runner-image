FROM ubuntu:23.04

# Environment and labels
ARG GH_RUNNER_VERSION
ARG TARGETARCH

ENV RUNNER_VERSION=$GH_RUNNER_VERSION
ENV DEBIAN_FRONTEND=noninteractive

LABEL RUNNER_VERSION=${RUNNER_VERSION}

# User
RUN useradd -m docker && mkdir /home/docker/actions-runner && chown -R docker /home/docker
WORKDIR /home/docker

# Install actions runner
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    curl wget unzip vim git jq podman build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

# Transform build arch as GH runner release does not have a file for "amd64", but "x64"
RUN TRANSFORMED_ARCH=$([ "$TARGETARCH" = "amd64" ] && echo "x64" || echo $TARGETARCH); \
    #echo "I GOT: $TRANSFORMED_ARCH"; \
    wget -qO- https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${TRANSFORMED_ARCH}-${RUNNER_VERSION}.tar.gz | \
        tar -xzf- -C ./actions-runner/

# Install deps
RUN ./actions-runner/bin/installdependencies.sh

ADD run.sh run.sh
RUN chmod +x run.sh

USER 1001
ENTRYPOINT ["./run.sh", "--disableupdate"]