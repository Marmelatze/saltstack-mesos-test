/etc/salt/cloud.providers.d/openstack.conf:
  file.managed:
    - source: salt://cloud/templates/openstack.conf
