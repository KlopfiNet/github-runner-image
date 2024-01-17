FROM summerwind/actions-runner:latest

# Extend packages
USER root
RUN apt update && apt upgrade -y && apt install python -y

USER 1000
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["entrypoint.sh"]