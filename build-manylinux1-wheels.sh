#!/bin/bash
# Script modified from https://github.com/pypa/python-manylinux-demo
set -e -x

# Install a system package required by our library
yum  install -y librabbmitmq-devel make librabbitmq python-devel gcc automake cmake

# cmake version compatible with rabbitmq-c
curl -o /tmp/cmake.sh https://cmake.org/files/v3.5/cmake-3.5.1-Linux-x86_64.sh
sh /tmp/cmake.sh --skip-license --exclude-subdir --prefix=/usr/local

# Build openssl
/workspace/build-openssl.sh

cd /workspace
PYBIN="/opt/python/cp27-cp27mu/bin"
${PYBIN}/pip wheel /workspace/ -w wheelhouse/
auditwheel repair wheelhouse/librabbitmq-2.0.0-cp27-cp27mu-linux_x86_64.whl -w /workspace/wheelhouse/
${PYBIN}/pip install wheelhouse/librabbitmq-2.0.0-cp27-cp27mu-manylinux1_x86_64.whl
${PYBIN}/python -c "import librabbitmq"

# # Compile wheels
# for PYBIN in /opt/python/*/bin; do
#     #${PYBIN}/pip install -r /workspace/dev-requirements.txt
#     ${PYBIN}/pip wheel /workspace/ -w wheelhouse/
# done
#
# # Bundle external shared libraries into the wheels
# #ls wheelhouse/*
# for whl in wheelhouse/*linux*.whl; do
#     auditwheel repair $whl -w /workspace/wheelhouse/
# done
#
# # Install packages and test
# for PYBIN in /opt/python/*/bin; do
#     ${PYBIN}/pip install librabbitmq -f /workspace/wheelhouse
#     ${PYBIN}/python -c "import librabbitmq"
#     #(cd $HOME; ${PYBIN}/nosetests pymanylinuxdemo)
# done
