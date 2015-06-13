base:
  '*':
    - mesos
    - consul


  'roles:master':
    - match: grain
    - mesos-master
    - marathon

  'roles:slave':
    - match: grain
    - mesos-slave
    - docker
    - weave
    - nginx
    - cadvisor
    - registrator
    - schub

  'G@host_id == 0':
    - match: compound
    - registry
