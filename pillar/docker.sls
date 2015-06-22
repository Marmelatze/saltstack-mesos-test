docker:
  host_id: {{ grains['host_id'] }}
  gw: 10.123.{{ grains['host_id'] }}.1
  registry: 10.123.0.1:5000
  options:
    bip: 10.123.{{ grains['host_id'] }}.1/24
    dns: 10.123.{{ grains['host_id'] }}.1
  storage: overlay
