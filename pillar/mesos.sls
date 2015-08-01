mesos:
  interface: eth0

mesos-slave:
  attributes:
    rack: a
    foo: bar
    customer: customer-{{ salt['grains.get']('customer_id', 0) }}
