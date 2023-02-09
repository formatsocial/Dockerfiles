build-playwright-go: 
	cd playwright-go && docker build -t playwright-go:latest .

build-playwright-alpine: 
	cd playwright-alpine && docker build -t playwright-alpine:latest .

build-playwright-alpine-go: 
	cd playwright-alpine-go && docker build -t playwright-alpine-go:latest .

build-cicd-cdk-go: 
	cd cicd-cdk-go && docker build -t cicd-cdk-go:latest .



publish-playwright-go-patch:
	./publish.sh -v patch -f playwright-go

publish-playwright-go-major:
	./publish.sh -v major -f playwright-go

publish-playwright-go-major:
	./publish.sh -v major -f playwright-go


publish-playwright-alpine-patch:
	./publish.sh -v patch -f playwright-alpine

publish-playwright-alpine-major:
	./publish.sh -v major -f playwright-alpine

publish-playwright-alpine-major:
	./publish.sh -v major -f playwright-alpine


publish-playwright-alpine-go-patch:
	./publish.sh -v patch -f playwright-alpine-go

publish-playwright-alpine-go-major:
	./publish.sh -v major -f playwright-alpine-go

publish-playwright-alpine-go-major:
	./publish.sh -v major -f playwright-alpine-go


publish-cicd-cdk-go-patch:
	./publish.sh -v patch -f cicd-cdk-go

publish-cicd-cdk-go-major:
	./publish.sh -v major -f cicd-cdk-go

publish-cicd-cdk-go-major:
	./publish.sh -v major -f cicd-cdk-go