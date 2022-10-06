#!/bin/bash
FOLDERNAME=$1
mkdir $FOLDERNAME && cd $FOLDERNAME
npm init -y
npm install --save-dev truffle
mkdir -p contracts/access-control
cp ../box.sol contracts/box.sol
cp ../truffle-config.js $(pwd)/truffle-config.js
npm install @openzeppelin/contracts
# npm install --save-dev ganache-cli
npx truffle init
cp ../2_deploy.js migrations/
npx truffle compile
current_work_path=$(pwd)
# #Fix this step so it is in a separate session or dockerized 
xterm -e /bin/bash  -c "cd $current_work_path && ganache-cli --deterministic --db $(pwd)/db" &
sleep 3
npx truffle migrate --network development
xterm -e /bin/bash  -c "cd $current_work_path && npx truffle console --network development" &

#docker pull ethereum/solc:0.8.17-alpine

