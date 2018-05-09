alias be='bundle exec'

# 自動でtmuxを立ち上げる
# https://github.com/fish-shell/fish-shell/issues/4434#issuecomment-332626369
if status is-interactive
and not set -q TMUX
    exec tmux
end