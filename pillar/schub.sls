schub:
  docker-controller:
    image: marmelatze/docker-controller:1.0-SNAPSHOT
  domain: schub-test.local
  customer_id: {{ salt['grains.get']('customer_id', 0) }}
