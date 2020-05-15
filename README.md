### To setup on server
```
cd installation-scripts
sudo ./setup-docker-server.sh [user name]
sudo ./setup-app-server.sh
./pull-docker-images.sh

./install-alias.sh
```

##### Where

```
setup-docker-server.sh
```
will install docker and setup to run docker without sudo


```
setup-app-server.sh
```
will install NodeJS v12.16.3, NPM 6.13.7 and Angular CLI lastest


```
pull-docker-images.sh
```
will pull docker images, includes: postgres, neo4j, elasticsearch, cassandra, kong


```
install-alias.sh
```
will install some convenient alias method, for example:
```
dexec X
# >> docker exec -it X /bin/bash

dlogs X
# >> docker logs X
```

### To run containers
```
cd init-docker-containers

./init*.sh
```
