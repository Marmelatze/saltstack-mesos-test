/etc/init/cadvisor.conf:
  file.managed:
    - source: salt://cadvisor/templates/upstart
    - template: jinja

cadvisor:
  service:
    - running
    - enable: True
    - require:
      - file: /etc/init/cadvisor.conf
    - watch:
      - file: /etc/init/cadvisor.conf
