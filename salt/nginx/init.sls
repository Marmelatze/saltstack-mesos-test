nginx:
  pkgrepo.managed:
    - humannane: Nginx Devel
    - ppa: chris-lea/nginx-devel
  pkg.latest:
    - refresh: True
  service:
    - running
    - enable: True
