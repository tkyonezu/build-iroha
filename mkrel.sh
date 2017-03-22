#!/bin/bash

IROHA_HOME=/opt/iroha
IROHA_BUILD=${IROHA_HOME}/build
IROHA_TINY=${IROHA_HOME}/docker/tiny
IROHA_RELEASE=${IROHA_TINY}/iroha

# copy libs used by iroha
LIBS=$(ldd ${IROHA_BUILD}/bin/iroha-main | cut -f 2 | cut -d " " -f 3)
mkdir -p ${IROHA_RELEASE}/lib
cp -H ${LIBS} ${IROHA_RELEASE}/lib

# copy config
mkdir -p ${IROHA_RELEASE}/config
cp ${IROHA_HOME}/config/sumeragi.json ${IROHA_RELEASE}/config/sumeragi.json
cp ${IROHA_HOME}/config/config.json ${IROHA_RELEASE}/config/config.json

rsync -avr ${IROHA_BUILD}/bin ${IROHA_RELEASE}
rsync -avr ${IROHA_TINY}/scripts ${IROHA_RELEASE}

