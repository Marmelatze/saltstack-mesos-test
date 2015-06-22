base:
  '*': []


  'bastion':
    - cloud

  'G@roles:master and G@roles:slave':
    - match: compound
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
