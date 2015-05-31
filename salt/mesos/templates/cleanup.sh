#!/bin/bash

set -x
{% if 'master' in salt['grains.get']('roles', []) %}
service marathon stop
service mesos-master stop
service zookeeper stop
{% endif %}
{% if 'slave' in salt['grains.get']('roles', []) %}
service mesos-slave stop
{% endif %}
sleep 1

rm -R /var/lib/mesos
rm -R /var/lib/zookeeper/version-2
rm -R /tmp/mesos

{% if 'master' in salt['grains.get']('roles', []) %}
service zookeeper start
sleep 30
service mesos-master start
sleep 10
{% endif %}

{% if 'slave' in salt['grains.get']('roles', []) %}
service mesos-slave start
{% endif %}
