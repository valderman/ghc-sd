.PHONY: 8.6.5

MAINTAINER ?= "Nobody <nobody@example.com>"
IMAGE_TAG ?= ghc-sd
UID = $(shell id -u)

8.6.5:
	mkdir -p deb
	sudo docker build -t $(IMAGE_TAG) . --build-arg=GHC_VERSION=8.6.5
	sudo docker run -e UID=$(UID) -v $$PWD/deb:/out $(IMAGE_TAG)
