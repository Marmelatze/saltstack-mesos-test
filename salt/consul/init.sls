unzip:
  pkg.installed: []

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
    - source_hash: md5=ba0bc4923a7d1da2a2b6092872c84822
    - archive_format: zip

## consul service

/etc/init/consul.conf:
  file.managed:
    - source: salt://consul/templates/upstart
    - watch_in:
      - service: consul

/etc/consul:
  file.directory: []

/etc/consul/server/config.json:
  file.managed:
    - source: salt://consul/templates/server.json
    - template: jinja
    - makedirs: True
    - require:
      - file: /etc/consul
    - watch_in:
      - service: consul

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
    - require:
      - pkg: dnsmasq
    - watch_in:
      - service: dnsmasq

