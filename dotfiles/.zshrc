# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set Default User for cleaner shell
DEFAULT_USER=$(whoami)

HOSTNAME='devbox'

DISABLE_AUTO_TITLE="true"

window_title="\033]0; $HOSTNAME -> ${PWD##*/}\007"
echo -ne "$window_title"
function chpwd () {
  window_title="\033]0;$HOSTNAME -> ${PWD##*/}\007"
  echo -ne "$window_title"
}

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_MODE="awesome-patched"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  kubectl
  gcloud
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Environment Variables
export PATH=/Applications/Postgres.app/Contents/Versions/12/bin:$PATH

# Aliases
alias axel="axel -k -n 20"
alias zshconfig="code ~/.zshrc"

# Do NOT add wrong commands to History
zshaddhistory() {
    whence ${${(z)1}[1]} >| /dev/null || return 1
}

# Ignore Commands from History
HISTORY_IGNORE='([bf]g *|cd *|cd|ls|ls *|l[alsh]#( *)#|tail *|less *|more *||vim# *|axel|axel *|code|code *|exit|pwd|rm *|mv *|cp *|history|history *|mas *|brew *|)'

# Ignore Duplicates
HISTSIZE=10000000
SAVEHIST=10000000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# ZSH History Timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  "") alias history='omz_history' ;;
  *) alias history="omz_history -t '$HIST_STAMPS'" ;;
esac

