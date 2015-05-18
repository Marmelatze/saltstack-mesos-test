consul:
  version: 0.5.0
  template: 
    version: 0.9.0
    hash: md5=18ac93b225b54070b4fd8c733bdad0c3
  services:
    - name: influxdb
      serviceName: influxdb
      internal:
        8086: 8086
        8083: 1500
      external:
        8083: 3010
        8086: 3011

