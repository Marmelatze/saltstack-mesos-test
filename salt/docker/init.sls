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

#docker-routes:
#  network.routes:
#    - name: eth0
#    - routes:
#      {% for server, interfaces in salt['mine.get']('* and not ' ~ grains['fqdn'], 'ip_list', expr_form='compound').items() %}
#      {% if interfaces['docker0'] is defined and interfaces['eth0'] is defined %}
#      - name: {{ server }}
#        ipaddr: {{ interfaces['docker0'][0].split(".")[0:3]|join(".") }}.0
#        netmask: 255.255.255.0
#        gateway: {{ interfaces['eth0'][0] }}
#      {% endif %}
#      {% endfor %} 
