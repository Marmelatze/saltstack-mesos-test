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
  watch:
    - file: /etc/inid/consul.conf
