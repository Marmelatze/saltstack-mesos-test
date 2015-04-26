etcd:
  version: 2.0.9
  discovery: {{ salt['grains.get']('etcd_discovery', 'https://discovery.etcd.io/e8e5f2384ffec62950ace028221a905f') }}
