#!/bin/bash

echo installing Andela Crunchies Auto-Nominater....

cd ~/Downloads

git clone https://github.com/andela/crunchies.git && cd crunchies

BREW=`which brew`
if [[ "$BREW" != "/usr/local/bin/brew" ]]; then
  # User does not have brew installed
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [[ "$OSTYPE" == "darwin15"* ]]; then
  # El Capitan
  brew reinstall python
else
  #Older Mac Versions
  sudo easy_install pip
fi

brew install chromedriver
sudo pip install -r requirements.txt

sudo cp -vr ~/Downloads/crunchies/nominate.app /Applications/nominate.app
sudo cp -av ~/Downloads/crunchies/nominate.plist /Library/LaunchAgents/nominate.plist

launchctl load /Library/LaunchAgents/nominate.plist

sudo rm -rf ~/Downloads/crunchies

osascript -e 'display notification "Crunchies Installation complete!" with title "Andela Crunchies"'

osascript -e 'tell application "Terminal" to close first window' & exit
