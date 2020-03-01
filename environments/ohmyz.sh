#! /bin/bash
set -ex

# Setup Powerlevel
function setup_powerlevel() {
  echo "Setting up PowerLevel10k..."
  if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]
  then
    echo "powerlevel10k  already cloned"
  elif [ -d "$HOME/.oh-my-zsh" ]
  then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    clone_status=$?
    if [ -z "$clone_status" ]
    then
      echo "Update Powerlevel10k theme"
      git -C $HOME/.oh-my-zsh/custom/themes/powerlevel10k pull origin master
    fi
  fi
}

#Install Zsh & Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]
then
  echo "ZSH already exists"
  setup_powerlevel
else
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &
  if ps -p $! >&-
  then
    wait $!
    echo "ZSH is installing . . . "
  else
    echo "ZSH install finished"
  fi
fi
x
# Tap nerd-font cask
brew tap homebrew/cask-fonts

# Install nerd fonts
brew cask install font-hack-nerd-font
brew cask install font-meslo-nerd-font

# add gitconfig
function copy_gitconfig() {
  echo "Add .gitconfig"
  cp ./dotfiles/.gitconfig $HOME/
}

function add_gitconfig() {
  if [ ! -f "$HOME/.gitconfig" ]
  then
    copy_gitconfig
  else
    read -r -p 'Overwrite ~/.gitconfig file ? (Y/n) : ' overwrite_gitconfig
    if [ "$overwrite_gitconfig" = "" ] || [ "$overwrite_gitconfig" = "y" ] || [ "$overwrite_gitconfig" = "Y" ] || [ "$overwrite_gitconfig" = "yes" ]
    then
      copy_gitconfig
    fi
  fi
}

# add zshrc
function copy_zshrc() {
  echo "Add .zshrc"
  cp ./dotfiles/.zshrc $HOME/
}

function add_zshrc() {
  if [ ! -f "$HOME/.zshrc" ]
  then
    copy_zshrc
  else
    read -r -p 'Overwrite ~/.zshrc file ? (Y/n) : ' overwrite_zshrc
    if [ "$overwrite_zshrc" = "" ] || [ "$overwrite_zshrc" = "y" ] || [ "$overwrite_zshrc" = "Y" ] || [ "$overwrite_zshrc" = "yes" ]
    then
      copy_zshrc
    fi
  fi
}

# add powerlevel
function copy_p10k() {
  echo "Add .p10k.zsh"
  cp ./dotfiles/.p10k.zsh $HOME/
}

function add_p10k() {
  if [ ! -f "$HOME/.p10k.zsh" ]
  then
    copy_p10k
  else
    read -r -p 'Overwrite ~/.p10k.zsh file ? (Y/n) : ' overwrite_p10k
    if [ "$overwrite_p10k" = "" ] || [ "$overwrite_p10k" = "y" ] || [ "$overwrite_p10k" = "Y" ] || [ "$overwrite_p10k" = "yes" ]
    then
      copy_p10k
    fi
  fi
}

# Gitconfig
add_gitconfig

# zshrc
add_zshrc

# powerlevel10k
add_p10k

# setup powerlevel10k
setup_powerlevel

# echo "Add aliases"

# Setup PowerLevel10K
if [ -f "$HOME/.p10k.zsh" ]
then
  grep -qxF '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' $HOME/.zshrc || echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >> $HOME/.zshrc
  grep -qxF '[[ ! -f "$HOME/.p10k.zsh" ]] || source '~/.p10k.zsh'' $HOME/.zshrc || echo '[[ ! -f "$HOME/.p10k.zsh" ]] || source '$HOME/.p10k.zsh'' >> $HOME/.zshrc
fi

echo "Setting up Zsh plugins..."
# Syntax Highlighting
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]
then
  echo "ZSH Syntax Highlighing already exists"
  git -C $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull origin master
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

# Auto Suggestions
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
then
  echo "ZSH Autosuggestions already exists"
  git -C $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull origin master
else
  git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

echo "Setting ZSH as shell..."
# chsh -s /bin/zsh