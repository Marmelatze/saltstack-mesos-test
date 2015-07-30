docker:
  host_id: {{ grains['host_id'] }}
  gw: 10.123.0.{{ grains['host_id'] }}
  registry: 10.123.0.1:5000
  options:
    mtu: 1480
    bridge: weave
    fixed-cidr: 10.123.{{ grains['host_id'] }}.0/24
    bip: ~
    dns: 10.123.0.{{ grains['host_id'] }}
  {% set kernel = grains['kernelrelease'].split(".") %}
  {% if kernel[0]|int > 3 and kernel[1]|int > 18 %}
  storage: overlay
  {% else %}
  storage: aufs
  {% endif %}
