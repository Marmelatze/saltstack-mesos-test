consul = "{{ pillar['docker']['gw'] }}:8500"

#template {
#  source = "/etc/consul/templates/nginx.ctmpl"
#  destination = "/etc/nginx/sites-enabled/consul-proxy"
#}

template {
  source = "/etc/consul/templates/influxdb.ctmpl"
  destination = "/etc/nginx/sites-enabled/influxdb"
  command = "service nginx reload || true"
}

