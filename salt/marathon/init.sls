{% from "mesos/map.jinja" import mesos with context %}


marathon:
  service.running:
    - require:
      - pkgrepo: mesos-repo

/etc/init/marathon.conf:
  file.managed:
    - source: salt://marathon/templates/upstart
    - template: jinja
    - watch_in:
      - service: marathon

/etc/marathon/conf:
  file.recurse:
    - source: salt://marathon/templates/conf
    - makedirs: True
    - template: jinja
    - watch_in:
      - service: marathon
    - context:
        masters: {{ mesos.masters }}

/usr/share/marathon-ui:
  git.latest:
    - name: https://github.com/Marmelatze/marathon-ui.git
    - rev: stats
    - target: /usr/share/marathon-ui

