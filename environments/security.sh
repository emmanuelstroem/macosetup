
#! /bin/bash
set -ex

sh ./environments/base.sh

echo "Security Setup"

echo "Installing SRE packages..."
brew install aircrack-ng
brew install badtouch
brew install bettercap
brew install burp
brew install daemonlogger
brew install daq
brew install dnsmap
brew install dnsperf
brew install flawfinder
brew install hydra
brew install ipcalc
brew install john
brew install john-jumbo
brew install lynis
brew install ncrack
brew install nmap
brew install sniffglue
brew install snort
brew install sshtrix
brew insatll wifi-password
brew install wireshark


# Apps
apps=(
  angry-ip-scanner
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

brew cleanup

killall Finder


echo "DONE!"