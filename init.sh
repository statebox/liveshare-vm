#/bin/sh

DEBIAN_FRONTEND=noninteractive apt update -y
DEBIAN_FRONTEND=noninteractive apt install -y task-lxde-desktop aptitude less vim-gtk sakura git tig

cd /tmp

echo  "installing nomachine"
curl -LO https://download.nomachine.com/download/6.6/Linux/nomachine_6.6.8_5_amd64.deb
dpkg -i nomachine_6.6.8_5_amd64.deb

echo  "installing vscode"
curl -Lo code_1.34.0-1557957934_amd64.deb https://go.microsoft.com/fwlink/?LinkID=760868
dpkg -i code_1.34.0-1557957934_amd64.deb
cd

cat << EOF > /usr/NX/etc/server.cfg
AcceptedWebMethods classic,webrtc
AvailableSessionTypes unix-remote,unix-console,unix-default,unix-application,physical-desktop,shadow
ClientConnectionMethods NX,SSH
ConfigFileVersion 4.0
EnablePasswordDB 1
EnableUPnP NX
EnableUserDB 1
EnableWebPlayer 1
NXPort 4000
SSHAuthorizedKeys authorized_keys
Section "Server"
DisplayGeometry 1280x800

Name "Connection to localhost"
Host 127.0.0.1
Protocol NX
Port 4000
Authentication password

EndSection
EOF

# add user
sh -c "echo \"geheim\ngeheim\n\" | /usr/NX/bin/nxserver --useradd wires"

# install statebox software
cat << EOF > /tmp/setup.sh
# /bin/sh

# install vsliveshare plugin
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension zjhmale.idris

# install elba
mkdir -p bin
cd bin
curl -LO https://github.com/elba/elba/releases/download/0.2.0/elba-0.2.0-x86_64-unknown-linux-gnu.tar.gz
tar xzvf elba-0.2.0-x86_64-unknown-linux-gnu.tar.gz
rm elba-0.2.0-x86_64-unknown-linux-gnu.tar.gz

# store code in
cd
mkdir -p code/statebox code/typedefs
git clone https://github.com/typedefs/typedefs code/typedefs/typedefs.git
git clone https://github.com/statebox/idris-ct code/statebox/idris-ct.git
EOF

chown wires /tmp/setup.sh
sudo su -l wires -c "sh /tmp/setup.sh"