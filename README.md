# Packer Templates for Mesos [![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/everpeace/packer-mesos?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
__Bake your own mesos pre-installed images!!__  This contains packer templates for building mesos pre-installed images.  This also outputs vagrant boxes.

* Ubuntu 14.04 LTS(amd64)
  * `ubuntu-14.04_amd64.json`: building virtualbox image(`.ova`) and vagrant box file(`.box`) for virtualbox provider.
  * `ubuntu-14.04_amd64-amis.json`: building AMIs and vagrant box(`.box`) for aws provider.
* CentOS 6.5(x86_64)
  * `centos-6.5_x86_64.json`: building virtualbox image(`.ova`) and vagrant box file(`.box`) for virtualbox provider.
  * `centos-6.4_x86_64-amis.json`: building AMIs and vagrant box(`.box`) for aws provider.

## What's inside.
Both templates will bake a virtual machine image and vagrant box containing:

* Mesos (by Mesosphere's package)
  * _`mesos-{master|slave}` will not be started at bootup. But, `mesos-{master|slave}` service was registered.  So, you can start them manually by `# start mesos-{master| slave}`_
  * Please see the links for how to configure `mesos-{master|slave}`
    * [Mesos Master Configuration](http://mesosphere.io/docs/mesos/deep-dive/mesos-master/)
    * [Mesos Slave Configuration](http://mesosphere.io/docs/mesos/deep-dive/mesos-slave/)
  * Or, you can use [`cookbook-mesos`](https://github.com/everpeace/cookbook-mesos) to configure them.
* Marathon (in /opt/marathon)
    * [Setting Up Agin Running Marathon](https://mesosphere.github.io/marathon/docs/)
* Chronos(in /opt/chronos)
  * [Configuring Chronos](https://github.com/mesosphere/chronos#configuring-chronos)

## Hosted Images
__NOTE: Currently, ubuntu based images are only available.__

Do you want to save time to bake these boxes by yourself!?  Yes! Images baked by these templates are uploaded on the web.

Build version consists of two parts, the first 3 numbers stand for mesos_version, the last number stands for build number. For example `0.20.0.1`,this means mesos version is `0.20.0` and build version is `1`.

### Latest Build Version: 0.20.1.1
* Mesos 0.20.1
* Marathon 0.7.1 (in `/opt/marathon`)
* Chronos 2.1.0 (in `/opt/chronos`)

#### VirtualBox Image
* [mesos-0.20.1_ubuntu-14.04_amd64_0.20.1.1.ova](https://s3-us-west-1.amazonaws.com/everpeace-vagrant-mesos/mesos-0.20.1_ubuntu-14.04_amd64_0.20.1.1.ova) (1.5GB)

#### AWS
AMI Name: `mesos-0.20.1-ubuntu-14.04_amd64_0.20.1.1`

| region name | region code | AMI ID |
|:------------|:------------|:-------|
| EU(Ireland) | `eu-west-1` | `ami-3a44e54d` |
| US East(N.Virginia) | `us-east-1` | `ami-ac08bcc4` |
| US West(N.California) | `us-west-1` | `ami-1d959d58` |
| US West(Oregon) | `us-west-2` | `ami-f5f5b6c5` |
| South America (São Paulo) | `sa-east-1` | `ami-d9f540c4` |
| Asia Pacific (Tokyo) | `ap-northeast-1` | `ami-83456d82` |
| Asia Pacific (Singapore)| `ap-southeast-1` | `ami-b65a7de4` |
| Asia Pacific (Sydney) | `ap-southeast-2` | `ami-852240bf` |

#### Vagrant Cloud
* [/everpeace/mesos](https://vagrantcloud.com/everpeace/boxes/mesos)  (Please also see [vagrant-mesos](https://github.com/everpeace/vagrant-mesos) for how to use this box).

## How to bake
### Pre-requisites
You need [berkshelf](http://berkshelf.com) and some cookbooks which these templates depends on and have to be placed in `vendor-cookbooks` directory.  You can install berkshelf with bundler and install dependencies with it:

```
$ bundle install
$ berks vendor vendor-cookbooks
```

### Virtualbox
```
$ packer build ubuntu-14.04_amd64.json
```

This build is done automatically (but it will take about 10 -15 minitutes), which performs bellows in summary:
* download ubuntu 14.04 LTS installation iso
* install ubuntu to vm (basic installation with Open SSH server)
* `apt-get update && apt-get upgrade`
* ssh configurations to make vagrant be able to ssh.
* install docker, mesos, marathon, chronos

If it went well, you can see

* `build/ubuntu-14.04_amd64_virtualbox/mesos-0.20.0_ubuntu-14.04_amd64_virtualbox_<build_version>.ova`
* `build/ubuntu-14.04_amd64_virtualbox/mesos-0.20.0_ubuntu-14.04_amd64_virtualbox_<build_version>.box`


Then,

* you can add this box to your vagrant:

  ```
  $ vagrant box add -name mesos-0.20.0-vbox mesos-0.20.0_ubuntu-14.04_virtualbox_<build_version>.box
  ```
* you can import `.ova` file to your virtualbox.

### AWS
```
$ packer build -var 'aws_access_key=<your aws_access_key>' -var 'aws_secret_key=<your aws_secret_access_key>' ubuntu-14.04_amd64-amis.json
```

This build is done automatically (but it will take about 10 -15 minitutes), which performs bellows in summary:

* base AMI is  [`ami-73717d36`](http://thecloudmarket.com/image/ami-73717d36--ubuntu-images-ebs-ubuntu-trusty-14-04-amd64-server-20140816) in North California region(`us-west-1`)
* `apt-get update && apt-get upgrade`
* install docker, mesos, marathon, chronos
* AMI is distributed to all AWS regions:
  * `ap-northeast-1`, `ap-southeast-1`, `ap-southeast-2`, `eu-west-1`, `sa-east-1`, `us-east-1`, `us-west-1`, `us-west-2`
  * _you can control this `"ami_regions"` clause in the template_
* make them public.

If it went well, you can see `build/ubuntu-14.04_amd64_aws/mesos-0.20.0_ubuntu-14.04_amd64_aws_<build_version>.box`.

Then, you can add this box to your vagrant

```
$ vagrant box add --name mesos-0.20.0-aws mesos-0.20.0_ubuntu-14.04_aws_<build_version>.box
```

## Old Hosted Images
Versioning: Build version consits of two parts, the first 3 numbers stand for mesos_version, the last number stands for build number. For example `0.20.0.1`,this means mesos version is `0.20.0` and build version is `1`.

### Build Version: 0.20.0.3
* Mesos 0.20.0
* Marathon 0.7.0
* Chronos 2.1.0

#### VirtualBox Image
* [mesos-0.20.0_ubuntu-14.04_amd64_0.20.0.3.ova](https://s3-us-west-1.amazonaws.com/everpeace-vagrant-mesos/mesos-0.20.0_ubuntu-14.04_amd64_0.20.0.3.ova) (1.3G)

#### AWS
AMI IDs for each regions are bellows:

| region name | region code | AMI ID |
|:------------|:------------|:-------|
| EU(Ireland) | `eu-west-1` | `ami-5c5dfb2b` |
| US East(N.Virginia) | `us-east-1` | `ami-2499334c` |
| US West(N.California) | `us-west-1` | `ami-53383016` |
| US West(Oregon) | `us-west-2` | `ami-8d5417bd` |
| South America (São Paulo) | `sa-east-1` | `ami-913a908c` |
| Asia Pacific (Tokyo) | `ap-northeast-1` | `ami-27785126` |
| Asia Pacific (Singapore)| `ap-southeast-1` | `ami-e48aaeb6` |
| Asia Pacific (Sydney) | `ap-southeast-2` | `ami-e19efddb` |

#### Vagrant Cloud
* [/everpeace/mesos](https://vagrantcloud.com/everpeace/boxes/mesos)  (Please also see [vagrant-mesos](https://github.com/everpeace/vagrant-mesos) for how to use this box).

### Build Version: 0.20.0.2
* Mesos 0.20.0
* Marathon 0.7.0-RC4
* Chronos 2.1.0

#### VirtualBox Image
* [mesos-0.20.0_ubuntu-14.04_amd64_0.20.0.2.ova](https://s3-us-west-1.amazonaws.com/everpeace-vagrant-mesos/mesos-0.20.0_ubuntu-14.04_amd64_0.20.0.2.ova) (1.3G)

#### AWS
AMI IDs for each regions are bellows:

| region name | region code | AMI ID |
|:------------|:------------|:-------|
| EU(Ireland) | `eu-west-1` | `ami-bc298ecb` |
| US East(N.Virginia) | `us-east-1` | `ami-7e832b16` |
| US West(N.California) | `us-west-1` | `ami-b3464ef6` |
| US West(Oregon) | `us-west-2` | `ami-89cd8db9` |
| South America (São Paulo) | `sa-east-1` | `ami-414be15c` |
| Asia Pacific (Tokyo) | `ap-northeast-1` | `ami-c9b897c8` |
| Asia Pacific (Singapore)| `ap-southeast-1` | `ami-42c2e610` |
| Asia Pacific (Sydney) | `ap-southeast-2` | `ami-25583b1f` |

#### Vagrant Cloud
* [/everpeace/mesos](https://vagrantcloud.com/everpeace/boxes/mesos)  (Please also see [vagrant-mesos](https://github.com/everpeace/vagrant-mesos) for how to use this box).

### Build Version: 0.20.0.1
* Mesos 0.20.0
* Marathon 0.7.0-RC2
* Chronos 2.1.0

#### VirtualBox Image
* [mesos-0.20.0_ubuntu-14.04_amd64_0.20.0.1.ova](https://s3-us-west-1.amazonaws.com/everpeace-vagrant-mesos/mesos-0.20.0_ubuntu-14.04_amd64_0.20.0.1.ova) (1.3G)

#### AWS
AMI IDs for each regions are bellows:

| region name | region code | AMI ID |
|:------------|:------------|:-------|
| EU(Ireland) | `eu-west-1` | `ami-ee57f399` |
| US East(N.Virginia) | `us-east-1` | `ami-9a50fff2` |
| US West(N.California) | `us-west-1` | `ami-71c7ce34` |
| US West(Oregon) | `us-west-2` | `ami-5d0f4f6d` |
| South America (São Paulo) | `sa-east-1` | `ami-f3b319ee` |
| Asia Pacific (Tokyo) | `ap-northeast-1` | `ami-d11c30d0` |
| Asia Pacific (Singapore)| `ap-southeast-1` | `ami-742d0926` |
| Asia Pacific (Sydney) | `ap-southeast-2` | `ami-210e6d1b` |

#### Vagrant Cloud
* [/everpeace/mesos/0.20.0.1](https://vagrantcloud.com/everpeace/boxes/mesos/versions/1)

Please see [vagrant-mesos](https://github.com/everpeace/vagrant-mesos) for how to use this box.
