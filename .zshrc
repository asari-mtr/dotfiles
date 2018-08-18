# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
case ${UID} in
0)
    LANG=C
    ;;
esac

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
    PROMPT="%{${fg[green]}%}$%{${fg[yellow]}%}$%{${fg[red]}%}$%{${reset_color}%} "
    PROMPT="%{${fg[green]}%}→ %{${fg[red]}%}%C%{${fg[red]}%}$%{${reset_color}%} "
    PROMPT2="%{${fg[green]}%}-%{${fg[yellow]}%}-%{${fg[red]}%}>%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

#
# Show branch name in Zsh's right prompt
#

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
    color=%F{red}
  fi

  echo "$color$name$action%f%b "
}
setopt prompt_subst
RPROMPT='[`rprompt-git-current-branch`%~]'

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
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups     # ignore duplication command history list
setopt hist_ignore_space    # ignore head space begin command
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history
setopt share_history        # share command history data


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
xterm|xterm-color|xterm-256color)
    export LSCOLORS=gxfxcxdxbxegedabagacad
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

## custom zsh file
[ -d ${HOME}/.zsh ] && source ${HOME}/.zsh/*.zsh

# Changing Directories
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Prompting
setopt prompt_subst
setopt transient_rprompt

# beep
setopt no_beep
setopt no_list_beep

# Completion
setopt list_packed

## load user .zshrc configuration file
#
[ -f ${HOME}/dotfiles/.zshrc.local ] && source ${HOME}/dotfiles/.zshrc.local

# git
function this_branch_on_master {
  if [[ `git log ..origin/master --oneline | wc -l`  -ne 0 ]]; then
    echo "${fg[yellow]}Recomended to rebase${reset_color}"
  fi
}

# history
function history-all { history -E 1 }

# gem
export EDITOR=vim

case "${OSTYPE}" in
# Mac(unix)
darwin*)
    [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
    ;;
# linux
linux*)
    [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
    ;;
# Freebsd
freebsd*)
    [ -f ~/dotfiles/.zshrc.bsd ] && source ~/dotfiles/.zshrc.bsd
    ;;
esac
