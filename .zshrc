# The following lines were added by compinstall

##
# Antibody Plugin Config
source ~/.zsh_plugins.sh

##
# Enviromental
##
export VISUAL="vim"
export BROWSER=/usr/bin/firefox
# Add ~/.local/ to PATH
export PATH=$HOME/.local/bin:$PATH
export MANWIDTH=${MANWIDTH:-80}
# Auto pipenv
source ~/.scripts/pipenv.sh

##
# CACHE CONFIG
##
ZSH_CACHE="/tmp/.zsh-${USER}-${ZSH_VERSION}"
mkdir -p $ZSH_CACHE
chmod 700 $ZSH_CACHE

##
# History Configuration
##
HISTSIZE=100000                 #How many lines of history to keep in memory
HISTFILE=~/.zsh_history         #Where to save history to disk
SAVEHIST=100000                 #Number of history entries to save to disk
#HISTDUP=erase                  #Erase duplicates in the history file
setopt appendhistory            #Append history to the history file (no overwriting)
setopt sharehistory             #Share history across terminals
setopt incappendhistory         #Immediately append to the history file, not just when a term is killed
setopt histignorespace          #Ignores command if first charcter is a space

##
# Configs
##
setopt NO_clobber # warning if file exists ('cat /dev/null > ~/.zshrc')
setopt printexitvalue # warn if something failed
setopt auto_cd                  #If a command is can't execute and the command is a folder name, performe cd
setopt notify                   #Notify status of background jobs inmediatly
watch=all                       # watch all logins
logcheck=30                     # every 30 seconds
WATCHFMT="%n from %M has %a tty%l #t %T %W"
# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
REPORTTIME=5
# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

##
# Autosuggestions
##
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11,bg=4,bold,underline"

##
# Completions Config
# https://github.com/ThiefMaster/zsh-config/tree/master/zshrc.d
##
fpath=(.cache/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-user-SLASH-zsh-completions/src $fpath)
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
sched 0 _set-list-colors  # deferred since LC_COLORS might not be available yet
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
  _accounts=(`egrep "^User" ~/.ssh/config | sed s/User\ // | egrep -v '^\*$'`)
  zstyle ':completion:*:users' users $_accounts
fi

##
# Prompt // Theme Minimal Config
##
autoload -Uz promptinit
promptinit
MNML_OK_COLOR=4
MNML_USER_CHAR=$
# Components on the left prompt
MNML_PROMPT=(mnml_ssh mnml_pyenv mnml_status mnml_keymap mnml_git)
# Components on the right prompt
MNML_RPROMPT=('mnml_cwd 2 8')
# Components shown on info line
MNML_INFOLN=(mnml_err mnml_jobs mnml_uhp mnml_files)

# Colors in prompt
autoload -U colors zsh-mime-setup select-word-style
colors          # colors
zsh-mime-setup  # run everything as if it's an executable
select-word-style bash # ctrl+w on words

##
# Key bindings
#
bindkey -v
bindkey "\e[3~" delete-char
# Better searching in command mode
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
## use the vi navigation keys (hjkl) besides cursor keys in menu completion


##
# Vi Mode
##
bindkey -v      # vi mode
vim_ins_mode="%{$fg[yellow]%}[INS]%{$reset_color%}"
vim_cmd_mode="%{$fg[cyan]%}[CMD]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
    vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
    vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

##
# Todo.TXT config
##
export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
alias t='todo.sh -d ~/.todo/config-urxvt'

##
# Colors
##
# Colors in Less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


## global aliases (for those who like them) ##

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
alias -g noturnoff=setterm -powerdown 0
alias -g donotdisturb='notify-send "DUNST_COMMAND_PAUSE"'
alias -g disturb'=notify-send "DUNST_COMMAND_RESUME"'
alias -g ns='sudo netctl switch-to'
alias -g prime-switch='sudo /usr/bin/prime-switch'

##
# direnv config
##
eval "$(direnv hook zsh)"

##
#Plugin sources
##
source "/home/adux/.cache/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-autosuggestions/zsh-autosuggestions.zsh"
source /usr/share/autojump/autojump.zsh
source "/home/adux/.cache/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
