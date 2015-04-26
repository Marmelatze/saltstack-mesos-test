marathon:
  service.running: []

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
