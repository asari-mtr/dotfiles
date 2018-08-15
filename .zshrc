# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac

# proxy
if [ -f ~/.zshrc.proxy ]; then
    source ~/.zshrc.proxy
fi

# ssh-agent
function keyadd {
    eval $(ssh-agent)
    ssh-add -l > /dev/null
    if [ 1 -eq $? ]
    then
        echo "ssh key add"
        ssh-add ~/.ssh/id_rsa
    fi
}
export keyadd

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    ;;
*)
    PROMPT="%{${fg[red]}%}>%{${fg[green]}%}>%{${fg[yellow]}%}>%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}-%{${fg[green]}%}-%{${fg[yellow]}%}>%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# command correct edition before each completion attempt
#
setopt correct


# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep


## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete

bindkey -s "]vv" "!vi\n"
bindkey -s "]bb" "bundle install\n"
bindkey -s " gg" "gits\n"
bindkey -s "]sz" "source ~/.zshrc\n"

## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
#setopt hist_ignore_all_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt hist_ignore_space    # ignore head space begin command
setopt inc_append_history

## Completion configuration
#
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit
typeset -U fpath
# zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
#    /usr/sbin /usr/bin /bin /bin /usr/X11R6/bin /usr/local/git/bin


## zsh editor
#
autoload zed
setopt brace_ccl

## Prediction configuration
#
#autoload predict-on
#predict-off


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"
alias h="history 1"

case "${OSTYPE}" in
freebsd*)
    alias ls="ls -G -w"
    ;;
darwin*)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac

alias la="ls -aF"
alias lf="ls -F"
alias ll="ls -al"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g W='| wc'
alias -g S='| sed'
alias -g A='| awk'
alias -g W='| wc'
alias -g X='| xargs'
alias -g XG='| xargs grep'

alias tmux="tmux -2"
alias gits="git status -s -b && git stash list && git diff master... --stat && this_branch_on_master"
alias chbranch="git branch | grep -v '\*.*' | peco | awk '{print $1}' | xargs git checkout"
alias gibol='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | peco | xargs gibo'
alias gack="git ls-files -oc --exclude-standard | ack -x . | peco"
alias vimt='vim -c NERDTree'

alias -s c='vim'
alias -s h='vim'
alias -s coffee='vim'
alias -s config='vim'
alias -s cs='vim'
alias -s html='vim'
alias -s java='vim'
alias -s js='vim'
alias -s less='vim'
alias -s rb='vim'
alias -s sbt='vim'
alias -s scala='vim'
alias -s txt='vim'
alias -s md='vim'
alias -s xml='vim'
alias -s zsh='zsh'
alias -s zshrc='vim'
alias -s vimrc='vim'

## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm|xterm-color)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine
[ -f ${HOME}/.zshrc.secret ] && source ${HOME}/.zshrc.secret

# This loads RVM into a shell session.
[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"  

## custom zsh file
[ -d ${HOME}/.zsh ] && source ${HOME}/.zsh/*.zsh


# Changing Directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# History
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_space    # ignore head space begin command
setopt inc_append_history
setopt share_history        # share command history data

# bindkey
bindkey -e

# Prompting
setopt prompt_subst
setopt transient_rprompt

# beep
setopt no_beep
setopt no_list_beep

# Completion
setopt list_packed

case "${OSTYPE}" in
# Mac(unix)
darwin*)
    [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
    ;;
# linux
linux*)
    [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
    ;;
esac

# npm completion
# . <(npm completion)

# pathの重複を解決
#typeset -U path

export GROOVY_HOME=/usr/local/opt/groovy/libexec

export NODE_PATH=/usr/local/lib/node_modules

# dasht
export PATH=~/workspace/dasht/bin:$PATH
export MANPATH=~/workspace/dasht/man:$MANPATH
source ~/workspace/dasht/etc/zsh/completions.zsh

# rbenv
if type "rbenv" > /dev/null 2>&1 ; then
  eval "$(rbenv init -)"
fi

# python
export PYENV_ROOT="$HOME/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# git
function this_branch_on_master {
  if [[ `git log ..origin/master --oneline | wc -l`  -ne 0 ]]; then
    echo "${fg[yellow]}Recomended to rebase${reset_color}"
  fi
}

# history
function history-all { history -E 1 }
# man
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:/usr/share/man:/usr/local/share/man/ja:/usr/local/share/man:/opt/X11/share/man

# gem
export EDITOR=vim
