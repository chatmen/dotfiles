# PATH
export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:${PATH}

source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true

# Terminal
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='\[\033[32m\]\u@\[\033[00m\]: \[\033[34m\]\w\[\033[33m\]$(__git_ps1)\[\033[00m\]\n\$ '

# enable color support of ls and also add handy aliases
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --g --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dev='cd ~/../../Volumes/dev'
alias bld='~/../../Volumes/dev/nb/nb_product/hb-web-main/./build_front.sh dev'
alias nab='yarn && yarn build && npm run build.prod && npm run copy-assets'
# emacs
#alias em='/Applications/Emacs.app/Contents/MacOS/Emacs'
# about yarn
alias ybd='yarn && yarn build'
alias yrw='yarn run build.watch'
# MySQL
alias msl='mysql -u nextbeat -p'
alias msd='mysql -udocker -h127.0.0.1 -P33306 -p'
alias cli='mycli -u nextbeat -plivet'
alias sdb='show databases;'
alias stb='show tables;'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'

# git
alias gs='git status'
alias gp='git push'
alias gco='git checkout'

# cd
alias ..2='cd ../..'
alias ..3='cd ../../..'

# sbt
alias sbt8='sbt "run -Dhttp.port=8080"'

#docker
alias dup='docker-compose up -d'
alias drm='docker-compose rm'
alias dst='docker-compose stop'

#grep
alias ksbt='ps aux | grep sbt'
alias k9='kill -9 '

export COURSIER_TTL=1s

# stty setting
stty erase "^H"

## 現在のディレクトリ以下をファイル検索しながらpreviewも表示してくれて、Enter押すと　emacsが起動
# fzf
fmacs() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  emacs $selected_files
}

# remote,localのブランチを一覧し、検索しながらEnter Keyでcheckoutできる神関数
# fzf brach
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fcat() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  cat $selected_files
}
# commit履歴をbranchの分岐も含めてかしかしてくれる
fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute:
      (grep -o '[a-f0-9]\{7\}' | head -1 |
      xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
      {}
      FZF-EOF"
}
# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
