#!/bin/bash
set -e

echo "=== Update system ==="
sudo apt update -y
sudo apt upgrade -y

echo "=== Install dependencies for Python build ==="
sudo apt install -y \
    wget build-essential checkinstall \
    libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev \
    libffi-dev zlib1g-dev make

PY_VER=3.8.18
PY_DIR=/usr/src/Python-$PY_VER

echo "=== Download Python $PY_VER source ==="
cd /usr/src
sudo wget https://www.python.org/ftp/python/$PY_VER/Python-$PY_VER.tgz
sudo tar xzf Python-$PY_VER.tgz

echo "=== Compile & Install Python $PY_VER ==="
cd $PY_DIR
sudo make clean || true
sudo ./configure --enable-optimizations
sudo make altinstall

echo "=== Verify SSL support ==="
python3.8 -c "import ssl; print('SSL Version:', ssl.OPENSSL_VERSION)"

echo "=== Install pip, setuptools, wheel ==="
python3.8 -m ensurepip
python3.8 -m pip install --upgrade pip setuptools wheel

echo "=== Done! Check versions ==="
python3.8 --version
python3.8 -m pip --version
