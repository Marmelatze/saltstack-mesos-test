# Installation

Es wird ein Salt-Master benötigt, die anderen Hosts sind Minions.



## Master-Installation:

Kombinierte Installation von Master und Minion:

```
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh -M -P
```

Dieses Repository in /srv/salt clonen

```
sudo git clone https://github.com/Marmelatze/saltstack-mesos-test /srv/salt
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

Master neustarten

```
sudo service salt-master restart
```

Die Minion-Instalation muss jetzt nicht mehr ausgeführt werden, allerdings die Konfiguration angepasst werden.
In der Minion-Konfiguration muss der Eintrag master noch auf localhost geändert werden.


## Minion-Installation

Nur den Minion installieren ohne Master (nicht nötig, wenn Master installiert wurde):

```
curl -L https://bootstrap.saltstack.com -o install_salt.sh
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

Die Salt-Grains anpassen, dabei muss eine ID gewählt werden (z.B. 1).

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
sudo service salt-minion restart
```


Auf dem Master muss der Public-Key des neuen Minions akzeptiert werden:

```
sudo salt-key -A
```

## SaltStack ausführen

Auf einem Minion:

```
sudo salt-call state.highstate
```

Vom Salt-Master alle Minions updaten:

```
sudo salt '*' state.highstate
```
