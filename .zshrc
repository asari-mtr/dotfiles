# users generic .zshrc file for zsh(1)

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zaw"

zplug "willghatch/zsh-cdr"

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug "kutsan/zsh-system-clipboard"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

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

#
# Show branch name in Zsh's right prompt
#

setopt prompt_subst
setopt transient_rprompt

# Customize spaceship
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  battery       # Battery level and status
  exec_time     # Execution time
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  line_sep      # Line break
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=(
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubecontext   # Kubectl context section
  terraform     # Terraform workspace section
)
SPACESHIP_BATTERY_THRESHOLD=20
SPACESHIP_EXIT_CODE_SHOW=true


# command correct edition before each completion attempt
#
setopt correct


# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

# show git status or ls
function _show_git_status_or_ls {
  if [[ -e ".git" ]] {
    git status -s -b && git stash list && git diff master... --stat && this_branch_on_master
  } else {
    ls -a
  }
  echo
  echo
  zle reset-prompt
}
zle -N show_git_status_or_ls _show_git_status_or_ls

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -v
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
bindkey -s "]sz" "source ~/.zshrc\n"

bindkey -s "dc" "docker-compose"

bindkey " gg" "show_git_status_or_ls"

bindkey '^h' 'zaw-history'

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
fpath=(/usr/local/share/zsh-completions ~/.zsh/completion $fpath)
autoload -Uz compinit
compinit -i
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

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

alias j="jobs -l"
alias h="history 1"

alias la="ls -aF"
alias lf="ls -F"
alias ll="ls -al"

alias less="less -R"

alias du="du -h"
alias df="df -h"

alias su="su -l"

# alias -g L='| less'
# alias -g H='| head'
# alias -g T='| tail'
# alias -g G='| grep'
# alias -g W='| wc'
# alias -g S='| sed'
# alias -g A='| awk'
# alias -g W='| wc'
# alias -g X='| xargs'
# alias -g XG='| xargs grep'
#
# alias -g R='| xargs grep'
#
# alias -g GB='`git branch -a | peco --prompt "GIT BRANCH" | head -n 1 | sed -e "s/^\*\s*//g"`'
alias chbranch="git branch | grep -v '\*.*' | peco | awk '{print $1}' | xargs git checkout"
alias gibol='gibo -l | sed "/=/d" | tr "\t", "\n" | sed "/^$/d" | sort | peco | xargs gibo'
alias gack="git ls-files -oc --exclude-standard | ack -x . | peco"
alias vimt='vim -c NERDTree'
alias ja="LANG=C grep -n -v '^[[:cntrl:][:print:]]*$'"

alias d='docker'
alias dc='docker-compose'
alias dnt='docker container'
alias dcur='docker container ls -f status=running -l -q'
alias dexec='docker container exec -it $(dcur)'
alias dimg='docker image'
alias drun="docker container run --rm -it -v ${PWD}:/tmp/work -w /tmp/work"
alias drund="docker container run --rm -d"
alias dstop='docker container stop $(dcur)'

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

alias -g T='| translate -t ja'
alias -g TJ='| translate -t ja'
alias -g TE='| translate -s ja -t en'
alias -g TTJ='| tee >(translate -t ja)'
alias -g TTE='| tee >(translate -s ja -t en)'
alias -g TT='TJ TTE'
alias -g Tt='TE TTJ'

alias -g O='| xargs -I{} printf '%s\0' {} | xargs -0 open'

## terminal configuration
#
case "${TERM}" in
xterm|xterm-color|xterm-256color)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
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

# beep
setopt no_beep
setopt no_list_beep

# cdr
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

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

# function zshaddhistory() {
#   emulate -L zsh
#   # ignore howodoi command
#   if [[ $1 = "howdoi "* || $1 = "dasht "* || $1 = "echo "* ]] ; then
#       return 1
#   else
#       print -sr -- "${1%%$'\n'}"
#       fc -p
#   fi
# }


# gem
export EDITOR=nvim

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
