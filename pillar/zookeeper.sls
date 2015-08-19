# config for zookeeper
zookeeper:
  # unique id, should start at 1
  id: {{ grains['zk_id'] }}
  # ip for running zookeeper on
  ip: {{ grains['ip4_interfaces']['eth0'][0] }}
