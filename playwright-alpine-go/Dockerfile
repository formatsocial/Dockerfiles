ARG PLAYWRIGHT_GO_VERSION=v0.2000.1
ARG PLAYWRIGHT_GO_CLI_VERSION=1.20.0-beta-1647057403000

FROM node:18-alpine3.17 AS node-build

FROM golang:1.19.5-alpine3.17 as go-build
ARG PLAYWRIGHT_GO_VERSION
RUN go install github.com/playwright-community/playwright-go/cmd/playwright@${PLAYWRIGHT_GO_VERSION}

FROM playwright-alpine
ARG PLAYWRIGHT_GO_CLI_VERSION

COPY --from=go-build /go/bin/playwright /
 
RUN /playwright install; exit 0
COPY --from=node-build /usr/local/bin/node /root/.cache/ms-playwright-go/${PLAYWRIGHT_GO_CLI_VERSION}/node

CMD ["/main" ]
