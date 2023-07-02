docker-compose -f docker/docker-compose-cli.yaml down
sleep 3
docker-compose -f docker/docker-compose-ca.yaml down
sleep 2
docker volume rm $(docker volume ls -q)
sleep 2
rm -rf ./organizations
sleep 2 
rm -rfv ./channel-artifacts/*
sleep 2
rm -rf ./config

