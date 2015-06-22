consul:
  version: 0.5.2
  hash:
    ui: "md5=eb98ba602bc7e177333eb2e520881f4f"
  encrypt: "isRJBhPfMKC3DeS3ZNbDXw=="
  template:
    version: 0.10.0
    hash: "md5=c09d9e77ff079e17b7097af882eab5d6"
  mode: {% if 'master' in salt['grains.get']('roles', []) %}server{% else %}client{% endif %}
