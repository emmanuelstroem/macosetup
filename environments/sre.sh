#! /bin/bash
set -ex

sh ./environments/base.sh

echo "SRE Setup"

echo "Installing SRE packages..."
sre_packages=(
  ansible
  ansible-lint
  awscli
  azure-cli
  bats
  circleci
  derailed/k9s/k9s
  doctl
  drone-cli
  helm
  helmfile
  krew
  kind
  kompose
  kops
  kubeaudit
  kubernetes-cli
  kubernetes-helm
  kustomize
  kubectx
  kubebuilder
  kube-aws
  kubespy
  lxc
  lynis
  minikube
  nomad
  operator-sdk
  pumba
  pulumi
  salt
  skaffold
  sonobuoy
  terraform
  terraformer
  terraform-docs
  aquasecurity/trivy/trivy
  velero
  vault
)
brew install --force  ${sre_packages[@]}

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
)

# Objective-See Apps
objective_see=(
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
brew cask install --force --appdir="/Applications" ${apps[@]}

# objective-see
# brew cask install --force --appdir="/Applications" ${objective_see[@]}

# Add GCP SDK PATH
echo "Add Google Cloud SDK to .zshrc"

if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]
then
  grep -qxF '# The next line updates PATH for the Google Cloud SDK.' $HOME/.zshrc || echo '# The next line updates PATH for the Google Cloud SDK.' >> $HOME/.zshrc
  grep -qxF 'source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' $HOME/.zshrc || echo 'source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc\n' >> $HOME/.zshrc
fi

if [ -f '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]
then
  grep -qxF '# The next line updates PATH for the Google Cloud SDK.' $HOME/.zshrc || echo '# The next line updates PATH for the Google Cloud SDK.' >> $HOME/.zshrc
  grep -qxF 'source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' $HOME/.zshrc || echo 'source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc\n' >> $HOME/.zshrc
fi


# Clean up
brew cleanup

killall Finder

echo "DONE!"