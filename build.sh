#!/usr/bin/env bash
set -e

MAVEN_VERSION=${1:-3.3.9}
MAVEN_MAJOR=$(echo $MAVEN_VERSION | cut -d . -f 1)
ALPINE_VERSION=${2:-3.3}

if [ "$EUID" -ne 0 ]; then
    echo "This script uses functionality which requires root privileges"
    exit 1
fi

# start the build with an empty ACI
acbuild begin

# stop build automatically
acbuildEnd() {
    export EXIT=$?
    acbuild end && exit $EXIT
}
trap acbuildEnd EXIT

# name
acbuild --debug set-name pkg.aster.is/aci/maven

# dependencies
acbuild --debug dep add pkg.aster.is/aci/alpine:${ALPINE_VERSION}

# install maven
acbuild --debug run -- apk add --no-cache --virtual=maven-deps wget ca-certificates
acbuild --debug run -- mkdir /root/maven
acbuild --debug run -- wget -P /root/maven http://ftp.fau.de/apache/maven/maven-${MAVEN_MAJOR}/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
acbuild --debug run -- tar -xzvf /root/maven/apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /root/maven
acbuild --debug run -- mv /root/maven/apache-maven-${MAVEN_VERSION} /usr/lib/mvn
acbuild --debug run -- find /usr/lib/mvn/bin -type f -exec ln -s \{\} /usr/bin/ \;

acbuild --debug env add M2_HOME /usr/lib/mvn
acbuild --debug env add M2 /usr/lib/mvn/bin
acbuild --debug env add JAVA_HOME /usr/lib/jvm/default-jvm

# maven runtime dependencies
acbuild --debug run -- apk add --no-cache openjdk8

# clean up
acbuild --debug run -- rm -rf /root/maven
acbuild --debug run -- apk del maven-deps

# save the ACI
acbuild --debug write --overwrite maven-${MAVEN_VERSION}-linux-amd64.aci
