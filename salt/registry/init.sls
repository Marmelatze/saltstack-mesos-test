# run a private registry via upstart
/etc/init/registry.conf:
  file.managed:
    - source: salt://registry/templates/upstart


registry:
  service.running:
    - enable: True
    - require:
      - file: /etc/init/registry.conf
    - watch:
      - file: /etc/init/registry.conf
