#!/bin/sh

# Demande du mot de passe administrateur dès le départ
sudo -v

# Keep-alive: met à jour le timestamp de `sudo`
# tant que `install.sh` n'est pas terminé
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

## LA BASE : Homebrew et les lignes de commande
if test ! $(which brew)
then
  echo "Installation de Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Ajout des binaires Homebrew au PATH
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.zshrc

# Mettre à jour la liste des applications disponibles
brew update
brew upgrade
brew doctor

# Installer Dropbox au plus tôt pour lancer la synchro des settings
brew cask install dropbox
echo "Opening Dropbox to start synchronisation"
open -a Dropbox

# Installer les nouvelles applications du bundle Brewfile
# et mettre à jour celles déjà présentes
brew bundle

## node.js packages
echo "Install node development tools"
npm install -g yarn
npm install -g grunt
npm install -g grunt-cli

## ruby stuff
echo "Install Ruby stuff (Bundler, etc.)"
gem install bundler

# echo "Finalisation de l'installation de PHP"
# echo 'export PATH="$(brew --prefix homebrew/php/php71)/bin:$PATH"' >> ~/.zshrc
# brew services start php71
# brew services start httpd24

echo "Some cleanup…"
brew cask cleanup
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

echo ""
echo "…and it's done [✓]"
