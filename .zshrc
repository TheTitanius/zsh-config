#горячие клавиши
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

#выбор меню
zstyle ':completion:*' menu select

#цвета
autoload -U colors
colors
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
export LS_COLORS="$LS_COLORS:ow=30;44:"

#подключение информации о git
autoload -U vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '[%b]❭'

#настройка история
setopt appendhistory
ANTIGEN_PATH="$HOME/.config/antigen.zsh"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

#подключение антигена
if [ ! -f $ANTIGEN_PATH ]; then
	echo "Antigen is not found!" >&2
		curl -L git.io/antigen > $ANTIGEN_PATH
fi

source $ANTIGEN_PATH

#плагины антиген
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

#настройки подсветки
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[command]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[path]=bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,bold,underline

#псевдонимы
alias ls='ls --color=auto'

#вид подсказки
setopt PROMPT_SUBST
PROMPT=$'%{\e[40m\e[1;92m%}%n@%m%{\e[0m%}%{\e[100m\e[1;96m%}:%~%{\e[0m\e[m%}%{\e[100m\e[1;96m%}❭%{\e[0m\e[m%}%{\e[103m\e[1;91m%}${vcs_info_msg_0_}%{\e[0m\e[m%} '
RPROMPT='%F{magenta}%T%f'

#включение утилиты команда не найдена
if [ -f /etc/zsh_command_not_found ]; then
    . /etc/zsh_command_not_found
fi

#neofetch
clear
neofetch