#! /bin/bash
set -ex

sh base.sh

echo "MobileDev Setup"

echo "Installing Mobile Dev packages..."
brew install bluepill
brew install detekt

# Install Xcode
mas install 497799835

# Install Apple COnfigurator 2
mas install 1037126344

# Apps
apps=(
  android-platform-tools
  android-sdk
  android-studio
  bitrise
  cocoapods
  fastlane
  kotlin-native
  unity-android-support-for-editor
  wwdc
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

brew cleanup

killall Finder

echo "DONE!"