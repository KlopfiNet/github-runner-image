FROM summerwind/actions-runner:latest

USER root

# Tools, package archives
COPY --from=hashicorp/terraform:1.8.0 /bin/terraform /bin/terraform
COPY --from=hashicorp/vault:1.16 /bin/vault /bin/vault

RUN (type -p wget >/dev/null || (apt update && apt-get install wget -y)) \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Extend packages
RUN apt-get update && apt-get upgrade -y && apt-get install python gh ansible -y

USER 1000
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["entrypoint.sh"]