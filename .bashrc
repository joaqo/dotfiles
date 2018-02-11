# Check computer type (it affects certain configurations)
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Virtualenv wrapper doesnt do this when you install it for some reason
export WORKON_HOME=~/.virtualenvs

# Save history after each command (to share history between windows)
export PROMPT_COMMAND='history -a'

# Expand size of bash history and dont save duplicate commands
export HISTSIZE=20000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups

# # Doesn't save history duplicates but kinda really really sucks
# export HISTSIZE=10000
# export HISTFILESIZE=10000
# export HISTCONTROL=ignoreboth:erasedups
# export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# Load certain scripts if in my mac
if [ ${machine} = Mac ]
then
    # Git official autocomplete
    source ~/Code/git-completion.bash
    # Git official prompt
    source ~/Code/git-prompt.sh
fi

# Configure prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\033[01;34m\]\h \[\033[00m\]\[\033[01;34m\]\w\[\033[00m\]\[\033[01;36m\]$(__git_ps1 " %s")\[\033[00m\]\[\033[01;31m\] > \[\033[00m\]'

# Vim default editor
export EDITOR='vim'

# Not sure what this is, maybe for man an the such?
export VISUAL='vim'

# Si no le agregaba la -t no me encontraba los .env que estuvieran
# a mas de dos directorios de distancia recursiva, what??!!
if [ ${machine} = Mac ]
then
export FZF_DEFAULT_COMMAND='ag -U --ignore={"*.pyc",".git"} --hidden -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# For cs231n course jupyter noteobook
# Delete ?
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Aliases
alias v='mvim -v'
alias mux="tmuxinator"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias gsb="git status -sb"
alias g="git"
alias l="ls -lhFG"
alias ls="ls -G"
alias callcito="/Applications/Call\ of\ Duty\ 2\ Multiplayer.app/Contents/MacOS/Call\ of\ Duty\ 2\ Multiplayer"

# Add files in ~/bin to path
PATH=$PATH:~/bin

# Fixes the following problem with brew
# https://github.com/Homebrew/homebrew-php/issues/4527#issuecomment-346483994
PATH=$PATH:/usr/local/sbin

# Add pyenv to path
PATH=~/.pyenv/shims:$PATH
PATH=~/.pyenv/bin:$PATH

# pipenv looks for this to integrate with pyenv
export PYENV_ROOT=~/.pyenv/

# activate current folder's virtualenv en pipenv
venv() {
source $(pipenv --venv)/bin/activate
}

workon() {
source ~/.virtualenvs/$1/bin/activate
}

mkvenv() {
cd ~/.virtualenvs
virtualenv "$@"
cd -
workon "$1"
}

httpj() {
http --pretty=format $1 | vim - -c 'set syntax=json' -c 'set foldmethod=syntax'
}

# Highlight folders on ls
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS
