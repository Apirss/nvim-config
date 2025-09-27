#~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Starship to have a beautifull prompt :)
eval "$(starship init bash)"
#neofetch

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias n=nvim
alias vim=nvim
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
. "$HOME/.cargo/env"


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

alias ep="cd /home/apirss/Documents/Epita/"
alias mygcc='gcc -Wextra -Wall -Werror -Wvla -std=c99 -pedantic -g -fsanitize=address'
alias nuget='cp /home/apirss/.nuget/NuGet/NuGet.Config .nuget.config'
alias m='make -B'
alias md='make debug -B'
alias mc='make clean'
alias gs='git status'
alias ga='git add'
alias gm='git commit -m'

create_sh()
{
        touch "$1"
        chmod u+x "$1"
        echo "#!/bin/sh">"$1"
        vim "$1"
}

createC()
{
    touch "$1.c"
    touch "$1.h"
    echo "#include \"$1.h\"" > "$1.c"
    echo "#ifndef ${1^^}_H" >> "$1.h"
    echo "#define ${1^^}_H" >> "$1.h"
    echo "#endif /* ! ${1^^}_H */" >> "$1.h"
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
    git commit -m "$1"
    git push
}

export DEBUGINFOD_URLS="https://debuginfod.ubuntu.com"
export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export PGPORT="5432"
export PATH=$PATH:/usr/lib/postgresql/16/bin/
cd Desktop
