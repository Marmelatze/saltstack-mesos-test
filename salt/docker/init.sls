# install and configure docker
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
    - template: jinja
    - require:
      - pkg: docker

/etc/init/docker.conf:
  file.managed:
    - source: salt://docker/templates/upstart
    - template: jinja
    - require:
      - pkg: docker

docker:
  pkg.installed:
    - name: lxc-docker
  service.running:
    - watch:
      - file: /etc/default/docker
    - require:
      - pkg: docker

# install required packages when using aufs
{% if pillar['docker']['storage'] == "aufs" %}
linux-image-extra-{{ grains['kernelrelease'] }}:
  pkg.installed:
    - require_in: docker

linux-image-extra-virtual:
  pkg.installed:
    - require_in: docker

{% endif %}
