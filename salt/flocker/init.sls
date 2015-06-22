flocker-repo:
  pkgrepo.managed:
    - humanname: ClusterHQ
    - name: deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/{{ grains['lsb_distrib_release']}}/$(ARCH) /
    - file: /etc/apt/sources.list.d/clusterhq.list
    - require_in:
      - pkg: clusterhq-flocker-node


clusterhq-flocker-node:
  pkg.installed:
    - skip_verify: True
    - force_yes: True
