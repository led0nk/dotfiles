#!/bin/bash
# The same process check vim-tmux-navigator uses: is the pane's TTY serving
# an editor (nvim/vim/fzf)? Returns 0 (say yes) when it is. Used by the root
# Alt-movement binds: editors get the keys passed through, plain inputs (zsh,
# claude/ollama prompt) get them translated to readline-style keys.
ps -o state= -o comm= -t "$1" | grep -iqE '^[^TXZ ]+ +(\S+/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'