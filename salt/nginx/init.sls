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
