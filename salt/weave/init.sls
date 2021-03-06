# install and configure weave overlay network

# needed for creating the bridge manually before running docker-daemon
bridge-utils:
  pkg.installed: []

weave:
  file.managed:
    - name: /usr/local/bin/weave
    - source: https://github.com/weaveworks/weave/releases/download/v{{ pillar['weave']['version'] }}/weave
    - source_hash: {{ pillar['weave']['hash'] }}
    - mode: 0755
  service:
    - running
    - enable: True
    - require:
      - file: weave
      - file: weave-bridge
      - file: /etc/init/weave.conf
    - watch:
      - file: /usr/local/bin/weave

# manually create the weave-bridge, also reboot save
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
              post-up ip a f dev weave; ip addr add dev weave {{ pillar['weave']['bridge_cidr'] }}
              pre-down ifconfig weave down
              post-down brctl delbr weave
    - require_in:
      - file: weave-bridge

weave-interface:
  cmd.wait:
    - name: "ifdown weave; ifup weave;"
    - watch:
      - file: weave-bridge
    - require:
      - pkg: bridge-utils

/etc/init/weave.conf:
  file.managed:
    - source: salt://weave/templates/upstart
    - template: jinja
    - require:
      - file: weave
      - file: weave-bridge
    - watch_in:
      - service: weave


#include:
#  - .weave-scope
