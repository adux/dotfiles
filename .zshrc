##
# BASH inheritance
##
[[ $- != *i* ]] && return

##
# Antidote Plugin Config
##
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt
fpath=(/usr/share/zsh-antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

source ${zsh_plugins}.zsh

##
# Enviromental load
##
env_folder="/home/adux/.config/environment.d/"

if [[ -d "$env_folder" ]]; then
  for file in "$env_folder"/*.zsh; do
    source "$file"
  done
else
  echo "Folder does not exist: $env_folder"
fi

export VISUAL="vim"
export BROWSER=/usr/bin/firefox
export PATH=$HOME/.local/bin:$PATH
export MANWIDTH=${MANWIDTH:-80}

source ~/.scripts/pipenv.sh  # Auto Pipienv if found

##
# Cache
##
ZSH_CACHE="/tmp/.zsh-${USER}-${ZSH_VERSION}"
mkdir -p $ZSH_CACHE
chmod 700 $ZSH_CACHE

##
# History
##
HISTSIZE=100000  #How many lines of history to keep in memory
HISTFILE=~/.zsh_history #Where to save history to disk
SAVEHIST=100000  #Number of history entries to save to disk
#HISTDUP=erase  #Erase duplicates in the history file
setopt appendhistory  #Append history to the history file (no overwriting)
setopt sharehistory  #Share history across terminals
setopt incappendhistory  #Immediately append to the history file, not just when a term is killed
setopt histignorespace  #Ignores command if first charcter is a space

##
# Various :)
##
setopt NO_clobber  #Warning if file exists ('cat /dev/null > ~/.zshrc')
setopt printexitvalue  #Warning if something failed
setopt auto_cd  #If a command is can't execute and the command is a folder name, performe cd
setopt notify  #Notify status of background jobs inmediatly
watch=all  #Watch all logins
logcheck=30  #Every 30 seconds
WATCHFMT="%n from %M has %a tty%l #t %T %W"
REPORTTIME=5  #5 seconds report about cpu-/system-/user-time of command if running longer than
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH  #Automatically remove duplicates from these arrays

##
# Autosuggestions
##
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11,bg=4,bold,underline"

## Completions
# https://github.com/ThiefMaster/zsh-config/tree/master/zshrc.d
##
autoload -Uz compinit
compinit -d "$ZSH_CACHE/zcompdump"
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE
# setopt MENU_COMPLETE # immediatelly insert first match
zstyle ':completion:*' completer _expand_alias _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
# Allow some errors
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3)) numeric)'
# Get a completetion menu
zstyle ':completion:*' menu yes select
zstyle ':completion:*:history-words' menu select
# Group results by category
zstyle ':completion:*' group-name ''
# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true
# Don't try parent path completion if the directories exist
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' add-space true
# Pretty messages during pagination
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
# Verbose completion results
zstyle ':completion:*' verbose true
# Nicer format for completion messages
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:corrections' format '%U%F{green}%d (errors: %e)%f%u'
zstyle ':completion:*:warnings' format '%F{202}%BSorry, no matches for: %F{214}%d%b'
# Show message while waiting for completion
zstyle ':completion:*' show-completer true

# Use ls-colors for path completions
function _set-list-colors() {
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
	unfunction _set-list-colors
}

sched 0 _set-list-colors  #Deferred since LC_COLORS might not be available yet

# Always use menu selection for `cd -`
zstyle ':completion:*:*:cd:*:directory-stack' force-list always
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# Rehash when completing commands
zstyle ":completion:*:commands" rehash 1
# Colors in completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Process completion shows all processes with colors
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' command 'ps -A -o pid,user,cmd'
zstyle ':completion:*:*:*:*:processes' list-colors "=(#b) #([0-9]#)*=0=${color[green]}"
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# Speedup path completion
#zstyle ':completion:*' accept-exact '*(N)'
# Don't complete uninteresting stuff unless we really want to.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
zstyle ':completion:*:*:*:users' ignored-patterns \
		adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
		clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
		gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
		ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
		named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
		operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
		rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
		usbmux uucp vcsa wwwrun xfs cron mongodb nullmail portage redis \
		shoutcast tcpdump '_*'
zstyle ':completion:*' single-ignored show

##
# SSH
##
if [[ -f ~/.ssh/config ]]; then
  _accounts=(`grep -E "^User" ~/.ssh/config | sed s/User\ // | grep -E -v '^\*$'`)
  zstyle ':completion:*:users' users $_accounts
fi

##
# Prompt // Theme Minimal Config
##
# autoload -Uz promptinit
# promptinit
# prompt pure

# Colors in prompt
autoload -U colors zsh-mime-setup select-word-style
colors          # colors
zsh-mime-setup  # run everything as if it's an executable
select-word-style bash # ctrl+w on words

##
# Vi Mode
##
bindkey -v

##
# Key bindings
##
bindkey "\e[3~" delete-char
bindkey -M vicmd '/' history-incremental-search-forward  #Better searching in command mode
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
autoload edit-command-line; zle -N edit-command-line  #Edit command in vim
bindkey -M vicmd 'v' edit-command-line

##
# Todo.TXT config
##
export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
alias t='todo.sh -d ~/.todo/config-urxvt'

##
# Colors in Less
##
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## Global aliases (for those who like them) ##
alias ls='ls --color=auto'
alias grep='grep --color=auto'
#alias -g '...'='../..'
#alias -g '....'='../../..'
alias -g BG='& exit'
#alias -g C='|wc -l'
alias -g G='|grep'
#alias -g H='|head'
#alias -g Hl=' --help |& less -r'
#alias -g K='|keep'
alias -g L='|less'
#alias -g LL='|& less -r'
#alias -g M='|most'
alias -g N='&>/dev/null'
#alias -g R='| tr A-z N-za-m'
#alias -g SL='| sort | less'
#alias -g S='| sort'
#alias -g T='|tail'
alias -g V='| vim -'
alias -g vpnzhaw='.scripts/vpn_zhaw.sh'
alias -g noturnoff='setterm -powerdown 0'
alias -g donotdisturb='dunstctl set-paused true'
alias -g disturb='dunstctl set-paused false'
alias -g ns='sudo netctl switch-to'
alias -g pdf2write='(cd /home/adux/.scripts/ ; zsh pdf2write.sh)'
alias -g crop='grimshot --notify copy area'
alias -g cal='cal -w --monday --color=auto'
alias -g tig='git log --graph --pretty=oneline --abbrev-commit'
