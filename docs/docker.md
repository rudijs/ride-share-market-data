# Docker

## Private Registry

Deployment currently uses a self hosted private docker registry.

Currently there is no SSL setup. Though the docker client to registry communication
is not encrypted (SSL) we use a VPN and IP address restrictions.

All Docker clients that push and/or pull need to start with with the *--insecure-registry* flag.

Development example from a Vagrant VM using the Chef docker cookbook: */etc/default/docker*

- `DOCKER_OPTS=' --host=unix:///var/run/docker.sock --restart=false --insecure-registry 192.168.33.10:5000'`

- Run the private registry on VM (192.168.33.10).
- `docker run -d --name rsm-registry -p 5000:5000 registry`

## Deployment

Both host OS and container instance will user an *rsm-data* user account with UID number *2000*.

For the host OS the ride-share-market-devops Chef repo will create this user account.

For the docker container instance the Dockerfile will create this user account.

The container instance will mount a *volume* for log files from the host OS with matching UIDs.

- Build docker image locally, tag it, push it to the private docker registry.
- `./docker-build.sh 0.0.2`
- On the remote server.
- `sudo docker pull 192.168.33.10:5000/rudijs/rsm-data:0.0.2`
- `sudo docker rm -f rpc && sudo docker run -d --restart always --name rpc --cap-add SYS_PTRACE --security-opt apparmor:unconfined -v /srv/ride-share-market-data/log:/srv/ride-share-market-data/log 192.168.33.10:5000/rudijs/rsm-data:0.0.2`
- Note: the *--cap-add SYS_PTRACE --security-opt apparmor:unconfined* flags above are require for pm2.

## Useful development commands

- Remove dangling images.
- `sudo docker rmi $(sudo docker images -q -f "dangling=true")`
- Remove all containers.
- `sudo docker rm -f $(sudo docker ps -a -q)`
- Run docker container locally.
- `sudo docker run -d --name rpc rudijs/rsm-data`
- Search private registry.
- `curl -X GET http://192.168.33.10:5000/v1/search?q=rsm`
- Delete from private registry.
- `curl -X DELETE http://192.168.33.10:5000/v1/repositories/rudijs/rsm-data:0.0.1`
