zookeeper:
  id: {{ grains['zk_id'] }}
  ip: {{ grains['ip4_interfaces']['eth0'][0] }}
