# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.config/composer/vendor/bin:/opt/maven/bin:$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/mubisco/.oh-my-zsh"

POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_LINUX_FEDORA_ICON='\uf30a'
# Disable dir/git icons
POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

DISABLE_AUTO_TITLE="true"

# POWERLEVEL9K_VCS_GIT_ICON=''
# POWERLEVEL9K_VCS_GIT_ICON=$'\uf1d2 '
# POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uf113 '
# POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uf296 '
# POWERLEVEL9K_VCS_BRANCH_ICON=$''
# POWERLEVEL9K_VCS_STAGED_ICON=$'\uf055'
# POWERLEVEL9K_VCS_UNSTAGED_ICON=$'\uf421'
# POWERLEVEL9K_VCS_UNTRACKED_ICON=$'\uf00d'
# POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\uf0ab '
# POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\uf0aa '
#
POWERLEVEL9K_VCS_BRANCH_ICON=''
# POWERLEVEL9K_VCS_COMMIT_ICON='\ue629'
# POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON='\ue603'
# POWERLEVEL9K_VCS_GIT_GITHUB_ICON='\ue608'
# POWERLEVEL9K_VCS_GIT_GITLAB_ICON: '\ue608'

POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_ICON='?'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(zsh_showStatus context dir vi_mode)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs background_jobs time battery)

POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_left"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=4

POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
POWERLEVEL9K_ALWAYS_SHOW_USER=true
export DEFAULT_USER="$USER"
POWERLEVEL9K_CONTEXT_TEMPLATE="\ufb8a %n"

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

# POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_OK=true
POWERLEVEL9K_CUSTOM_STATUS_FAIL_ICON="\uf303"
POWERLEVEL9K_CUSTOM_STATUS_OK_ICON="\uf303"
#
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='orange1'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='black'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='red'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='white'
POWERLEVEL9K_VI_INSERT_MODE_STRING='\uf11c '
POWERLEVEL9K_VI_COMMAND_MODE_STRING='\uf120'
# Set name of the theme to load.
ZSH_THEME="powerlevel9k/powerlevel9k"
#
prompt_zsh_showStatus () {
  local ec_text
  local ec_sum
  local ec

        # We use RETVAL instead of the right-most RETVALS item because
        # PIPE_FAIL may be set.
        ec_text=$(exit_code_or_status "${RETVAL}")
        ec_sum=${RETVAL}

        if (( ec_sum > 0 )); then
          if [[ "$POWERLEVEL9K_STATUS_CROSS" == false && "$POWERLEVEL9K_STATUS_VERBOSE" == true ]]; then
            "$1_prompt_segment" "$0_ERROR" "$2" "red" "yellow1" "$ec_text" 'CARRIAGE_RETURN_ICON'
          else
            "$1_prompt_segment" "$0_ERROR" "$2" "$DEFAULT_COLOR" "red" "" 'CUSTOM_STATUS_FAIL_ICON'
          fi
        elif [[ "$POWERLEVEL9K_STATUS_OK" == true ]] && [[ "$POWERLEVEL9K_STATUS_VERBOSE" == true || "$POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE" == true ]]; then
          "$1_prompt_segment" "$0_OK" "$2" "$DEFAULT_COLOR" "green" "" 'CUSTOM_STATUS_OK_ICON'
        fi
      }

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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

export FZF_BASE=/usr/bin/fzf
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(dnf docker docker-compose git vi-mode fzf zsh-autosuggestions colorize zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias sf="php bin/console"
alias sft="php bin/phpunit"
alias ll="lsd -l"
alias ls="lsd"
alias la="lsd -la"
alias rfd="rofi -show drun -show-icons"
alias rfw="rofi -show window -show-icons"
alias rff="rofi -show file-browser -show-icons"
alias mntxorfor="sudo mount.cifs -v -o credentials=/etc/credentials,dir_mode=0755,file_mode=0664,uid=1000,gid=1000 //192.168.0.19/xorfor_files /home/mubisco/Projects/Bahia/Xorfor/xorfor_files_win"
alias umnt="sudo umount /home/mubisco/Projects/Bahia/Xorfor/xorfor_files_win"

dceb () {
  docker exec -it "$1" bash
}
