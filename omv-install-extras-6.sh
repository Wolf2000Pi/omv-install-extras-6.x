#!/bin/bash 

echo
echo -e "\033[36m Autoinstaller für Openmediavault 4.x und Extras.org\033[0m"
echo
echo -e "\033[36m Author:     Wolf2000\033[0m"
echo -e "\033[36m Version:         1.1\033[0m"
echo -e "\033[36m https://forum-bpi.de\033[0m"
echo -e "\033[31m Achtung das ist eine OMV-Test es kann eventuell nicht lauffähig sein \033[0m"
echo
echo -e "\033[32m Wolle sie Openmediaut mit Plugins installieren\033[0m"
echo -e "\033[32m Ihre Antwort, n/j:\033[0m"
read answer
#echo Das installieren wurde abgebrochen
echo  Ihre Antwort war: $answer
# if [ "$answer" = "j" ]
if [ "$answer" != "n" ]
  then echo
  
  
  
  
echo
echo
echo -e "\033[32m Das wars Openmediavult und Extras.org ist jetzt Installiert\033[0m"
else echo -e "\033[31m Die Installation wurde abgebrochen\033[0m"
fi
