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
  # wait for background task to finish
  if ps -p $! >&-
  then
    wait $!
    echo "ZSH is now installed . . . "
  else
    echo "ZSH installing..."
  fi
fi

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
function activate_p10k() {
  if [ -f "$HOME/.p10k.zsh" ]
  then
    grep -qxF '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' $HOME/.zshrc || echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >> $HOME/.zshrc
    grep -qxF '[[ ! -f "$HOME/.p10k.zsh" ]] || source '~/.p10k.zsh'' $HOME/.zshrc || echo '[[ ! -f "$HOME/.p10k.zsh" ]] || source '$HOME/.p10k.zsh'' >> $HOME/.zshrc
  fi
}

function copy_p10k() {
  echo "Add .p10k.zsh"
  cp ./dotfiles/.p10k.zsh $HOME/

  # activate powerlevel
  activate_p10k
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

function install_zsh_highlighting_git() {
  if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]
  then
    echo "ZSH Syntax Highlighing already exists"
    git -C $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull origin master
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  fi
}

function install_zsh_highlighting() {

  if [ "$1" = "brew" ] # install from brew
  then
    if [ -d "/usr/local/share/zsh-syntax-highlighting" ]
    then
      echo "ZSH Syntax Highlighing already exists"
      brew upgrade zsh-syntax-highlighting
    else
      brew install --force zsh-syntax-highlighting
    fi
  elif [ "$1" = "git" ] # install from git
  then
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]
    then
      echo "ZSH Syntax Highlighing already exists"
      git -C $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting pull origin master
    else
      git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi
  fi

  add_zsh_highlighting $1

}

function add_zsh_highlighting() {
  if [ "$1" = "brew" ] # add brew install path
  then
    if [ -f "/usr/local/share/zsh-syntax-highlighting" ]
    then
      grep -qxF '# ZSH Hightlighting Folder.' $HOME/.zshenv || echo '# ZSH Hightlighting Folder.' >> $HOME/.zshenv
      grep -qxF 'export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters' $HOME/.zshenv || echo 'export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters' >> $HOME/.zshenv

      grep -qxF '# Activate the syntax highlighting.' $HOME/.zshrc || echo '# Activate the syntax highlighting.' >> $HOME/.zshrc
      grep -qxF 'source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'' $HOME/.zshrc || echo 'source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'' >> $HOME/.zshrc
    fi
  else
    echo "ZSH highlighting is all set!"
  fi
}


function install_zsh_suggestions() {
  if [ "$1" = "brew" ] # install from brew
  then
    if [ -d "/usr/local/share/zsh-autosuggestions" ]
    then
      echo "ZSH Syntax Highlighing already exists"
      brew upgrade zsh-autosuggestions
    else
      brew install --force zsh-autosuggestions
    fi
  elif [ "$1" = "git" ] # install from git
  then
    if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]
    then
      echo "ZSH Autosuggestions already exists"
      git -C $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions pull origin master
    else
      git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi
  fi

  add_zsh_suggestions $1
}

function add_zsh_suggestions() {
  if [ "$1" = "brew" ] # add brew install path
  then
    if [ -f "/usr/local/share/zsh-autosuggestions" ]
    then
      grep -qxF '# Activate the zsh-utosuggestions (may cause slow loading in terminal).' $HOME/.zshrc || echo '# Activate the zsh-utosuggestions (may cause slow loading in terminal).' >> $HOME/.zshrc
      grep -qxF 'source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'' $HOME/.zshrc || echo 'source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'' >> $HOME/.zshrc
    fi
  else
    echo "ZSH Autosuggestions is all set!"
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

echo "Setting up Zsh plugins..."
# Syntax Highlighting
install_zsh_highlighting "brew"

# Auto Suggestions
install_zsh_suggestions "brew"

# Fix permissions on usr/local/share/zsh
compaudit | xargs chmod g-w,o-w /usr/local/share/zsh

echo "Setting ZSH as shell..."
# chsh -s /bin/zsh