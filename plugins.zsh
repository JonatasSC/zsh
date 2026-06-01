# =========================================================
# Plugins
# =========================================================

ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo "Installing ${2}..."
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo "ERROR: failed to install ${2}" >&2; return 1; }
  fi
  source "${plugin_path}/${2}.plugin.zsh"
}

# Install a single-file plugin via curl (used for plugins that live inside a
# larger repo, e.g. oh-my-zsh's ssh-agent).
_zplugin_load_file() {
  local name="$1" url="$2"
  local plugin_path="${ZPLUGINDIR}/${name}"
  local file="${plugin_path}/${name}.plugin.zsh"
  if [[ ! -f "$file" ]]; then
    mkdir -p "$plugin_path"
    echo "Installing ${name}..."
    curl -fsSL "$url" -o "$file" \
      || { echo "ERROR: failed to install ${name}" >&2; return 1; }
  fi
  source "$file"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    if [[ -d "${dir}.git" ]]; then
      echo "Updating ${dir:t}..."
      git -C "$dir" pull --ff-only
    fi
  done
}

# Runs once on a fresh machine: ask for the git user.name if not configured yet.
_zplugin_bootstrap_git_user() {
  command -v git >/dev/null 2>&1 || return
  [[ -n "$(git config --global user.name 2>/dev/null)" ]] && return
  local name
  echo "Setup inicial: git user.name ainda não está configurado."
  read "name?Digite seu nome de usuário do git: "
  [[ -n "$name" ]] && git config --global user.name "$name" \
    && echo "git user.name = $name"
}

_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load zdharma-continuum fast-syntax-highlighting

# Oh-My-Zsh ssh-agent plugin (single-file, fetched from upstream on first run)
_zplugin_load_file ssh-agent \
  "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/ssh-agent/ssh-agent.plugin.zsh"

_zplugin_bootstrap_git_user
