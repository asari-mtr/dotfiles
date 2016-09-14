function peco-snippets() {
    BUFFER=$(grep -h -v "^#*$" ~/dotsnippets/* | peco --query "$LBUFFER" | awk -F '::' '{print $1}')
    zle clear-screen
}

zle -N peco-snippets
bindkey '^]' peco-snippets
