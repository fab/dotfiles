# ----------------------------------------------------------------------
#  TERMINAL PROMPT
# ----------------------------------------------------------------------

BLACK="\[\033[0;30m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
DEFAULT="\[\033[0;00m\]"

function parse_git_branch {
 ref=$(git symbolic-ref HEAD 2> /dev/null) || return
 echo "("${ref#refs/heads/}")"
}

export PS1="$RED\$(date '+%I:%M:%S %p') $YELLOW\w$GREEN \$(parse_git_branch)$DEFAULT\$ "

# ----------------------------------------------------------------------
#  PATH
# ----------------------------------------------------------------------

# Add binaries
export PATH="/usr/local/bin:$PATH"

# Add rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Add Heroku
export PATH="/usr/local/heroku/bin:$PATH"

# ----------------------------------------------------------------------
# NAVIGATION
# ----------------------------------------------------------------------

# Jump plugin
# Instructions on use: http://bit.ly/1cLyE9Q
export MARKPATH=$HOME/.marks

function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark {
    rm -i "$MARKPATH/$1"
}

function marks {
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -exec basename {} \;)
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark

# Shortcuts
alias dv="jump dev"
alias dot="jump dot"

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Open files and directories
alias o="open"
alias oo="open ."

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# Always use color output for `ls`
alias ls="ls -G"

# Additional ls aliases
alias ll="ls -l"
alias l.="ls -d .*"

# ----------------------------------------------------------------------
# OTHER ALIASES
# ----------------------------------------------------------------------

alias fn='find . -name'
alias hi='history | tail -20'
alias ghub='hub browse'
alias be='bundle exec'

# ----------------------------------------------------------------------
# MISC
# ----------------------------------------------------------------------

# Make symlinking easier
link() {
  from="$1"
  to="$2"
  echo "Linking '$from' to '$to'"
  rm -f "$to"
  ln -s "$from" "$to"
}

# Include git completion script
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Bring external API keys into ENV
source ~/.apikeys

# Tab completition for Travis gem
[ -f /Users/Fab/.travis/travis.sh ] && source /Users/Fab/.travis/travis.sh
