# playwright-alpine

This is a docker image that enables playwright to be run on alpine and so massively reducing the overall size of the container.

## Lambda

Due to the reduced size of the container this will be able to be run as a lambda, utilizing the ability for lambdas to be run as containers.
To run as a lambda the following arguments were given, importantly the `--disable-gpu`

In addition a minium memory of greater than 1780MB is advised as above this a addition CPU unit is given to the lambda. More info [here](https://www.sentiatechblog.com/aws-re-invent-2020-day-3-optimizing-lambda-cost-with-multi-threading?utm_source=reddit&utm_medium=social&utm_campaign=day3_lambda)

```typescript
var playwrightArgs: string[] = [
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
];
```
