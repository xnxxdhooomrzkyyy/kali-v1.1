echo "UPDATING SYSTEM!!!"
apt-get update

echo "UPGRADING SYSTEM!!!"
apt-get upgrade -y

echo "INSTALL DEPENDENSI DASAR!!!"
apt-get install python3 python3-pip python3-venv build-essential git zip unzip openjdk-8-jdk zlib1g-dev libncurses5-dev lib32z1 lib32stdc++6 pkg-config libffi-dev libssl-dev -y
