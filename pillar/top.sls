base:
  '*':
    - consul
    - docker
    - weave
    - mine
    - etcd
    - flannel
    - mesos
    - cadvisor

  'roles:master':
    - match: grain
    - zookeeper

