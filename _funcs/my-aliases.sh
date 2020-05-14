

#my-alias starts
dexec() {
	docker exec -it "$1" /bin/bash
}

dlogs() {
	docker logs "$1"
}
#my-alias end


