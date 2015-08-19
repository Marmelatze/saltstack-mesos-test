# docker config
docker:
  host_id: {{ grains['host_id'] }}
  # gateway for all containers (weave interface)
  gw: 10.{{ salt['grains.get']('customer_id', 0) }}.0.{{ grains['host_id'] }}
  # private registry
  registry: 10.0.0.1:5000
  # options passed to docker-daemon
  options:
    # mtu 1480 for weave overhead
    mtu: 1480
    bridge: weave
    # weave ip range
    fixed-cidr: 10.{{ salt['grains.get']('customer_id', 0) }}.{{ grains['host_id'] }}.0/24
    bip: ~
    # same as gateway, where dnsmasq runs
    dns: 10.{{ salt['grains.get']('customer_id', 0) }}.0.{{ grains['host_id'] }}
    
  # set storage to overlay or aufs depending on kernel version
  {% set kernel = grains['kernelrelease'].split(".") %}
  {% if kernel[0]|int >= 3 and kernel[1]|int >= 18 %}
  storage: overlay
  {% else %}
  storage: aufs
  {% endif %}
