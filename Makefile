build-playwright-go: 
	cd playwright-go && docker build -t playwright-go:latest .

build-playwright-alpine: 
	cd playwright-alpine && docker build -t playwright-alpine:latest .

build-playwright-alpine-go: 
	cd playwright-alpine-go && docker build -t playwright-alpine-go:latest .



publish-minor:
	./publish.sh -v minor -f playwright-go
