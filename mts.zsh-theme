#               mts.zsh
# ------------------------------------
# Personal prompt theme for oh-my-zsh
#
# Theme based on oh-my-bash's pure theme (https://github.com/ohmybash/oh-my-bash/blob/master/themes/pure/pure.theme.sh)
# Code based on oh-my-zsh's gentoo theme (https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/gentoo.zsh-theme)
#
# https://github.com/mtsdurica/mts.zsh
#
# Code licensed under the MIT license
# https://mtsdurica.mit-license.org
#
 
autoload -Uz colors && colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%B%F{red}✗%b%f'  # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%B%F{yellow}+%b%f' # display this when there are staged changes
zstyle ':vcs_info:git:*' actionformats '%f[%b%F{3}::%F{1}%a%c%m%u%f]'
zstyle ':vcs_info:git:*' formats '%f[%F{cyan}%s%f::%b:%c%m%u%f]'
zstyle ':vcs_info:svn:*' branchformat '%b'
zstyle ':vcs_info:svn:*' actionformats '%f[%F{green}%s::%b%F{1}:%{3}%i%F{3}:%F{1}%a%c%m%u%f]'
zstyle ':vcs_info:svn:*' formats '%f[%b%F{1}:%F{3}%i%c%m%u%f]'
zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:git*+set-message:*' hooks clean-git untracked-git pull-git

+vi-clean-git() {
    STATUS=$(git status --porcelain 2>/dev/null | tail -n1)
    if [[ -n $STATUS ]]; then
        hook_com[misc]=''
    else
        hook_com[misc]='%B%F{green}✓%b%f'
    fi
}

+vi-untracked-git() {
    if command git status --porcelain 2>/dev/null | command grep -q '??'; then
        hook_com[misc]+='%B%F{red}?%b%f'
    else
        hook_com[misc]+=''
    fi
}

+vi-pull-git() {
    # STATUS=$(git status --porcelain 2>/dev/null | grep -q 'ahead')
    if command git status --branch --porcelain 2>/dev/null | command grep -q 'ahead'; then
        hook_com[misc]='%F{blue}↑%f'
    elif command git status --branch --porcelain 2>/dev/null | command grep -q 'behind'; then
        hook_com[misc]='%F{blue}↓%f'
    fi
}

mts_precmd() {
    vcs_info
}

autoload -U add-zsh-hook
add-zsh-hook precmd mts_precmd

PROMPT='%(!.%F{red}.%F{green}%n%F{white}@)%B%F{blue}%m%b${vcs_info_msg_0_}%f::%F{yellow}%(!.%1~.%~) %F{green}%(!.#.>)%k%b%f '
