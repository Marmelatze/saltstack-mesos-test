consul:
  version: 0.5.2
  hash:
    ui: "md5=eb98ba602bc7e177333eb2e520881f4f"
  encrypt: "isRJBhPfMKC3DeS3ZNbDXw=="
  template:
    version: 0.9.0
    hash: "md5=18ac93b225b54070b4fd8c733bdad0c3"
  mode: {% if 'master' in salt['grains.get']('roles', []) %}server{% else %}client{% endif %}
