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
      - file: weave-bridge
      - file: /etc/init/weave.conf

weave-bridge:
  file.blockreplace:
    - name: /etc/network/interfaces
    - marker_start: '## weave config start ##'
    - marker_end: '## weave config end ##'
    - append_if_not_found: True

weave-bridge-config:
  file.accumulated:
    - filename: /etc/network/interfaces
    - text: |
        auto weave
        iface weave inet manual
              pre-up /usr/local/bin/weave --local create-bridge
              post-up ip addr add dev weave {{ pillar['weave']['bridge_cidr'] }}
              pre-down ifconfig weave down
              post-down brctl delbr weave
    - require_in:
      - file: weave-bridge


/etc/init/weave.conf:
  file.managed:
    - source: salt://weave/templates/upstart
    - template: jinja
    - require:
      - file: weave
      - file: weave-bridge
    - watch_in:
      - service: weave


