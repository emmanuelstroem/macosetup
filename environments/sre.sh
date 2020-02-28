#! /bin/bash
set -ex

sh ./environments/base.sh

echo "SRE Setup"

echo "Installing SRE packages..."
brew install ansible
brew install ansible-lint
brew install awscli
brew install azure-cli
brew install bats
brew install circleci
brew install derailed/k9s/k9s
brew install doctl
brew install drone-cli
brew install helm
brew install helmfile
brew install krew
brew install kind
brew install kompose
brew install kops
brew install kubeaudit
brew install kubernetes-cli
brew install kubernetes-helm
brew install kustomize
brew install kubectx
brew install kubebuilder
brew install kube-aws
brew install kubespy
brew install lxc
brew install lynis
brew install minikube
brew install nomad
brew install operator-sdk
brew install pumba
brew install pulumi
brew install salt
brew install skaffold
brew install sonobuoy
brew install terraform
brew install terraformer
brew install terraform-docs
brew install aquasecurity/trivy/trivy
brew install velero
brew install vault

# Install kpt
brew tap GoogleContainerTools/kpt https://github.com/GoogleContainerTools/kpt.git
brew install kpt

# Install KeyKey
mas install 1035137927

echo "Cleaning up brew"
brew cleanup

# Apps
apps=(
  alfred
  aerial
  aws-vault
  boom-3d
  google-cloud-sdk
  keybase
  kubecontext
  kubernetic
  wireshark
)
# Objective-See
objective-see=(
  blockblock
  do-not-disturb
  lulu
  malwarebytes
  oversight
  ransomwhere
  reikey
)
# IntelliJ
intellij=(
  datagrip
  pycharm
  jetbrains-toolbox
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}
# objective-see
brew cask install --appdir="/Applications" ${objective-see[@]}
# Clean up
brew cleanup

killall Finder

echo "DONE!"