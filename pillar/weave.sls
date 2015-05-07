weave:
  host_id: {{ grains['weave']['host_id'] }}
  bridge_cidr: 10.123.0.{{ grains['weave']['host_id'] }}/16
  network_cidr: 10.123.{{ grains['weave']['host_id'] }}.0/24

docker:
  network:
    bridge: weave
    fixed_cidr: 10.123.{{ grains['weave']['host_id'] }}.0/24
