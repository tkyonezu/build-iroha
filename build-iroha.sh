#!/bin/basn

export PROTOBUF_BUILD=/opt/protobuf
export GRPC_BUILD=/opt/grpc

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export IROHA_HOME=/opt/iroha
export IROHA_BUILD=${IROHA_HOME}/build
export IROHA_TINY=${IROHA_HOME}/docker/tiny
export IROHA_RELEASE=${IROHA_TINY}/iroha

if docker images hyperledger/iroha-dev >/dev/null 2>&1; then
  docker build -t hyperledger/iroha-dev ${IROHA_HOME}/docker/dev
fi

docker run -i --rm \
  -v ${IROHA_HOME}:/opt/iroha \
  -v ${PROTOBUF_BUILD}:/opt/protobuf \
  -v ${GRPC_BUILD}:/opt/grpc \
  hyperledger/iroha-dev \
  sh <<EOF
    mkdir -p ${IROHA_BUILD}
    cd ${IROHA_BUILD}
    cmake ${IROHA_HOME} -DCMAKE_BUILD_TYPE=Release
    make -j 10

    bash ${IROHA_HOME}/docker/dev/mkrel.sh
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
