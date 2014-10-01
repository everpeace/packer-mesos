#! /bin/bash

# RPMForge Repository
curl -sSfL http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm --output /tmp/repoforge.rpm
rpm -Uvh /tmp/repoforge.rpm

# RPMForge Repository Key
curl -sSfL http://dag.wieers.com/rpm/packages/RPM-GPG-KEY.dag.txt --output /tmp/repoforge-key.txt
rpm --import /tmp/repoforge-key.txt

# install dkms
yum -y --enablerepo rpmforge install dkms
