weave:
  version: 0.11.0
  hash: md5=4cb8e60c53ef148b8b1ef5315f071af1
  host_id: {{ grains['host_id'] }}
  bridge_cidr: 10.{{ salt['grains.get']('customer_id', 0) }}.0.{{ grains['host_id'] }}/8
  network_cidr: 10.{{ salt['grains.get']('customer_id', 0) }}.{{ grains['host_id'] }}.0/24
  password: install
  scope:
    version: 0.2.0
    hash: md5=720d489fce75031261fe251af1ee589b
