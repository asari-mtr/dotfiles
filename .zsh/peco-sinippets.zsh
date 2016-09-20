function peco-snippets() {
    BUFFER=$(grep -h -v "^#*$" ~/dotsnippets/* | peco --query "$LBUFFER" | awk -F '::' '{print $1}' | sed -e 's/\[.*//')
    # zle clear-screen
    zle end-of-line
}

zle -N peco-snippets
bindkey '^ ' peco-snippets
