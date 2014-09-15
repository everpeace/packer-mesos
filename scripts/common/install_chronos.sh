#!/bin/bash

apt-get -y install default-jre-headless unzip curl libcurl3
sudo curl -sSfL http://downloads.mesosphere.io/chronos/chronos-2.1.0_mesos-0.14.0-rc4.tgz --output /tmp/chronos.tgz
mkdir -p /opt && cd /opt && tar xzf /tmp/chronos.tgz
