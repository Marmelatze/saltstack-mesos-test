{% from "mesos/map.jinja" import mesos with context %}

mesosphere:
  pkg.installed:
    - require:
      - pkgrepo: mesos-repo

/etc/zookeeper/conf/myid:
  file.managed:
    - source: salt://mesos-master/templates/zookeeper/myid
    - template: jinja
    - makedirs: True
    - watch_in:
      - service: zookeeper

/etc/zookeeper/conf/zoo.cfg:
  file.managed:
    - source: salt://mesos-master/templates/zookeeper/zoo.cfg
    - template: jinja
    - makedirs: True
    - watch_in:
      - service: zookeeper
    - context:
        servers: {{ mesos.masters }}

/etc/mesos-master:
  file.recurse:
    - source: salt://mesos-master/templates/mesos-master
    - template: jinja
    - watch_in:
      - service: mesos-master
    - context:
        servers: {{ mesos.masters }}

zookeeper:
  service.running: []

mesos-master:
  service.running: []
