#!/bin/bash
# tested on ubuntu 16.04 (arm7l and aarch64)
# must be executed as ./build-linux-arm-wheels.sh to capture CWD
set -e -x

CWD=$(pwd)

apt-get update
apt-get install -y git build-essential cmake python python-dev virtualenv

# Build openssl
${CWD}/build-openssl.sh

cd /tmp
virtualenv env
. env/bin/activate
pip wheel ${CWD} -w ${CWD}/wheelhouse/
ARCH=$(python -c 'import platform; print(platform.machine())')
pip install ${CWD}/wheelhouse/librabbitmq-2.0.0-cp27-cp27mu-linux_${ARCH}.whl
python -c "import librabbitmq"
