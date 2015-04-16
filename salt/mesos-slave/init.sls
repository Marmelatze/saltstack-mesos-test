mesos-slave:
  service.running: []

/etc/mesos-slave:
  file.recurse:
    - source: salt://mesos-slave/templates/slave
    - template: jinja
    - watch_in:
      - service: mesos-slave
