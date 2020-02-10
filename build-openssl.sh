#!/bin/bash
# requires build tools: gcc & make
set -e -x

OPENSSL_VERSION="1.0.2"
OUT="/tmp/openssl"

cd /tmp
curl -O https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
tar xvf openssl-${OPENSSL_VERSION}.tar.gz
cd openssl-${OPENSSL_VERSION}
./config no-shared no-ssl2 no-ssl3 -fPIC --prefix=${OUT}
make && make install
