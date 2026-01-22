# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

if [[ "$TERM" == *-256color || "$TERM" == "xterm-color" ]]; then
  autoload -Uz colors && colors
fi

# Starship to have a beautifull prompt :)
eval "$(starship init zsh)"
#neofetch
eval "$(zoxide init zsh)"

# source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# bindkey -M menuselect '\r' accept-line
autoload -Uz compinit && compinit
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(up-line-or-history down-line-or-history)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[alias]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=214,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=214,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=214,bold
# Keys, Config
# bindkey '\e[A' history-beginning-search-backward
# bindkey '\eOA' history-beginning-search-backward
# bindkey '\e[B' history-beginning-search-forward
# bindkey '\eOB' history-beginning-search-forward
# zle -A {.,}history-incremental-search-forward
# zle -A {.,}history-incremental-search-backward
# zstyle ':autocomplete:*' widget-style menu-select
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-packed false
# zstyle ':completion:*' list-rows-first false
# zstyle ':completion:*' menu select

# zstyle ':autocomplete:*' list-lines 7
# zstyle ':completion:*' list-lines 2


autoload -U select-word-style
select-word-style bash

## enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    color_prompt=yes
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
alias ll='ls --color=auto -alF'
alias l='ls --color=auto -alF'
alias k=kubectl
alias la='ls --color=auto -A'
# Enable word jumping with Ctrl+Left/Right in zsh
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
alias n=nvim
alias vim=nvim

createC() {
touch "$1.c"
touch "$1.h"
echo "#include \"$1.h\"" > "$1.c"
echo "#ifndef ${1^^}_H" >> "$1.h"
echo "#define ${1^^}_H" >> "$1.h"
echo "


" >> "$1.h"
echo "#endif /* ! ${1^^}_H */" >> "$1.h"
}

alias js='cd /home/marco/Documents/JS'
alias mygcc='gcc -Wextra -Wall -Werror -Wvla -std=c99 -pedantic -g -fsanitize=address'
alias m='make -B'
alias md='make debug -B'
alias mc='make clean'
alias gs='git status'
alias ga='git add'
alias gm='git commit -m'
alias dclean='docker compose down; docker rmi -f $(docker images -a -q); docker volume prune -a; docker rm $(docker ps -a -q)'
alias dockerlist='docker images && docker volume ls && docker ps -a'
alias down='docker compose down'
alias dupdate='curl -L "https://discord.com/api/download?platform=linux" --output discord.deb; sudo dpkg -i discord.deb; rm discord.deb; sh -c "$(curl -sS https://vencord.dev/install.sh)"'

create_sh()
{
        touch "$1"
        chmod u+x "$1"
        echo "#!/bin/sh">"$1"
        vim "$1"
}

createMakefile()
{
    touch Makefile
    echo "CC = gcc" > Makefile
    echo "CFLAGS = -std=c99 -Wall -Wextra -Werror -pedantic -Wvla" >> Makefile
    echo "SRC= main.c" >> Makefile
    echo "OBJS = \$(SRC:.c=.o)" >> Makefile
    echo "" >> Makefile
    echo "BIN = main" >> Makefile
    echo "" >> Makefile
    echo "all: \$(BIN)" >> Makefile
    echo "" >> Makefile
    echo "\$(BIN): \$(OBJS)" >> Makefile
    echo -e "\t\$(CC) \$(CFLAGS) \$(OBJS) -o \$(BIN) \$(LDFLAGS)" >> Makefile
    echo "" >> Makefile
    echo "clean:" >> Makefile
    echo -en "\t" >> Makefile
    echo "\$(RM) \$(BIN) \$(OBJS)" >> Makefile
}

tag()
{
    GREEN='\033[0;32m'
    NC='\033[0m'

    tag_slug_regex="$1"
    tag_slug=${tag_slug_regex%?}
    tags=$(git tag | grep "$tag_slug_regex")
    num_tag=1
    # To reverse order but git tag has a weird sort so useless
    # for tag in $(echo "$tags" | tr ' ' '\n' | tac | tr '\n' ' '); do
    for tag in $(echo "$tags"); do
        name=${tag#"$tag_slug"}
        num=$(echo "$name"|grep "^[0-9]*$")
        val="$?"
        if [ "$val" -eq 0 ]
        then
            num=$(($num + 1))
            if [ "$num" -gt "$num_tag" ]
            then
                num_tag="$num"
            fi
        fi
    done
    tag_name="$tag_slug""$num_tag"
    git status
    git commit -m "feat(tag): ${tag_name}"
    echo -e "$GREEN"Tagging with name: "$NC""$tag_name"
    git tag -ma "$tag_name"
    if [ "$2" = "-p" ]
    then
        git push --follow-tags
    fi
}

push()
{
    git add -u
    if [ "$2" = "-S" ]; then
        git commit -m "$1" -S
    elif [ "$2" = "-tag" ]; then
        git commit -m "$1"
        git tag -ma "$3"
        git push --follow-tags
        return
    else
        git commit -m "$1"
    fi
    git push
}

export DEBUGINFOD_URLS="https://debuginfod.ubuntu.com"
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export PGPORT="5432"
export PATH=$PATH:/usr/lib/postgresql/17/bin/
cd Desktop

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
