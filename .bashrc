# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
    PS1="[\w]:\[$(tput sgr0)\]"
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

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
alias la='ls -A'
#alias l='ls -CF'

# My custom alias
alias py="python3"
alias pip="pip3"
alias getme="sudo apt install"
alias awerc="subl ~/.config/awesome/rc.lua"
alias awetheme=" subl ~/.config/awesome/theme.lua"
alias bashrc="sudo subl ~/.bashrc"
#alias bashrc="sudo nano ~/.bashrc"
alias go="nautilus ."
alias myip="hostname -I | awk '{print $1}'"
alias close="/sbin/shutdown +0"
alias ptt="pdftotext -layout"
alias cdp="py ~/Documents/global/github/repos/change-directory-plus-main/cdp/cdp.py"
alias exe="chmod +x"
alias zork="snap run zork"
alias pdt="py ~/Documents/global/py/pdt.py -t"
# file links
alias anime="py ~/Documents/global/web/anime/animekisa.py"
#

alias yt="youtube-dl --restrict-filenames --o '~/Videos/youtube/%(uploader)s-%(title)s'"
ytd(){
	#video_folder="/Videos/youtube"
	echo "saving to "$video_folder
	if [ -z "$2" ];then
		#if argument 2 is empty
		youtube-dl --restrict-filenames --output '~/Videos/youtube/%(uploader)s-%(title)s' $1
	elif [ $2 == "-q" ]; then
		#cd "/home/l/Documents/global/nohup"
		nohup youtube-dl --restrict-filenames --output '~/Videos/youtube/%(uploader)s-%(title)s' $1 &> /tmp/nohup.out
		sleep 1
		exit
	elif [ $2 == "-sub" ]; then
		youtube-dl --restrict-filenames --write-sub --sub-lang en --output '~/Videos/youtube/%(uploader)s-%(title)s' $1
	else
		youtube-dl --restrict-filenames --output '~/Videos/youtube/%(uploader)s-%(title)s' $1
	fi
}
yt-mp3(){
	echo "saving to ~/Music/yt-mp3"
	if [ ! -z "$3" ];then
		if [ ! -d "~/Music/yt-mp3/$3" ]; then
			cd "/home/l/Music/yt"
			mkdir "$3"
		fi
	fi
	if [ $2 == "-o" ];then
		#if argument 2 is empty
		youtube-dl --restrict-filenames --extract-audio --audio-format 'mp3' --output "~/Music/yt-mp3/$3/%(title)s.%(ext)s" $1
	elif [ $2 == "-q" ]; then
		#cd "/home/l/Documents/global/nohup"
		nohup youtube-dl --restrict-filenames --extract-audio --audio-format 'mp3' --output "~/Music/yt-mp3/$3/%(title)s.%(ext)s" $1 &> /tmp/nohup.out
		sleep 1
		exit
	else
		echo "Missing argument"
	fi
}
#list video files
vidl() {
	echo "Historic: $(<~/Videos/historic.txt)"
	line=$(ls -1q | wc -l)
	vid=$(ls | dmenu -p $line)
	if [ $1 == "-sub" ];then
		nohup mpv -fs $vid &> /tmp/nohup.out
	else
		nohup mpv --sub=no -fs $vid &> /tmp/nohup.out
		echo "$vid" > ~/Videos/historic.txt
	fi
}
#record screen with sound
recs() {
	ffmpeg -f x11grab -s 2560x1440 -i :1 -f alsa -i default ~/Videos/recs/$1.mkv
}
#record microphone
mic() {
	rec ~/Music/mic/$1.wav
}
#remove spaces in file name
nospace() {
	for f in *\ *; do mv "$f" "${f// /$1}"; done
	#find -name "* *" | sort -rz | while read -d $'\0' f; do mv -v "$f" "$(dirname "$f")/$(basename "${f// /$1}")"; done
}
#w3m show/hide images
w3mimg () {
        w3m -o imgdisplay=/usr/lib/w3m/w3mimgdisplay $1
}

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

export EDITOR='nano'
export VISUAL='subl'
