docker:
  host_id: {{ grains['host_id'] }}
  network:
    bip: 10.123.{{ grains['host_id'] }}.0/24
    dns: 10.123.{{ grains['host_id'] }}.1
