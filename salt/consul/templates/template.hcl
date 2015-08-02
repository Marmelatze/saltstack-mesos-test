consul = "{{ pillar['docker']['gw'] }}:8500"

template {
  source = "/etc/consul/templates/global/nginx.ctmpl"
  destination = "/etc/nginx/sites-enabled/global-service-proxy"
  command = "service nginx restart || true"
}

template {
  source = "/etc/consul/templates/global/nginx-stream.ctmpl"
  destination = "/etc/nginx/streams-enabled/global-service-proxy"
  command = "service nginx restart || true"
}

template {
  source = "/etc/consul/templates/global/nginx-web.ctmpl"
  destination = "/etc/nginx/sites-enabled/global-web-proxy"
  command = "service nginx restart || true"
}

{% if pillar['schub']['customer_id'] != 0 %}
template {
  source = "/etc/consul/templates/customer/nginx.ctmpl"
  destination = "/etc/nginx/sites-enabled/service-proxy"
  command = "service nginx restart || true"
}

template {
  source = "/etc/consul/templates/customer/nginx-stream.ctmpl"
  destination = "/etc/nginx/streams-enabled/service-proxy"
  command = "service nginx restart || true"
}

template {
  source = "/etc/consul/templates/customer/nginx-web.ctmpl"
  destination = "/etc/nginx/sites-enabled/web-proxy"
  command = "service nginx restart || true"
}
{% endif %}
