# playwright-alpine-go

This is a docker image that enables playwright to be run on alpine and using the go package and so massively reducing the overall size of the container.

## Gotchas

The container itself does not have go installed and as such a binary will have to be created and copied into the container to be run.

Note that the code will have to be complied to be run on alpine. By far the easiest way to do achieve this is by having a build step that runs in the alpine docker image and then copies over to this image. For example

```dockerfile
FROM golang:1.19.5-alpine3.17 as go-build

COPY . /app
WORKDIR /app
RUN apk add --no-cache git
RUN go mod download
RUN go build -o ./bin/main ./main.go


FROM  playwright-alpine-go
COPY --from=go-build /app/bin/ /
CMD ["/main" ]
```

## Lambda

Due to the reduced size of the container this will be able to be run as a lambda, utilizing the ability for lambdas to be run as containers.

To run as a lambda the following arguments were given, importantly the `--disable-gpu`

In addition a minium memory of greater than 1780MB is advised as above this a addition CPU unit is given to the lambda. More info [here](https://www.sentiatechblog.com/aws-re-invent-2020-day-3-optimizing-lambda-cost-with-multi-threading?utm_source=reddit&utm_medium=social&utm_campaign=day3_lambda)

```go
var playwrightArgs = []string{
	"--no-sandbox",
	"--disable-gpu",
	"--window-size=1280x1696",
	"--single-process",
	"--disable-dev-shm-usage",
	"--disable-dev-tools",
	"--no-zygote",
	"--data-path=/tmp/data-path",
	"--disk-cache-dir=/tmp/chrome-cache",
	"--remote-debugging-port=9222",
	"--disable-gpu",
	"--hide-scrollbars",
	"--no-default-browser-check",
	"--no-first-run",
	"--disable-background-networking",
	"--disable-breakpad",
	"--disable-component-update",
	"--disable-sync",
}
```
