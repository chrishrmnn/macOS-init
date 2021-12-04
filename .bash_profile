#!/usr/bin/env bash

# Easier navigation
alias ..="cd .."
alias ....="cd ../.."
alias ~="cd ~"

# Shortcuts
alias sites="cd ~/Sites"

# A better ls
alias ls="ls -lhGFa"

# Flush DNS
alias flushdns="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Show/hide hidden files
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles -boolean false && killall Finder"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles -boolean true && killall Finder"

# SSH related
alias copyssh="pbcopy < ~/.ssh/id_rsa.pub"

# Clean DS_Store recursively
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"
