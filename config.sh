# Fermer les fenêtres "Préférences Système"
osascript -e 'tell application "System Preferences" to quit'

# Keep-alive: met à jour le timestamp de `sudo`
# tant que `install.sh` n'est pas terminé
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Affichage de la barre latérale
defaults write com.apple.finder ShowStatusBar -bool true

# Afficher par défaut en mode colonne
# Flwv ▸ Cover Flow View
# Nlsv ▸ List View
# clmv ▸ Column View
# icnv ▸ Icon View
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Afficher le chemin d'accès
defaults write com.apple.finder ShowPathbar -bool true

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Affichage de toutes les extensions
sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Supprimer les doublons dans le menu "ouvrir avec…"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Fenêtre de sauvegarde complète par défaut
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Fenêtre d'impression complète par défaut
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Sauvegarde sur disque (et non sur iCloud) par défaut
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Ne pas alerter en cas de modification de l'extension d'un fichier
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Pas de création de fichiers .DS_STORE sur les disques réseau et externes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Supprimer l'alerte de quarantaine des applications
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Coup d'œîl : sélection de texte
defaults write com.apple.finder QLEnableTextSelection -bool true

# Dock : Taille minimum
defaults write com.apple.dock tilesize -int 36
# Dock : Agrandissement actif
defaults write com.apple.dock magnification -bool true
# Dock : Taille maximale pour l'agrandissement
defaults write com.apple.dock largesize -float 48

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Accès au clavier complet (tabulation dans les boîtes de dialogue)
sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Répétition touches plus rapide
sudo defaults write NSGlobalDomain KeyRepeat -int 1
# Délai avant répétition des touches
sudo defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Trackpad : toucher pour cliquer
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Vérifier la disponibilité de mise à jour quotidiennement
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Vérifier les mises à jour automatiquement
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Install system data files and security updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

# Safari : menu développeur / URL en bas à gauche / URL complète en haut / Do Not Track / affichage barre favoris
defaults write com.apple.safari IncludeDevelopMenu -int 1
defaults write com.apple.safari ShowOverlayStatusBar -int 1
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1

# Photos : pas d'affichage pour les iPhones
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES

# TextEdit : ouvre et enregistre les fichiers en UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# TextEdit : Mode "Texte" par défaut
defaults write com.apple.TextEdit RichText -int 0

# Démarrer en silence
sudo nvram SystemAudioVolume="%00"

# Enregistrer les screenshots en PNG (autres options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Changement du dossier d'enregistrement des screenshots
defaults write com.apple.screencapture location /Users/chris/Documents/_screenshots

# Ne pas mettre d'ombre sur les screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Quitter automatiquement l'utilitaire d'impression quand les tâches sont finies
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Afficher le pourcentage de batterie (Menu bar)
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.menuextra.battery ShowTime -string "NO"

# Recherche dans le repertoire courant par défaut
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Afficher le dossier "HOME" par défaut sur le Finder
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

## Configurer iTerm2 pour ne pas afficher l'alerte à la fermeture
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# ZSH as default shell
chsh -s /bin/zsh

# Télécharger Package Control pour Sublime Text et l'installer
# wget https://sublime.wbond.net/Package%20Control.sublime-package
# mv Package\ Control.sublime-package ~/Library/Application\ Support/Sublime\ Text\ 3/Installed\ Packages/


echo "Finder et Dock relancés… redémarrage nécessaire pour terminer."
killall Dock
killall Finder
killall SystemUIServer

echo ""
echo "Configuration [✓]"
