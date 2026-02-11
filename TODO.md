# TODO

## Phase 1: Enhance Current Dotfiles

### Configuration

- [ ] Shell: migrate to zsh and configure prompt (starship / powerlevel10k / oh-my-zsh)
- [ ] Neovim `init.lua`
- [ ] lazygit `config.yml`

## Phase 2: Container Support

- [ ] Add `is_container` flag to `.chezmoi.toml.tmpl`
- [ ] Skip apt scripts in containers (packages managed by Dockerfile)
- [ ] Install only a subset of mise tools in containers (editor + CLI only)

## Phase 3: Expand Packages and Tools

### apt packages

- [ ] Basic: `zsh`, `unzip`, `tar`, `p7zip-full`, `rsync`, `xclip`, `xsel`, `gpg`, `watch`
- [ ] Build: `make`, `cmake`, `pkg-config`
- [ ] Libraries: `libssl-dev`, `libffi-dev`, `libsqlite3-dev`, `libbz2-dev`, `libreadline-dev`, `libncurses-dev`, `zlib1g-dev`, `liblzma-dev`
- [ ] Docker: `docker-ce`, `docker-ce-cli`, `docker-compose-plugin`
- [ ] Monitoring: `nvtop`, `aptitude`

### mise tools

- [ ] Runtimes: `node`, `rust`, `uv`
- [ ] CLI: `lazydocker`, `yazi`, `ripgrep`, `fd`, `sd`, `btop`, `eza`, `bat`, `zoxide`, `delta`

### Applications

- [ ] Claude Code (`npm i -g @anthropic-ai/claude-code` via mise node)

## Phase 4: Cross-Platform

- [ ] macOS support (Homebrew, `.chezmoiscripts/darwin/`)
- [ ] Windows support (winget, PowerShell, `.chezmoiscripts/windows/`)

## Phase 5: Infrastructure & Automation

- [ ] VS Code extensions bulk install script
- [ ] Secret management with 1Password CLI
- [ ] CI testing with GitHub Actions (`chezmoi apply` on clean VM)

