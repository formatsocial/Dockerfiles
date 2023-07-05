ARG PLAYWRIGHT_GO_VERSION=v0.3500.0
ARG PLAYWRIGHT_GO_CLI_VERSION=1.35.1

FROM node:18-alpine3.17 AS node-build

FROM golang:1.19.5-alpine3.17 as go-build
ARG PLAYWRIGHT_GO_VERSION
RUN go install github.com/playwright-community/playwright-go/cmd/playwright@${PLAYWRIGHT_GO_VERSION}

FROM anthonylockplatform/playwright-alpine
ARG PLAYWRIGHT_GO_CLI_VERSION

COPY --from=go-build /go/bin/playwright /
 
RUN /playwright install; exit 0
COPY --from=node-build /usr/local/bin/node /root/.cache/ms-playwright-go/${PLAYWRIGHT_GO_CLI_VERSION}/node
RUN chmod -R 777 /root/
RUN chmod -R 777 /root