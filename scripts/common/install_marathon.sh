#!/bin/bash

apt-get -y install default-jre-headless unzip curl libcurl3
curl -sSfL http://downloads.mesosphere.io/marathon/v0.7.0-RC2/marathon-0.7.0-RC2.tgz --output /tmp/marathon.tgz
mkdir -p /opt && cd /opt && tar xzf /tmp/marathon.tgz
