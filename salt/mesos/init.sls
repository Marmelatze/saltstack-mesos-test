mesos-repo:
  pkgrepo.managed:
    - humanname: Mesos Repo
    - name: deb http://repos.mesosphere.io/{{ grains['os']|lower }} {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/mesosphere.list
    - keyid: E56151BF
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: mesosphere
      - pkg: mesos

/etc/mesos/zk:
  file.managed:
    - source: salt://mesos/templates/zk.j2
    - template: jinja
    - makedirs: True

{% for server, addrs in salt['mine.get']('*', 'network.ip_addrs').items() %}

host-{{ server}}:
  host.present:
  - name: {{ server }}
  - ip: {{ addrs[0] }}

{% endfor %}
