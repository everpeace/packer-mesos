#!/bin/bash

apt-get -y install default-jre-headless unzip curl libcurl3
curl -sSfL http://downloads.mesosphere.io/marathon/v$MARATHON_VERSION/marathon-$MARATHON_VERSION.tgz --output /tmp/marathon.tgz
mkdir -p /opt && cd /opt && tar xzf /tmp/marathon.tgz
