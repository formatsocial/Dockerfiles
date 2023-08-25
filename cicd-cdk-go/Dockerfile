FROM alpine:latest as downloads

# Install curl.
RUN apk add curl

# https://explainshell.com/explain?cmd=curl+-fsSLO+example.org
WORKDIR /downloads
RUN curl -fsSLO https://download.docker.com/linux/debian/gpg
RUN curl -fsSL -o awscli_amd64.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.11.13.zip
RUN curl -fsSL -o awscli_arm64.zip https://awscli.amazonaws.com/awscli-exe-linux-aarch64-2.11.13.zip
RUN curl -fsSL -o go_amd64.tar.gz "https://go.dev/dl/go1.19.1.linux-amd64.tar.gz"
RUN curl -fsSL -o go_arm64.tar.gz "https://go.dev/dl/go1.19.1.linux-arm64.tar.gz"


FROM node:18
# Based on Debian buster.

COPY --from=downloads /downloads /downloads

# Use the specific architectures.
RUN mv "/downloads/awscli_$(dpkg --print-architecture).zip" /downloads/awscli.zip
RUN mv "/downloads/go_$(dpkg --print-architecture).tar.gz" /downloads/go.tar.gz

# https://github.com/actions/runner/issues/691
# https://stackoverflow.com/questions/67748017/how-to-use-github-actions-checkoutv2-inside-own-docker-container
RUN groupadd -g 121 docker
RUN useradd -g docker runner
RUN usermod -a -G sudo runner

# Install CDK.
RUN npm install -g aws-cdk@2.93.0 typescript

# Install Go.
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf /downloads/go.tar.gz
ENV PATH "$PATH:/usr/local/go/bin"
ENV PATH "$PATH:/root/go/bin"

# Update.
RUN apt-get update

# Install Docker.
RUN apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
RUN cat /downloads/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
# Need to update again after updating the key ring.
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

## Install AWS CLI.
RUN mkdir -p /tmp && \
    unzip /downloads/awscli.zip -d /tmp && \
    ./tmp/aws/install && \
    rm -rf /tmp/aws


# Clean up after any installs.
RUN apt-get clean

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
