export PATH=/usr/local/bin:/usr/local/opt/emacs-mac/bin:/Library/PostgreSQL/11/bin/:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$PATH:`yarn global bin`"
export PATH=$PATH:/usr/local/go/bin

export EDITOR=/usr/local/bin/nvim
export XDG_CONFIG_HOME="$HOME/.config"  # for the setting file of neovim
export NVIM_PYTHON_LOG_FILE=/tmp/log
export NVIM_PYTHON_LOG_LEVEL=DEBUG

export PGPASSWORD=Kento012

autoload -U compinit
compinit
setopt auto_pushd
setopt auto_cd
cdpath=(.. ~)
setopt correct
setopt cdable_vars

autoload colors
colors
PROMPT="%{$fg[green]%}%C %(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]?  %{$reset_color%}"
RPROMPT="%{$fg[yellow]%}[%~]%{$reset_color%}"

export LANG=ja_JP.UTF-8

HISTFILE=~/.zhistory
SAVEHIST=10000
setopt histnostore
setopt histreduceblanks
setopt histignoredups
setopt histignorespace

setopt extendedglob
setopt numericglobsort

export LSCOLORS=hxfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias eg='emacsclient --create-frame' # emacs as GUI
alias et='emacsclient -t' # emacs on terminal
alias edaemon="emacs --daemon"
alias ekill="emacsclient -e '(kill-emacs)'"
alias edebug="emacs --debug-init"

alias ls="ls -GFh"
alias lsa="ls -A"
alias ll='ls -lt'
alias gls="gls --color"

alias py="~/opt/anaconda3/bin/python"
alias python3="~/opt/anaconda3/bin/python"
alias pip3="~/opt/anaconda3/bin/pip"
alias pyl="/usr/local/bin/pylint"
alias ipy="/usr/local/Cellar/python/3.7.1/bin/python3.7 -m IPython"
alias ipyj="/usr/local/Cellar/python/3.7.1/bin/python3.7 -m IPython notebook"

#alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/bin/mvim "$@"'
alias n="/usr/local/bin/nvim"
alias nd="nvim ~/.cache/dein/plugins/dein.toml ~/.cache/dein/plugins/dein_lazy.toml"
alias ni="nvim ~/.config/nvim/init.vim"
alias nz="nvim ~/.zshrc && source ~/.zshrc"

alias latexmk="/usr/local/texlive/2018/bin/x86_64-darwin/latexmk"
# alias eslint="/usr/local/bin/eslint"
# alias stylelint="/usr/local/bin/stylelint"


zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias -g G='|grep'
alias -g L='|less'

alias -s log=vim
alias -s txt=vim
# alias -s sh=vim

# alias sshk='ssh -l kawamura puffy.cla.kobe-u.ac.jp'
alias sshk='ssh -l kento 10.83.53.46'
alias sftpk='sftp kento@10.83.53.46'

alias sshi='ssh iccrc@133.30.188.133'
alias sshk='ssh otnekoygihs@133.30.244.51'
alias sftpi='sftp iccrc@133.30.188.133'

# alias psql='/Library/PostgreSQL/11/bin/psql'
# alias pg_dump='/Library/PostgreSQL/11/bin/pg_dump'
# alias pg_restore='/Library/PostgreSQL/11/bin/pg_restore'

alias gs='git status'
alias ga='git add'
alias go='git commit -m '
alias gl='git pull origin'
alias gh='git push origin'
alias gc='git checkout'
alias gr='git rebase'
alias gd='git diff'


setopt listrowsfirst
setopt listtypes
setopt menucomplete
setopt ignoreeof
setopt notify

#重複パスを登録しない
typeset -U path cdpath fpath manpath


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


alias wd='yarn webpack:dev'
alias sd='yarn start:dev'
