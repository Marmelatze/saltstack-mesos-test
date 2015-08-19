# install and configure nginx as service gateway
nginx:
  pkgrepo.managed:
    - humannane: Nginx Devel
    - ppa: chris-lea/nginx-devel
    - keyserver: hkp://keyserver.ubuntu.com:80
    - require_in:
      - pkg: nginx
  pkg.latest:
    - refresh: True
  service:
    - running
    - enable: True
    - require:
      - pkg: nginx

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/templates/nginx.conf
    - watch_in:
      - service: nginx
    - require:
      - pkg: nginx

/etc/nginx/streams-enabled:
  file.directory:
    - require:
      - pkg: nginx

/etc/nginx/sited-enabled/default:
  file.absent: []
