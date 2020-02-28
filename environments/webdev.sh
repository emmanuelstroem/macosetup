#! /bin/bash
set -ex

sh ./environments/base.sh

echo "WebDev Setup"

echo "Installing FrontEnd packages..."
brew install angular-cli
brew install apollo-cli
brew install coffeescript
brew install eslint
brew install gatsby-cli
brew install grunt-cli
brew install grunt-completion
brew install hugo
brew install jsonlint
brew install jsonnet
brew install jsonpp
brew install markdown
brew install prettier
brew install php
brew install react-native-cli
brew install yarn
brew install yarn-completion
brew install webpack

brew install numpy
brew install pyenv
brew install pyenv-virtualenv
brew install pyenv-virtualenvwrapper
brew install pylint
brew install jupyterlab



#@TODO install our custom fonts and stuff

echo "Cleaning up brew"
brew cleanup


echo "Vue it up"
npm install -g @vue/cli
npm install -g bulma

# Apps
apps=(
  electron
  googleappengine
  graphiql
  react-native-debugger
  sublime-text
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

brew cleanup

killall Finder

echo "DONE!"
