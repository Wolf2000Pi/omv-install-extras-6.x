#!/bin/bash 



#Openmediavault 6
echo
echo -e "\033[36m Autoinstaller für Openmediavault 4.x und Extras.org\033[0m"
echo
echo -e "\033[36m Author:     Wolf2000\033[0m"
echo -e "\033[36m Version:         1.8\033[0m"
echo -e "\033[36m https://forum-bpi.de\033[0m"
echo -e "\033[31m Achtung das ist eine OMV-Test es kann eventuell nicht lauffähig sein \033[0m"
echo
echo -e "\033[32m Wolle sie Openmediaut mit Plugins installieren\033[0m"
echo -e "\033[32m Ihre Antwort, n/j:\033[0m"
read answer
echo Das installieren wurde abgebrochen
echo  Ihre Antwort war: $answer
# if [ "$answer" = "j" ]
if [ "$answer" != "n" ]
  then echo apt imstall wget &&
apt-get install --yes gnupg &&
wget -O "/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.asc" https://packages.openmediavault.org/public/archive.key &&
apt-key add "/etc/apt/trusted.gpg.d/openmediavault-archive-keyring.asc" &&

cat <<EOF >> /etc/apt/sources.list.d/openmediavault.list
deb https://packages.openmediavault.org/public shaitan main
# deb https://downloads.sourceforge.net/project/openmediavault/packages shaitan main
## Uncomment the following line to add software from the proposed repository.
# deb https://packages.openmediavault.org/public shaitan-proposed main
# deb https://downloads.sourceforge.net/project/openmediavault/packages shaitan-proposed main
## This software is not part of OpenMediaVault, but is offered by third-party
## developers as a service to OpenMediaVault users.
# deb https://packages.openmediavault.org/public shaitan partner
# deb https://downloads.sourceforge.net/project/openmediavault/packages shaitan partner
EOF
export LANG=C.UTF-8 &&
export DEBIAN_FRONTEND=noninteractive &&
export APT_LISTCHANGES_FRONTEND=none &&
apt-get update &&
apt-get --yes --auto-remove --show-upgraded \
    --allow-downgrades --allow-change-held-packages \
    --no-install-recommends \
    --option DPkg::Options::="--force-confdef" \
    --option DPkg::Options::="--force-confold" \
    install openmediavault-keyring openmediavault &&
	omv-confdbadm populate &&
apt-get update &&
sleep 3 &&
#export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" &&
# OMV extras

if [[ $(id -u) -ne 0 ]]; then
  echo "This script must be executed as root or using sudo."
  exit 99
fi

declare -i version

url="https://github.com/OpenMediaVault-Plugin-Developers/packages/raw/master/"

version=$(dpkg -l openmediavault | awk '$2 == "openmediavault" { print substr($3,1,1) }')

echo ${version}

if [ ${version} -lt 5 ]; then
  echo "Unsupported version of openmediavault"
  exit 0
fi

list="/etc/apt/sources.list.d/omvextras.list"
if [ -f "${list}" ]; then
  rm ${list}
fi

echo "Downloading omv-extras.org plugin for openmediavault ${version}.x ..."
file="openmediavault-omvextrasorg_latest_all${version}.deb"

echo "Updating repos before installing..."
apt-get update

echo "Install prerequisites..."
apt-get --yes --no-install-recommends install dirmngr gnupg

if [ -f "${file}" ]; then
  rm ${file}
fi
wget ${url}/${file}
if [ -f "${file}" ]; then
  dpkg -i ${file}

  if [ $? -gt 0 ]; then
    echo "Installing other dependencies ..."
    apt-get -f install
  fi

  echo "Updating repos ..."
  apt-get update
else
  echo "There was a problem downloading the package."
fi &&
dpkg -i openmediavault-omvextrasorg_latest_all6.deb &&
apt install openmediavault-omvextrasorg_latest_all6.deb &&

 # non-free
cd /root/ &&
sed -i -e "s/ main[[:space:]]*\$/ main contrib non-free/" /etc/apt/sources.list &&
apt update &&
apt upgrade --yes &&
 
echo
echo
echo -e "\033[32m Das wars Openmediavult und Extras.org ist jetzt Installiert\033[0m"
else echo -e "\033[31m Die Installation wurde abgebrochen\033[0m"
fi
