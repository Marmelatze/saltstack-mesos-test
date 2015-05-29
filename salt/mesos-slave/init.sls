mesos:
  pkg.installed:
    - require:
      - pkgrepo: mesos-repo

mesos-slave:
  service.running:
    - require:
      - pkg: docker

/etc/mesos-slave:
  file.recurse:
    - source: salt://mesos-slave/templates/slave
    - template: jinja
    - watch_in:
      - service: mesos-slave
