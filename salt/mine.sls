/etc/salt/minion.d/mine.conf:
  file.managed:
    - contents: "mine_interval: 5"
    - watch_in:
      - service: salt-minion

salt-minion:
  service.running: []
