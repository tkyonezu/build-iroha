#!/bin/basn

if [ -z ${IROHA_HOME} ]; then
    echo "[FATAL] Empty variable IROHA_HOME"
    exit 1
fi

export IROHA_BUILD=${IROHA_HOME}/build
export IROHA_TINY=${IROHA_HOME}/docker/tiny

if docker images hyperledger/iroha-dev >/dev/null 2>&1; then
  docker build -t hyperledger/iroha-dev ${IROHA_HOME}/docker/dev
fi

docker run -i --rm \
  -v ${IROHA_HOME}:/opt/iroha \
  hyperledger/iroha-dev \
  sh <<EOF
    mkdir -p /opt/iroha/build
    cd /opt/iroha/build
    cmake /opt/iroha -DCMAKE_BUILD_TYPE=Release
    make -j 10

    bash /opt/iroha/docker/dev/mkrel.sh
EOF

# build iroha-docker
docker build -t hyperledger/iroha-docker ${IROHA_TINY}

cat << "EOF"
 _______   ______   .__   __.  _______ 
|       \ /  __  \  |  \ |  | |   ____|
|  .--.  |  |  |  | |   \|  | |  |__   
|  |  |  |  |  |  | |  . `  | |   __|  
|  '--'  |  `--'  | |  |\   | |  |____ 
|_______/ \______/  |__| \__| |_______|
                                      
EOF
