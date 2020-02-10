#!/bin/bash
# works on ubuntu
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
pip install ${CWD}/wheelhouse/librabbitmq-2.0.0-cp27-cp27mu-manylinux2014_armv7l.whl
python -c "import librabbitmq"
