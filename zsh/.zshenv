# Skip the global compinit run in Ubuntu/Debian's /etc/zsh/zshrc. It runs before
# ~/.zshrc — too early for our fpath fix-ups — and would double-run compinit. We
# call compinit ourselves in .zshrc, so suppress the global one here.
skip_global_compinit=1
