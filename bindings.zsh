# =========================================================
# Keybindings (Standard Zsh - No Modes)
# =========================================================

# Ctrl+Right -> move forward one word
bindkey '^[[1;5C' forward-word
# Ctrl+Left -> move backward one word
bindkey '^[[1;5D' backward-word

# Ctrl+F -> fzf file picker
bindkey '^F' _fzf_file_no_hidden

# Ctrl+\ -> toggle autosuggestions
bindkey '^\' autosuggest-toggle

# Up/Down -> history search by substring
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# ALT + BACKSPACE -> DELETE ENTIRE LINE
# Standard Zsh bindings
bindkey '^[^?' backward-kill-line
bindkey '\e\x7f' backward-kill-line
bindkey '\e^?' backward-kill-line

# Ensure Ctrl+U and Ctrl+W work normally
bindkey '^U' backward-kill-line
bindkey '^W' backward-kill-word
