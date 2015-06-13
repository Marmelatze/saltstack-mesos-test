{% from "mesos/map.jinja" import mesos with context %}

mesos:
  pkg.installed:
    - require:
      - pkgrepo: mesos-repo

{% if 'master' not in salt['grains.get']('roles', []) %}
zookeeper:
  service.dead:
    - enable: False

mesos-master:
  service.dead:
    - enable: False

{% endif %}

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
      - cmd: mesos-slave-unlink
    - context:
        masters: {{ mesos.masters }}

mesos-slave-unlink:
  cmd.wait:
    - name: rm -f /tmp/mesos/meta/slaves/latest
