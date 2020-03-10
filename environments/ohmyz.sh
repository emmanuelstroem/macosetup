#! /bin/bash
set -ex

# Variable
DOTFILES_DIR="$PWD/dotfiles"

# Setup Powerlevel
function setup_powerlevel() {
  echo "Setting up PowerLevel10k..."
  if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]
  then
    echo "powerlevel10k  already cloned. Updating it . .. "
    git -C $HOME/.oh-my-zsh/custom/themes/powerlevel10k pull origin master
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
  echo "ZSH already exists, Updating it..."
  if [ -f "$HOME/.oh-my-zsh/tools/upgrade.sh" ]
  then
    upgrade_oh_my_zsh
  fi
  setup_powerlevel
else
  echo "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &
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
brew cask install font-hack-nerd-font font-meslo-nerd-font
# brew cask install font-meslo-nerd-font

# Add Dotfiles
function add_dotfiles() {
  if [ -d "$DOTFILES_DIR" ]
  then
    for config in $DOTFILES_DIR/.*
    do
      config_name="${config#"$PWD/dotfiles/"}"
      if valid_config $config
      then
        if [ ! -f "$HOME/$config_name" ]
        then
          # copy config
          copy_config_to_home_dir $config
        else
          # overwrite config
          overwrite_config_in_home_dir $config
        fi
      else
        # config is not valid
        continue
      fi
    done
    # # activate config
    activate_dotfile_config $config
  else
    echo "./dotfiles does not exist. Clone it or create it and try again"
  fi
}

# Copy dotfile to home
function copy_config_to_home_dir() {
  echo "Copying $1"
  cp $DOTFILES_DIR/$1 $HOME/$1
}

# overwrite dotfile confirmation
function overwrite_config_in_home_dir() {
  read -r -p "Overwrite ~/$1 file ? (Y/n) : " overwrite_config
  if [ "$overwrite_config" = "" ] || [ "$overwrite_config" = "y" ] || [ "$overwrite_config" = "Y" ] || [ "$overwrite_config" = "yes" ]
  then
    copy_config_to_home $1
  else
    echo "Skipping..."
  fi
}

function valid_config() {
  if [ -f "$1" ]
  then
    return 0 # 0 for true
  else
   return 1 # 1 for false
  fi
}

# activate dotfile configs
function activate_dotfile_config() {
  # Powerlevel10k
  if [ $1 = ".p10k.zsh" ] && [ -f "$HOME/.p10k.zsh" ]
  then
    grep -qxF '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' $HOME/.zshrc || echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >> $HOME/.zshrc
    grep -qxF '[[ ! -f "$HOME/.p10k.zsh" ]] || source '~/.p10k.zsh'' $HOME/.zshrc || echo '[[ ! -f "$HOME/.p10k.zsh" ]] || source '$HOME/.p10k.zsh'' >> $HOME/.zshrc
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

# dotfiles
add_dotfiles

echo "Setting up Zsh plugins..."
# Syntax Highlighting
install_zsh_highlighting "brew"

# Auto Suggestions
install_zsh_suggestions "brew"

# Fix permissions on usr/local/share/zsh
compaudit | xargs chmod g-w,o-w /usr/local/share/zsh

echo "Setting ZSH as shell..."
# chsh -s /bin/zsh