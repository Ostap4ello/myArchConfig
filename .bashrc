#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#utils
alias ls='ls --color=auto'
alias ll='ls -l -a --color=auto'
alias grep='grep --color=auto'

alias py='python'
alias manual='man --locale=uk'
alias docker-compose='docker compose'

#directories
alias cdvs='cd ~/Documents/VSCode/
tree -d -L 2'
alias cdnv='cd ~/.config/nvim/
nvim'

#provide console with crazy aliases
[[ -f ~/.bash-suka-alias ]] && . ~/.bash-suka-alias

#apps
alias firefox='/usr/lib/firefox/firefox --use-gl=desktop --enable-accelerated-video-decode --enable-accelerated-video-encode --enable-features=VaapiVideoDecoder --disable-features=UseChromeOSDirectVideoDecoder'
alias settings='systemsettings'
alias files='dolphin'

lf () {
    # Define a temporary file to store the directory path
    tmpfile="$(mktemp)"
    
    # Launch lf and store the last directory in the temporary file
    "$HOME"/.config/lf/lf-ueberzug  -last-dir-path="$tmpfile"
    
    # Change to the last directory lf was in, if the file exists and is not empty
    if [ -f "$tmpfile" ] && [ "$(cat "$tmpfile")" != "" ]; then
        cd "$(cat "$tmpfile")"
    fi
    
    # Clean up the temporary file
    rm -f "$tmpfile"
}

#functions

run() {
       	"$@" & disown & exit 0
}

resetX11(){
	kwin_x11 --replace & disown & exit 0
}

git-init-repo-usr(){
	echo Enter folder name: 
    read f_name

    mkdir $f_name
    cd $f_name

	echo Enter repo ssh: 
    read repo_ssh

    git init
    git remote add origin $repo_ssh

    echo Do sparse checkout? [y/N]: 
    read is_sparse

	if [ "$is_sparse" == "y" ]; then
        git config core.sparseCheckout true
        echo List sparse folders: \(ctrl+C to finish listing\)
        cat >> .git/info/sparse-checkout
    fi

    cd ..

    echo Done.
}


#export EDITOR='vim'
#export VISUAL='vim'

export EDITOR='nvim'
export VISUAL='nvim'

# Created by `pipx` on 2023-12-17 20:27:05
export PATH="$PATH:/home/ostap4ello/.local/bin"

#export PS0=""
#export PS1="[\u@\h \W]\e[1;37m\$\e[0m "

# export LIBVA_DRIVER_NAME="i965"

stty werase \^H
