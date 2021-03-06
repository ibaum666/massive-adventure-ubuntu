#!/bin/bash
ubuntu_codename=`lsb_release -cs` 
echo "deb http://apt.postgresql.org/pub/repos/apt/ $ubuntu_codename-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install postgresql-9.4
usr=$USER
sudo -u postgres bash <<EOF
createuser "$usr"
createdb "$usr"
psql -c "alter role $usr with login superuser;"
psql -c "alter database $usr  owner to $usr;"
EOF
