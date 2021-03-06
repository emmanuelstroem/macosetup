#! /bin/bash
set -ex

echo "Preparing Foundation... "

echo "Installing xcode-stuff"
if xcode-select --install; then
  echo "xcode-select installed"
else
  echo "xcode-select already exists"
fi

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Setup ZSH Shell"
sh ./environments/ohmyz.sh

# Update homebrew
echo "Updating homebrew..."
brew update

# Upgrade homebrew recipes
echo "Upgrading homebrew packages..."
brew upgrade


# Tap Homebrew Cask
# echo "Installing homebrew cask"
# brew tap homebrew/cask-cask

echo "Installing Git..."
brew install git

# echo "Git config"
# git config --global user.name "Emmanuel"
# git config --global user.email emmanuel.stroem@gmail.com


echo "Installing brew git utilities..."
git_apps=(
  git-extras
  legit
  git-flow
  git-secrets
)
brew install --force ${git_apps[@]}

echo "Installing Language packages..."
languages=(
  elixir
  erlang
  go
  node
  rust
  openjdk
)
brew install --force ${languages[@]}

# Link OpenJDK
brew link --force openjdk

# Add OpenJDK to zsh
if [ -d '/usr/local/opt/openjdk' ]
then
  grep -qxF '# The next line adds PATH for the OpenJDK.' $HOME/.zshrc || echo '# The next line adds PATH for the OpenJDK.' >> $HOME/.zshrc
  grep -qxF 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' $HOME/.zshrc || echo 'export PATH="/usr/local/opt/openjdk/bin:$PATH"' >> $HOME/.zshrc
fi

echo "Installing Basic packages..."
basic_packges=(
  circleci
  dive
  vault
  vegeta
)
brew install --force ${basic_packges[@]}

echo "Installing other brew stuff..."
extra_apps=(
  axel
  brew-cask-completion
  bash-completion
  fzf
  glances
  gpg
  imagemagick
  lsof
  mas
  qrencode
  pre-commit
  rats
  rectangle
  tor
  tree
  tig
  tmux
  wget
)
brew install --force ${extra_apps[@]}

# Apps
base_apps=(
  1password
  alfred
  aerial
  dash
  dropbox
  evernote
  firefox
  flycut
  github
  gitkraken
  google-chrome
  google-backup-and-sync
  iterm2
  nordvpn
  postman
  selfcontrol
  slack
  spotify
  skype
  tor-browser
  visual-studio-code
  vlc
)

echo "installing apps with Cask..."
brew install --cask --force --appdir="/Applications" ${base_apps[@]}

echo "Brew Cleanup..."
brew cleanup

echo "Please setup and sync Dropbox."
# read -p "Press [Enter] key after this..."

echo "Setting some Mac settings..."

#"Disabling system-wide resume"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

#"Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

#"Allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

#"Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

#"Disabling OS X Gate Keeper"
#"(You'll be able to install any app you want from here on, not just Mac App Store apps)"
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

#"Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

#"Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

#"Saving to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#"Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Disable smart quotes and smart dashes as they are annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

#"Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

#"Disabling press-and-hold for keys in favor of a key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

#"Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

#"Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

#"Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

#"Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#"Use column view in all Finder windows by default"
defaults write com.apple.finder FXPreferredViewStyle Clmv

#"Avoiding the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#"Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

#"Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

#"Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

#"Setting Dock to auto-hide and removing the auto-hiding delay"
# defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

#"Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#"Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

#"Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#"Disable the sudden motion sensor as its not useful for SSDs"
sudo pmset -a sms 0

#"Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

#"Disable annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

#"Setting screenshots location to ~/Desktop"
defaults write com.apple.screencapture location -string "$HOME/Desktop"

#"Setting screenshot format to PNG"
defaults write com.apple.screencapture type -string "png"

#"Hiding Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false

#"Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

#"Disabling Safari's thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

#"Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

#"Making Safari's search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

#"Removing useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

#"Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

#"Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

#"Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

#"Use `~/Downloads/Incomplete` to store incomplete downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"

#"Don't prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false

#"Trash original torrent files"
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

#"Hide the donate message"
defaults write org.m0k.transmission WarningDonate -bool false

#"Hide the legal disclaimer"
defaults write org.m0k.transmission WarningLegal -bool false

#"Disable 'natural' (Lion-style) scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# SystemUIServer
############
# Show Bluetooth and Volume icons in Menu Bar
defaults write com.apple.systemuiserver menuExtras '
(
    "/System/Library/CoreServices/Menu Extras/AirPort.menu",
    "/System/Library/CoreServices/Menu Extras/Battery.menu",
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu",
    "/System/Library/CoreServices/Menu Extras/Clock.menu",
    "/System/Library/CoreServices/Menu Extras/Displays.menu",
    "/System/Library/CoreServices/Menu Extras/Volume.menu"
)'

# Restart SystemUIServer
killall SystemUIServer

# Disable Guest Login
# defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Trackpad: enable tap to click for this user and for the login screen
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Terminal
############
# Quit once finished
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Set default display settings of Terminal
plutil -replace Window\ Settings.Pro.rowCount -integer 32 ~/Library/Preferences/com.apple.Terminal.plist
plutil -replace Window\ Settings.Pro.columnCount -integer 118 ~/Library/Preferences/com.apple.Terminal.plist

# iTerm2
############
# Don’t display the quitting prompt
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# Finder
############
# Show Status Bar
defaults write com.apple.finder ShowStatusBar -bool true
# Add Quit option
# defaults write com.apple.finder QuitMenuItem -bool true; killall Finder
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# DOCK
###########
# Set Dock Icon sizes between 0 and 100, 0 - default
defaults write com.apple.dock tilesize -int 20 && killall Dock

# ScreenSaver
#############
# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Firewall
#############
# Enable
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
# Restart Firewall
sudo launchctl unload /System/Library/LaunchDaemons/com.apple.alf.agent.plist
sudo launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist

echo "Base: DONE!"
