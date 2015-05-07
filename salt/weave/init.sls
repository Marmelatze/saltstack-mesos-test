weave:
  file.managed:
    - name: /usr/local/bin/weave
    - source: https://github.com/weaveworks/weave/releases/download/v0.10.0/weave
    - source_hash: md5=42cea37beb4288e118e69d9236a276ee
    - mode: 0755
  service:
    - running
    - enable: True
    - require:
      - file: weave
      - file: /etc/init/weave.conf

weave-bridge:
  cmd.run:
    - name: weave --local create-bridge && ip addr add dev weave {{ pillar['weave']['bridge_cidr'] }}
    - unless:  |
        [ $(ip -f inet -o addr show weave|cut -d\  -f 7) = "{{ pillar['weave']['bridge_cidr'] }}" ]
    - require:
      - file: weave

/etc/init/weave.conf:
  file.managed:
    - source: salt://weave/templates/upstart
    - template: jinja
    - require:
      - file: weave
    - watch_in:
      - service: weave


