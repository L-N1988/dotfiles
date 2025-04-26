# ~/.oh-my-zsh/custom/themes/deepin-green.zsh-theme

# Deepin-Inspired Green on Black Theme for Oh My Zsh

# Prompt configuration
PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) %{$fg_bold[green]%}%#%{$reset_color%} '

# Git prompt configuration
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

