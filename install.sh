#!/bin/bash

set -e

echo installing Andela Crunchies Auto-Nominater....

cd ~/Downloads

git clone https://github.com/andela/crunchies.git && cd crunchies

sudo easy_install pip

brew install chromedriver

sudo pip install -r requirements.txt

sudo cp ~/Downloads/crunchies/nominate.app /Applications/nominate.app
sudo cp ~/Downloads/crunchies/nominate.plist /Library/LaunchAgents/nominate.plist

launchctl load /Library/LaunchAgents/nominate.plist

sudo rm -rf ~/Downloads/crunchies


osascript -e 'tell application "Terminal" to close first window' & exit