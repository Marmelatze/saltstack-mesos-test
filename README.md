# Installation

Es wird ein Salt-Master benötigt, die anderen Hosts sind Minions.



## Master-Installation:

Kombinierte Installation von Master und Minion:

```
curl -L https://bootstrap.saltstack.com | sudo sh
sudo sh install_salt.sh -M
```

Dieses Repository in /srv/salt clonen

```
git clone https://github.com/Marmelatze/saltstack-mesos-test /srv/salt
```

Konfiguration des Masters anpassen:

```yaml
#/etc/salt/master

file_roots:
  base:
    - /srv/salt/salt
# ...
pillar_roots:
  base:
    - /srv/salt/pillar
```


## Minion-Installation

Nur den Minion installieren ohne Master:

```
curl -L https://bootstrap.saltstack.com | sudo sh
sudo sh install_salt.sh -A IP_MASTERS
```

In Minion-Konfiguration am Ende einfügen:

```yaml
# /etc/salt/minion

# ...
mine_interval: 5
mine_functions:
  network.ip_addrs:
    interface: eth0
  zookeeper:
    - mine_function: pillar.get
    - zookeeper
```

Die Salt-Grains anpassen, dabei muss eine .

```
# /etc/salt/grains
weave:
  host_id: ID
host_id: ID # ID des Hosts
zk_id: ID # ID für Zookeper
customer_id: 1 # optionale ID eines Kunden
roles:
- master
- slave
```

Die Rolle kann auch nur `slave` oder `master` sein. Auf Slaves wird Mesos-Slave mit Docker installiert, auf Masters Zookeeper, Mesos-Master und Marathon.

Den Minion neustarten:

```
service salt-minion restart
```

## SaltStack ausführen

Auf einem Minion:

```
salt-call state.highstate
```

Vom Salt-Master alle Minions updaten:

```
salt '*' state.highstate
```
