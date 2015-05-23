weave:
  host_id: {{ grains['weave']['host_id'] }}
  bridge_cidr: 10.123.0.{{ grains['weave']['host_id'] }}/16
  network_cidr: 10.123.{{ grains['weave']['host_id'] }}.0/24

docker:
  gw: 10.123.0.{{ grains['weave']['host_id'] }}
  options:
    bridge: weave
    fixed-cidr: 10.123.{{ grains['weave']['host_id'] }}.0/24
    bip: 
    dns: 10.123.0.{{ grains['weave']['host_id'] }}
