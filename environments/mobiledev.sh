#! /bin/bash
set -ex

sh ./environments/base.sh

echo "MobileDev Setup"

echo "Installing Mobile Dev packages..."
brew install bluepill
brew install detekt

# Install Xcode
read -r -p 'Download Xcode (might be bandwidth hungry) ? (Y/n) : ' download_xcode
if [ "$download_xcode" = "" ] || [ "$download_xcode" = "y" ] || [ "$download_xcode" = "Y" ] || [ "$download_xcode" = "yes" ]
then
  mas install --force 497799835
else
  mas install 497799835
fi


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
  wwdc
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew install --cask --appdir="/Applications" ${apps[@]}

brew cleanup

killall Finder

echo "DONE!"