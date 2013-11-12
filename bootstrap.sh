sudo mkdir -p /opt/boxen
sudo chown ${USER}:staff /opt/boxen
git clone https://github.com/felipecvo/my-boxen.git /opt/boxen/repo
cd /opt/boxen/repo
script/boxen --no-fde
