### To setup on server
```
cd installation-scripts
./setup-docker-server.sh
./pull-docker-images.sh

./install-alias.sh
```

##### Where
```
setup-docker-server.sh
```
will install docker and setup to run docker without sudo

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
