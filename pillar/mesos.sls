mesos:
  interface: eth0

mesos-slave:
  attributes:
    rack: a
    foo: bar
    {% if grains['customer_id'] is defined %}
    customer: {{ grains['customer_id'] }}
    {% endif %}
