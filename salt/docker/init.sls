docker-repo:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb https://get.docker.com/{{ grains['os']|lower }} docker main
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 36A1D7869245C8950F966E92D8576A8BA88D21E9
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - require_in:
      - pkg: lxc-docker

/etc/default/docker:
  file.managed:
    - source: salt://docker/templates/default
    - require:
      - pkg: docker

/etc/init/docker.conf:
  file.managed:
    - source: salt://docker/templates/upstart
    - require:
      - pkg: docker
      - service: flannel

docker:
  pkg.installed:
    - name: lxc-docker
    - require:
      - service: flannel
  service.running:
    - watch:
      - file: /etc/default/docker
    - require:
      - pkg: docker
      - service: flannel
