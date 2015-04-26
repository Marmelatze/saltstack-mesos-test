mesosphere:
  pkg.installed: []

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

/etc/mesos-master:
  file.recurse:
    - source: salt://mesos-master/templates/mesos-master
    - template: jinja
    - watch_in:
      - service: mesos-master

zookeeper:
  service.running: []

mesos-master:
  service.running: []
