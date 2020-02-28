#! /bin/bash
set -ex

#Install Zsh & Oh My Zsh
if test ! $(which zsh); then
  echo "Installing Oh My ZSH..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


echo "Setting up PowerLevel10k..."
if [ -d $HOME/.oh-my-zsh/custom//themes/powerlevel10k ]
then
  echo "powerlevel10k  already cloned"
else
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom//themes/powerlevel10k
fi

if [! -f $HOME/.gitconfig]
then
  echo "Add .gitconfig"
  cp ./dotfiles/.gitconfig $HOME/
fi

if [! -f $HOME/.zshrc]
then
  echo "Add .zshrc"
  cp ./dotfiles/.zshrc $HOME/
fi

if [! -f $HOME/.p10k.zsh]
then
  echo "Add .p10k.zsh"
  cp ./dotfiles/.p10k.zsh $HOME/
fi

# echo "Add aliases"

# Setup PowerLevel10K
if [ -f '$HOME/.p10k.zsh' ]; then
  grep -qxF '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' $HOME/.zshrc || echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >> $HOME/.zshrc
  grep -qxF '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' $HOME/.zshrc || echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> $HOME/.zshrc
fi

echo "Setting up Zsh plugins..."
# Syntax Highlighting
brew install zsh-syntax-highlighting

if [ -f '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then
  grep -qxF '# The next line loads zsh-syntax-highlighting.' $HOME/.zshrc || echo '# The next line loads zsh-syntax-highlighting.' >> $HOME/.zshrc
  grep -qxF 'source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'' $HOME/.zshrc || echo 'source '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'' >> $HOME/.zshrc
fi

# git clone git@git://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# Auto Suggestions
brew install zsh-autosuggestions

if [ -f '/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' ]; then
  grep -qxF '# The next line loads zsh-autosuggestions.' $HOME/.zshrc || echo '# The next line loads zsh-autosuggestions.' >> $HOME/.zshrc
  grep -qxF 'source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'' $HOME/.zshrc || echo 'source '/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh'' >> $HOME/.zshrc
fi
# git clone git@git://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

echo "Setting ZSH as shell..."
# chsh -s /bin/zsh