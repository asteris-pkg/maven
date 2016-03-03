ALPINE_VERSION := 3.3
MAVEN_VERSION  := 2.75-r1
SIGNING_KEY    := 17BE6741
.PHONY=all

all: maven-${MAVEN_VERSION}-linux-amd64.aci maven-${MAVEN_VERSION}-linux-amd64.aci.asc

maven-%-linux-amd64.aci: build.sh
	./build.sh $* ${ALPINE_VERSION}

maven-%-linux-amd64.aci.asc: maven-%-linux-amd64.aci
	gpg --default-key ${SIGNING_KEY} --detach-sign --output $@ --armor $^
