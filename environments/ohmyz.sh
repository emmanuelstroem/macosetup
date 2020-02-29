#! /bin/bash
set -ex

#Install Zsh & Oh My Zsh
if [ -d $HOME/.oh-my-zsh ]
then
  echo "ZSH already exists"
else
  echo "Installing oh-my-zsh"
  curl -s https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | /bin/bash -s >/dev/null 2>&1
fi

echo "Setting up PowerLevel10k..."
if [ -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]
then
  echo "powerlevel10k  already cloned"
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom//themes/powerlevel10k
fi

# Tap nerd-font cask
brew tap homebrew/cask-fonts

# Install nerd fonts
brew cask install font-hack-nerd-font
brew cask install font-meslo-nerd-font

# add gitconfig
function add_gitconfig() {
  echo "Add .gitconfig"
  cp ./dotfiles/.gitconfig $HOME/
}

# add zshrc
function add_zshrc() {
  echo "Add .zshrc"
  cp ./dotfiles/.zshrc $HOME/
}

# add powerlevel
function add_p10k() {
  echo "Add .p10k.zsh"
  cp ./dotfiles/.p10k.zsh $HOME/
}

# Gitconfig
if [! -f $HOME/.gitconfig]
then
  add_gitconfig
else
  read -r -p 'Overwrite ~/.gitconfig file ? (y/n) : ' overwrite_gitconfig
  if [ "$overwrite_gitconfig" = "y" ]
  then
    add_gitconfig
  fi
fi

# zshrc
if [! -f $HOME/.zshrc]
then
  add_gitconfig
else
  read -r -p 'Overwrite ~/.zshrc file ? (y/n) : ' overwrite_zshrc
  if [ "$overwrite_zshrc" = "y" ]
  then
    add_zshrc
  fi
fi

# powerlevel10k
if [! -f $HOME/.p10k.zsh]
then
  add_p10k
else
  read -r -p 'Overwrite ~/.p10k.zsh file ? (y/n) : ' overwrite_p10k
  if [ "$overwrite_p10k" = "y" ]
  then
    add_p10k
  fi
fi

# echo "Add aliases"

# Setup PowerLevel10K
if [ -f '$HOME/.p10k.zsh' ]; then
  grep -qxF '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' $HOME/.zshrc || echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >> $HOME/.zshrc
  grep -qxF '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' $HOME/.zshrc || echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh\n' >> $HOME/.zshrc
fi

echo "Setting up Zsh plugins..."
# Syntax Highlighting
brew install zsh-syntax-highlighting

if [ -f '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then
  grep -qxF '# The next line loads zsh-syntax-highlighting.' $HOME/.zshrc || echo '# The next line loads zsh-syntax-highlighting.' >> $HOME/.zshrc
  grep -qxF 'source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'' $HOME/.zshrc || echo 'source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'\n' >> $HOME/.zshrc
fi

# git clone git@git://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# Auto Suggestions
brew install zsh-autosuggestions

if [ -f '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then
  grep -qxF '# The next line loads zsh-autosuggestions.' $HOME/.zshrc || echo '# The next line loads zsh-autosuggestions.' >> $HOME/.zshrc
  grep -qxF 'source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'' $HOME/.zshrc || echo 'source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'\n' >> $HOME/.zshrc
fi
# git clone git@git://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Setting ZSH as shell..."
# chsh -s /bin/zsh