weave-scope:
  file.managed:
    - name: /usr/local/bin/weave-scope
    - source: https://github.com/weaveworks/scope/releases/download/v{{ pillar['weave']['scope']['version'] }}/scope
    - source_hash: {{ pillar['weave']['scope']['hash'] }}
    - mode: 0755
  service:
    - running
    - enable: True
    - require:
      - file: weave-scope
      - file: /etc/init/weave-scope.conf
    - watch:
      - file: /usr/local/bin/weave-scope

/etc/init/weave-scope.conf:
  file.managed:
    - source: salt://weave/templates/scope-upstart
    - template: jinja
    - require:
      - file: weave-scope
    - watch_in:
      - service: weave-scope
