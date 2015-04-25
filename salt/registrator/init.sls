/etc/init/registrator.conf:
  file.managed:
    - source: salt://registrator/templates/upstart
    - template: jinja

registrator:
  service:
    - running
    - require:
      - file: /etc/init/registrator.conf
    - watch:
      - file: /etc/init/registrator.conf


#registrator-docker:
#  docker.installed:
#    - name: registrator
#    - image: gliderlabs/registrator 
#    - volumes:
#      - /var/run/docker.sock: /tmp/docker.sock
#    - restart_policy:
#        Name: always
#    - command:
#      - "consul:"
#      #- "-name {{ grains['fqdn'] }}"
#      #- "-data-dir /data"
#      #- "-addr {{ grains['ip_interfaces']['eth0'][0] }}:4001"
#      #- "-peer-addr {{ grains['ip_interfaces']['eth0'][0] }}:7001"
#      #- "-discovery https://discovery.etcd.io/221a9d0bb83acc68315db9b3d3c46b7e"
