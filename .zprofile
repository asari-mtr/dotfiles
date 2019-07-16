export PATH="./bin:/usr/local/bin:/usr/local/sbin:$PATH"

# anyenv
if [[ -e $HOME/.anyenv/bin/anyenv ]] {
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
}

# Ansible
export PATH="/usr/local/opt/ansible@2.0/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# dasht
export PATH=~/workspace/dasht/bin:$PATH
export MANPATH=~/workspace/dasht/man:$MANPATH
if [ -f ~/workspace/dasht/bin ]; then
  source ~/workspace/dasht/etc/zsh/completions.zsh
fi

export PATH="$HOME/bin:$HOME/sbin:$PATH"

# pathの重複を解決
typeset -U path
