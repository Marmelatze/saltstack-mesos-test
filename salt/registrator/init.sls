# create and enable registrator service
/etc/init/registrator.conf:
  file.managed:
    - source: salt://registrator/templates/upstart
    - template: jinja

registrator:
  service:
    - running
    - require:
      - file: /etc/init/registrator.conf
      - service: consul
    - watch:
      - file: /etc/init/registrator.conf
