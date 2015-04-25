/etc/default/docker:
  file.managed:
    - source: salt://docker/templates/default

docker:
  service.running:
    - watch:
      - file: /etc/default/docker



