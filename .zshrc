# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/go/bin:$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$HOME/.symfony/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mubisco/.oh-my-zsh"

export EDITOR="nvim"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose vi-mode fzf colorize)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias zshconfig="nvim ~/.zshrc"
#alias vimconfig="nvim ~/.config/nvim/init.vim"
#alias ohmyzsh="nvim ~/.oh-my-zsh"
#alias cfgreload="source ~/.zshrc"
#alias sf="symfony"
#alias sfc="symfony console"
#alias scc="symfony console cache:clear"
#alias sft="php bin/phpunit"
#alias sftu="php bin/phpunit tests/unit"
#alias ll="lsd -l"
#alias ls="lsd"
#alias la="lsd -la"
#alias rfd="rofi -show drun -show-icons"
#alias rfw="rofi -show window -show-icons"
#alias rff="rofi -show file-browser -show-icons"
#alias mntxorfor="sudo mount.cifs -v -o credentials=/etc/credentials,dir_mode=0755,file_mode=0664,uid=1000,gid=1000 //192.168.0.19/xorfor_files /home/mubisco/Projects/Bahia/Xorfor/xorfor_files_win"
#alias umnt="sudo umount /home/mubisco/Projects/Bahia/Xorfor/xorfor_files_win"
#alias gfdir="cd /home/mubisco/Projects/Getlife"
#alias monorepo="cd /home/mubisco/Projects/Getlife/monorepo"
#alias gfdev="ssh aitor_getlife_es@app.dev.getlife.es"
#alias gftest="gcloud compute ssh kube-1 --zone 'europe-west1-b'"
#alias gfprod="gcloud compute ssh api-1 --zone 'europe-west1-b'"
#alias wpprod="gcloud compute ssh wordpress-1-vm --zone 'europe-west4-a'"
#alias scptest="scp -i /home/mubisco/.ssh/google_compute_engine"
#alias gfdemo="ssh aitor_getlife_es@app.demo.getlife.es"
#alias gfkube="ssh aitor_getlife_es@kube.getlife.es"
#alias gfscrapper="ssh aitor_getlife_es@scrapper.getlife.es"
#alias gfdbd="mycli -d getlife_docker"
#alias gfdbl="mycli -d getlife_local"
#alias gfbundles="rm -rf vendor/getlife/ && composer run update-bundles"
#alias gfapibal='gcloud compute ssh --zone "europe-west1-b" "new-api-bal-1"  --project "central-octane-307111"'
#alias gfapibal2='gcloud compute ssh --zone "europe-west1-b" "api-bal-2"  --project "central-octane-307111"'
#alias gfbalancer='gcloud compute ssh --zone "europe-west1-b" "balancer-1"  --project "central-octane-307111"'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
