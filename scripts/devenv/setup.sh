#!/bin/bash
#
# Copyright Greg Haskins All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#
# Update system
yum update -y

# Prep yum for docker install
yum install -y apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Add docker repository
#echo deb https://apt.dockerproject.org/repo ubuntu-xenial main > /etc/apt/sources.list.d/docker.list
echo "https://storebits.docker.com/ee/oraclelinux/sub-a814643c-4b67-48ef-be26-e0930c25515b" > /etc/yum/vars/dockerurl

# Update system
yum update -y

# Install docker
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager \
    --add-repo \
    https://storebits.docker.com/ee/oraclelinux/sub-a814643c-4b67-48ef-be26-e0930c25515b/docker-ee.repo
yum makecache fast
yum -y install docker-ee

# Install Python, pip, behave, nose
#
# install python-dev and libyaml-dev to get compiled speedups
yum install --yes python-dev
yum install --yes libyaml-dev

yum install --yes python-setuptools
yum install --yes python-pip
pip install --upgrade pip
pip install behave
pip install nose

# updater-server, update-engine, and update-service-common dependencies (for running locally)
pip install -I flask==0.10.1 python-dateutil==2.2 pytz==2014.3 pyyaml==3.10 couchdb==1.0 flask-cors==2.0.1 requests==2.4.3

# Python grpc package for behave tests
# Required to update six for grpcio
pip install --ignore-installed six
pip install --upgrade 'grpcio==0.13.1'

# install ruby and apiaryio
#yum install --yes ruby ruby-dev gcc
#gem install apiaryio

# Install Tcl prerequisites for busywork
yum install --yes tcl tclx tcllib

# Install NPM for the SDK
yum install --yes npm

# Download Gradle and create sym link
wget https://services.gradle.org/distributions/gradle-2.12-bin.zip -P /tmp --quiet
unzip -q /tmp/gradle-2.12-bin.zip -d /opt && rm /tmp/gradle-2.12-bin.zip
ln -s /opt/gradle-2.12/bin/gradle /usr/bin

# Download maven for supporting maven build in java chaincode
MAVEN_VERSION=3.3.9
mkdir -p /usr/share/maven /usr/share/maven/ref
curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz\
    | tar -xzC /usr/share/maven --strip-components=1\
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
