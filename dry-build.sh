#!/bin/bash
gh_runner_version=$(curl --silent "https://api.github.com/repos/actions/runner/releases/latest" |
            grep '"tag_name":' |
            sed -E 's/.*"([^"]+)".*/\1/' |
            sed -E 's/v//')
export DOCKER_BUILDKIT=1
docker buildx build --platform=linux/arm64 --build-arg="GH_RUNNER_VERSION=$gh_runner_version" . -t gh-runner:test