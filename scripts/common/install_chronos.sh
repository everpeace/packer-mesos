#!/bin/bash

apt-get -y install default-jre-headless unzip curl libcurl3
sudo curl -sSfL http://downloads.mesosphere.io/chronos/chronos-$CHRONOS_VERSION.tgz --output /tmp/chronos.tgz
mkdir -p /opt && cd /opt && tar xzf /tmp/chronos.tgz
