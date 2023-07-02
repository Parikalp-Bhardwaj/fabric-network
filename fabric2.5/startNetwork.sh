docker-compose -f docker/docker-compose-ca.yaml up -d
sleep 2
sudo chmod 777 -R ./organizations
sleep 2
echo "Registerning and Enrollment"
./registerEnroll.sh
sleep 3
export FABRIC_CFG_PATH=${PWD}
export CHANNEL_NAME="mychannel"
sleep 3
../bin/configtxgen -profile TwoOrgsApplicationGenesis -outputBlock ./channel-artifacts/channel1.block -channelID channel1
sleep 2
docker-compose -f docker/docker-compose-cli.yaml up -d


