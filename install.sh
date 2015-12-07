#!/bin/bash

echo "installing Andela Crunchies Auto-Nominater...."

function go_to_downloads_directory {
  echo "change directory to Downloads"
  cd ~/Downloads
}

function clone_crunchies {
  echo "cloning crunchies repo...."
  git clone https://github.com/andela/crunchies.git 
  cd crunchies
}

function assert_user_has_homebrew {
  echo "assert that user has homebrew installed"
  BREW=`which brew`
  if [[ "$BREW" != "/usr/local/bin/brew" ]]; then
    # User does not have brew installed
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function give_el_capitan_users_the_good_python_give_older_os_users_pip {
  echo "make sure El Capitan users have a stable version of python and pip"
  if [[ "$OSTYPE" == "darwin15"* ]]; then
    # El Capitan
    brew reinstall python
    echo 'PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"' >> ~/.bash_profile
  else
    #Older Mac Versions
    sudo easy_install pip
  fi
}

function install_chromedriver {
  echo "install chromedriver"
  brew install chromedriver
}

function globally_install_python_requirements {
  echo "install python script requirements and dependencies"
  sudo pip install -r requirements.txt
}

function copy_app_and_launcher_config {
  echo "copy app to Applications and set launch config"
  sudo cp -vr ~/Downloads/crunchies/nominate.app /Applications/nominate.app
  sudo cp -av ~/Downloads/crunchies/nominate.plist /Library/LaunchAgents/nominate.plist
}

function launch_scheduler {
  echo "launch scheduler config"
  launchctl load /Library/LaunchAgents/nominate.plist
}

function clean_up {
  echo "clean up"
  CRUNCHIES_DIRECTORY="~/Downloads/crunchies"
  if [ -d "$CRUNCHIES_DIRECTORY" ]; then
    # Control will enter here if $DIRECTORY exists.
    echo "deleting already existing crunchies directory"
    eval sudo rm -rf "$CRUNCHIES_DIRECTORY"
  fi
}

function display_completion_notification {
  echo "display notification"
  osascript -e 'display notification "Crunchies Installation complete!" with title "Andela Crunchies"'
}

function close_terminal {
  echo "close terminal window"
  osascript -e 'tell application "Terminal" to close first window' & exit
}

go_to_downloads_directory
clean_up
clone_crunchies
assert_user_has_homebrew
give_el_capitan_users_the_good_python_give_older_os_users_pip
install_chromedriver
globally_install_python_requirements
copy_app_and_launcher_config
launch_scheduler
clean_up
display_completion_notification
close_terminal
