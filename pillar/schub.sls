# SCHub specific config
schub:
  docker-controller:
    # image for the docker-controller
    image: marmelatze/docker-controller:1.0-SNAPSHOT
  # domain used for the service-gateway
  domain: schub-test.local
  # ID for the customer read from grains
  customer_id: {{ salt['grains.get']('customer_id', 0) }}
