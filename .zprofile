echo "load ~/.zprofile"

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$HOME/sbin:$PATH"

# Ansible
export PATH="/usr/local/opt/ansible@2.0/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# rbenv
if type "rbenv" > /dev/null 2>&1 ; then
  eval "$(rbenv init -)"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# scalenv
export PATH="${HOME}/.scalaenv/bin:${PATH}"
eval "$(scalaenv init -)"

# dasht
export PATH=~/workspace/dasht/bin:$PATH
export MANPATH=~/workspace/dasht/man:$MANPATH
if [ -f ~/workspace/dasht/bin ]; then
  source ~/workspace/dasht/etc/zsh/completions.zsh
fi

# pathの重複を解決
typeset -U path
