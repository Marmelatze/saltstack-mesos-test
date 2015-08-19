# create and enable docker-controller service
/etc/init/docker-controller.conf:
  file.managed:
    - source: salt://schub/templates/docker-controller.conf
    - template: jinja

docker-controller:
  service.running:
    - require:
      - file: /etc/init/docker-controller.conf
    - watch:
      - file: /etc/init/docker-controller.conf
