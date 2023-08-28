peer channel fetch config channel-artifacts/config_block.pb -o orderer:7050 --ordererTLSHostnameOverride orderer.example.com -c channel1 --tls --cafile /organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

sleep 2
cd channel-artifacts

configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json

sleep 1
jq '.data.data[0].payload.data.config' config_block.json > config.json

cp config.json config_copy.json

jq '.channel_group.groups.Application.groups.MvdMSP.values += {"AnchorPeers":{"mod_policy": "Admins","value":{"anchor_peers": [{"host": "peer0-mvd","port": 7051}]},"version": "0"}}' config_copy.json > modified_config.json

sleep 1
configtxlator proto_encode --input config.json --type common.Config --output config.pb

configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb

configtxlator compute_update --channel_id channel1 --original config.pb --updated modified_config.pb --output config_update.pb


sleep 2
configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate --output config_update.json


echo '{"payload":{"header":{"channel_header":{"channel_id":"channel1", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json

sleep 2

configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope --output config_update_in_envelope.pb

sleep 2

cd ..


peer channel update -f channel-artifacts/config_update_in_envelope.pb -c channel1 -o orderer:7050  --ordererTLSHostnameOverride orderer.example.com --tls --cafile "/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"

