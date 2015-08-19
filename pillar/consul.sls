# consul key value store config
consul:
  version: 0.5.2
  hash:
    # hash for the consul-ui archive
    ui: "md5=eb98ba602bc7e177333eb2e520881f4f"
  # encryption key for serf traffic
  encrypt: "isRJBhPfMKC3DeS3ZNbDXw=="
  # consul-template config
  template:
    # version to be installed
    version: 0.10.0
    # hash for the consul-template archive
    hash: "md5=c09d9e77ff079e17b7097af882eab5d6"
  # server or client mode
  mode: {% if 'master' in salt['grains.get']('roles', []) %}server{% else %}client{% endif %}
