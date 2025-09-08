#!/bin/bash
# Script khusus Kali Linux 1.1 (Debian Wheezy)
# Install pip, setuptools, wheel, cython, Buildozer, Android SDK & NDK versi lawas
# Semua versi sudah disesuaikan untuk kompatibilitas

set -e

echo "[*] ==============================="
echo "[*] Buildozer Installer untuk Kali 1.1"
echo "[*] ==============================="

# ==========================
# Install dependencies OS
# ==========================
echo "[*] Update dan install dependencies dasar..."
sudo apt-get update
sudo apt-get install -y \
    python3 python3-pip python3-venv \
    build-essential git zip unzip wget curl \
    zlib1g-dev libncurses5-dev lib32z1 lib32stdc++6 \
    pkg-config libffi-dev libssl-dev openjdk-7-jdk || true

# ==========================
# Upgrade pip lawas kompatibel
# ==========================
PIP_VER="20.3.4"
echo "[*] Upgrade pip ke versi kompatibel: $PIP_VER"
python3 -m pip install --upgrade "pip==$PIP_VER"

# ==========================
# Install setuptools lawas
# ==========================
ST_VER="44.1.1"
echo "[*] Install setuptools versi: $ST_VER"
wget -c https://files.pythonhosted.org/packages/source/s/setuptools/setuptools-$ST_VER.tar.gz -O setuptools-$ST_VER.tar.gz
tar xzf setuptools-$ST_VER.tar.gz
cd setuptools-$ST_VER
python3 setup.py build
sudo python3 setup.py install
cd ..

# ==========================
# Install wheel lawas
# ==========================
WH_VER="0.36.2"
echo "[*] Install wheel versi: $WH_VER"
wget -c https://files.pythonhosted.org/packages/source/w/wheel/wheel-$WH_VER.tar.gz -O wheel-$WH_VER.tar.gz
tar xzf wheel-$WH_VER.tar.gz
cd wheel-$WH_VER
python3 setup.py build
sudo python3 setup.py install
cd ..

# ==========================
# Install cython lawas
# ==========================
CY_VER="0.29.21"
echo "[*] Install Cython versi: $CY_VER"
python3 -m pip install "cython==$CY_VER"

# ==========================
# Install Buildozer
# ==========================
echo "[*] Clone Buildozer dari GitHub..."
git clone https://github.com/kivy/buildozer.git
cd buildozer
python3 setup.py build
python3 setup.py bdist_wheel
sudo pip3 install dist/*.whl
cd ..

# ==========================
# Install Android SDK & NDK lawas
# ==========================
ANDROID_DIR="$HOME/.buildozer/android"
mkdir -p "$ANDROID_DIR"

# SDK Tools lawas
echo "[*] Download Android SDK Tools (4333796)"
wget -c https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O sdk-tools.zip
unzip -o sdk-tools.zip -d "$ANDROID_DIR/sdk"

# NDK r19c
echo "[*] Download Android NDK r19c"
wget -c https://dl.google.com/android/repository/android-ndk-r19c-linux-x86_64.zip -O ndk.zip
unzip -o ndk.zip -d "$ANDROID_DIR"
ln -sfn "$ANDROID_DIR/android-ndk-r19c" "$ANDROID_DIR/ndk"

# Install platform-tools & build-tools minimal
yes | "$ANDROID_DIR/sdk/tools/bin/sdkmanager" \
    "platform-tools" "platforms;android-28" "build-tools;28.0.3"

# ==========================
# Verifikasi
# ==========================
echo "[*] Verifikasi versi:"
echo -n "pip: "; pip3 --version
echo -n "setuptools: "; python3 -m setuptools --version
echo -n "wheel: "; python3 -m wheel version
echo -n "cython: "; python3 -m cython --version
echo -n "buildozer: "; buildozer --version
"$ANDROID_DIR/sdk/tools/bin/sdkmanager" --list | head -n 20

echo "[✔] Selesai! Buildozer siap digunakan di Kali Linux 1.1"
echo "👉 Contoh: mkdir ~/myapp && cd ~/myapp && buildozer init"
