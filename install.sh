#!/bin/sh

# Add root password
sudo -v

# Keep-alive: update `sudo` timestamp
# while `install.sh` is running
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## Install Homebrew - the ultimate package manager on Mac
if test ! $(which brew)
then
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Add Homebrew to your PATH
# For M1 chipset
echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ~/.zshrc
eval $(/opt/homebrew/bin/brew shellenv)
# For Intel chipset
# echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc

# Update the available applications
brew update
brew upgrade
brew doctor

# Install applications defined in the Brewfile
# and update the existing one
brew bundle

## node.js packages
echo "Install node development tools"
npm install -g yarn
npm install -g grunt
npm install -g grunt-cli

## ruby stuff
echo "Install Ruby stuff (Bundler, etc.)"
gem install bundler

# echo "Finalisation PHP installation"
# echo 'export PATH="$(brew --prefix homebrew/php/php71)/bin:$PATH"' >> ~/.zshrc
# brew services start php71
# brew services start httpd24

echo "Some cleanup…"
brew cask cleanup
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

echo ""
echo "…and it's done [✓]"
