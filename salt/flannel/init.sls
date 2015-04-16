https://github.com/coreos/flannel.git:
  git.latest:
    - rev: v{{ pillar['flannel']['version'] }}
    - target: /usr/src/flannel

linux-libc-dev:
  pkg.installed: []

golang:
  pkg.installed: []

build-essential:
  pkg.installed: []

flannel-compile:
  cmd.wait:
    - name: ./build
    - cwd: /usr/src/flannel
    - require:
      - git: https://github.com/coreos/flannel.git
      - pkg: golang
      - pkg: linux-libc-dev
      - pkg: build-essential
    - watch:
      - git: https://github.com/coreos/flannel.git

/etc/init/flannel.conf:
  file.managed:
    - source: salt://flannel/templates/upstart
    - template: jinja
    - watch_in:
      - service: flannel


flannel:
  service:
    - running
    - enable: True
  require:
    - file: /etc/init/flannel.conf
  watch:
    - file: /etc/inid/flannel.conf

