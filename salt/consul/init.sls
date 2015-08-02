unzip:
  pkg.installed: []



consul-user:
  user.present:
    - name: consul
    - system: True

/data:
  file.directory: []

/data/consul:
  file.directory:
    - user: consul
    - group: consul
    - require:
      - user: consul-user
      - file: /data

consul-download:
  cmd.run:
    - name: 'curl -L https://dl.bintray.com/mitchellh/consul/{{ pillar['consul']['version'] }}_linux_amd64.zip -o /usr/src/consul-{{ pillar['consul']['version'] }}.zip'
    - unless: test -f /usr/src/consul-{{ pillar['consul']['version'] }}.zip

consul-extract:
  cmd.wait:
    - name: 'unzip consul-{{ pillar['consul']['version'] }}.zip'
    - unless: test -d /usr/src/consul-{{ pillar['consul']['version'] }}
    - cwd: /usr/src
    - require:
      - cmd: consul-download
    - watch:
      - cmd: consul-download

consul-binary:
  cmd.wait:
    - name: 'mv consul /usr/local/bin/consul && chmod +x /usr/local/bin/consul'
    - cwd: /usr/src
    - require:
      - cmd: consul-extract
    - watch:
      - cmd: consul-extract

/usr/share/consul/ui:
  archive.extracted:
    - source: https://dl.bintray.com/mitchellh/consul/{{ pillar['consul']['version'] }}_web_ui.zip
    - source_hash: {{ pillar['consul']['hash']['ui'] }}
    - archive_format: zip


## consul service

/etc/init/consul.conf:
  file.managed:
    - source: salt://consul/templates/upstart
    - watch_in:
      - service: consul

{% set expect = salt['mine.get']('G@roles:master', 'network.ip_addrs', expr_form='compound').items()|length %}
#'

/etc/consul/server:
  file.recurse:
    - source: salt://consul/templates/server
    - template: jinja
    - makedirs: True
    - watch_in:
      - service: consul
    - context:
        expect: {{ expect }}


consul:
  service:
    - running
  require:
    - file: /etc/init/consul.conf
    - archive: /usr/share/consul/ui
  watch:
    - file: /etc/inid/consul.conf


# dns
dnsmasq:
  pkg.installed: []
  service:
    - running


/etc/dnsmasq.d/10-consul:
  file.managed:
    - source: salt://consul/templates/dnsmasq
    - template: jinja
    - require:
      - pkg: dnsmasq
    - watch_in:
      - service: dnsmasq


## consul template
/usr/src/consul-template:
  archive.extracted:
    - source: https://github.com/hashicorp/consul-template/releases/download/v{{ pillar['consul']['template']['version'] }}/consul-template_{{ pillar['consul']['template']['version'] }}_linux_amd64.tar.gz
    - source_hash: {{ pillar['consul']['template']['hash'] }}
    - archive_format: tar
    - if_missing: /usr/src/consul-template/consul-template_{{ pillar['consul']['template']['version'] }}_linux_amd64

/usr/local/bin/consul-template:
  file.copy:
    - source: /usr/src/consul-template/consul-template_{{ pillar['consul']['template']['version'] }}_linux_amd64/consul-template
    - mode: 0755
    - force: True
    - require:
      - archive: /usr/src/consul-template
    - watch:
      - archive: /usr/src/consul-template

/etc/consul/template.hcl:
  file.managed:
    - source: salt://consul/templates/template.hcl
    - template: jinja
    - watch_in:
      - service: consul-template


/etc/consul/templates/global:
  file.recurse:
    - source: salt://consul/templates/templates
    - makedirs: True
    - template: jinja
    - watch_in:
      - service: consul-template
    - require_in:
      - service: consul-template
    - context:
        customer_id: 0

{% if pillar['schub']['customer_id'] != 0 %}
/etc/consul/templates/customer:
  file.recurse:
    - source: salt://consul/templates/templates
    - makedirs: True
    - template: jinja
    - watch_in:
      - service: consul-template
    - require_in:
      - service: consul-template
    - context:
        customer_id: {{ pillar['schub']['customer_id'] }}

{% else %}
/etc/nginx/sites-enabled/service-proxy:
  file.absent: []

/etc/nginx/sites-enabled/web-proxy:
  file.absent: []

/etc/nginx/streams-enabled/service-proxy:
  file.absent: []

{% endif %}

/etc/init/consul-template.conf:
  file.managed:
    - source: salt://consul/templates/template-upstart
    - watch_in:
      - service: consul-template

consul-template:
  service:
    - running
    - enable: True
    - require:
      - file: /etc/init/consul-template.conf
      - file: /etc/consul/template.hcl
