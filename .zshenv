# proxy
if [[ -e ~/.zshrc.proxy ]] {
  source ~/.zshrc.proxy
}

if [[ -z $ZSHENV_LOAD ]] {
  export ZSHENV_LOAD="1"

  export TZ=Asia/Tokyo
  export LANG=ja_JP.UTF-8

  # for ptyhon
  export LC_ALL='ja_JP.UTF-8'

  # node
  export NODE_PATH=/usr/local/lib/node_modules

  # man
  export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:/usr/share/man:/usr/local/share/man/ja:/usr/local/share/man:/opt/X11/share/man

  # java
  export JAVA_HOME=`/usr/libexec/java_home`
  export _JAVA_OPTIONS="-Xms128m -Xmx256m -Dfile.encoding=UTF-8"

  # proxy
  if [[ -e ~/dotfiles/.zshenv.local ]] {
    source ~/dotfiles/.zshenv.local
  }
}
