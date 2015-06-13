consul = "{{ pillar['docker']['gw'] }}:8500"

#template {
#  source = "/etc/consul/templates/nginx.ctmpl"
#  destination = "/etc/nginx/sites-enabled/consul-proxy"
#}

template {
  source = "/etc/consul/templates/nginx.ctmpl"
  destination = "/etc/nginx/sites-enabled/service-proxy"
  command = "service nginx reload || true"
}

template {
  source = "/etc/consul/templates/nginx-stream.ctmpl"
  destination = "/etc/nginx/streams-enabled/service-proxy"
  command = "service nginx reload || true"
}
