# zclone

`zclone` is an *oh-my-zsh* plugin for cloning Git repositories into a deterministic
directory structure derived from the repository URL.

Namespaces of arbitrary depth are supported (GitLab, self-hosted Git, GitHub).

---

## Features

- Cloning via HTTPS and SSH
- Support for namespaces of any depth
- Automatic directory creation
- Single root directory for all repositories

---

## Installation
```bash
git clone https://github.com/vcrucio/zclone \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zclone
```

Add the plugin to .zshrc:
```
plugins=(... zclone)
```

Restart the shell or run:
```bash
source ~/.zshrc
```

## Configuration
You can specify the root directory for cloning in .zshrc:
```
export ZCLONE_ROOT="/projects"
```
By default, $HOME/projects is used.

## Help
```bash
zclone --help
```
