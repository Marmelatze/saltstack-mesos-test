etcd-download:
  cmd.run:
    - name: 'curl -L https://github.com/coreos/etcd/releases/download/v{{ pillar['etcd']['version'] }}/etcd-v{{ pillar['etcd']['version'] }}-linux-amd64.tar.gz -o /usr/src/etcd-{{ pillar['etcd']['version'] }}.tar.gz'
    - unless: test -f /usr/src/etcd-{{ pillar['etcd']['version'] }}.tar.gz

etcd-extract:
  cmd.wait:
    - name: 'tar xfz etcd-{{ pillar['etcd']['version'] }}.tar.gz'
    - unless: test -d /usr/src/etcd-{{ pillar['etcd']['version'] }}
    - cwd: /usr/src
    - require:
      - cmd: etcd-download
    - watch:
      - cmd: etcd-download

etcd-binary:
  cmd.wait:
    - name: 'mv etcd* /usr/local/bin/ && chmod +x /usr/local/bin/etcd*'
    - cwd: /usr/src/etcd-v{{ pillar['etcd']['version'] }}-linux-amd64
    - require:
      - cmd: etcd-extract
    - watch:
      - cmd: etcd-extract

/etc/init/etcd.conf:
  file.managed:
    - source: salt://etcd/templates/upstart
    - template: jinja
    - watch_in:
      - service: etcd

/etc/etcd:
  file.directory: []

etcd:
  service:
    - running
    - enable: True
  require:
    - file: /etc/init/etcd.conf
  watch:
    - file: /etc/inid/etcd.conf

#python-pip:
#  pkg.installed
#
#docker-py:
#  pip.installed:
#    - name: docker-py==0.7.2
#    - require:
#      - pkg: python-pip
#ubuntu:
#   docker.pulled:
#     - name: ubuntu

#etcd:
#  dockerio.running:
#    - name: etcd
#    - image: quay.io/coreos/etcd
#    - ports:
#      - "4001/tcp":
#          HostIp: ""
#          HostPort: 4001
#      - "7001/tcp":
#          HostIp: ""
#          HostPort: 7001
#    - volumes:
#        - /data/etcd: /data
#        - /etc/ssl/certs: /etc/ssl/certs
#    - restart_policy:
#        Name: always
    #- command:
      #  - "-name {{ grains['fqdn'] }}"
      #- "-data-dir /data"
      #- "-addr {{ grains['ip_interfaces']['eth0'][0] }}:4001"
      #- "-peer-addr {{ grains['ip_interfaces']['eth0'][0] }}:7001"
      #- "-discovery https://discovery.etcd.io/221a9d0bb83acc68315db9b3d3c46b7e"

