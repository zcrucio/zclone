: ${ZCLONE_ROOT:="$HOME/projects"}

function _zclone_help() {
  cat <<EOF
zclone — clone git repositories into a structured directory tree

Usage:
  zclone <git-repository-url>
  zclone --help | -h

Description:
  Clones a git repository into the following path structure:

    <ZCLONE_ROOT>/<host>/<namespace>/<repo>

  Namespace depth is unlimited (GitLab-style groups supported).

Configuration:
  ZCLONE_ROOT       Root directory for all cloned repositories
                    Default: \$HOME/projects

Examples:
  zclone https://github.com/vcrucio/zclone.git
EOF
}

function zclone() {
  if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    _zclone_help
    return 0
  fi

  local repo_url="$1"

  if [[ -z "$repo_url" ]]; then
    echo "Error: repository URL is required"
    echo "Run 'zclone --help' for usage information"
    return 1
  fi

  local host full_path repo namespace base_path target

  # HTTPS
  # https://host/group/subgroup/repo.git
  if [[ "$repo_url" =~ ^https?://([^/]+)/(.+)\.git$ ]]; then
    host="${match[1]}"
    full_path="${match[2]}"

  # SSH
  # git@host:group/subgroup/repo.git
  elif [[ "$repo_url" =~ ^git@([^:]+):(.+)\.git$ ]]; then
    host="${match[1]}"
    full_path="${match[2]}"

  else
    echo "Error: unsupported repository URL format"
    return 1
  fi

  repo="${full_path##*/}"
  namespace="${full_path%/*}"

  base_path="$ZCLONE_ROOT/$host/$namespace"
  target="$base_path/$repo"

  mkdir -p "$base_path" || return 1

  if [[ -d "$target" ]]; then
    echo "Repository already exists: $target"
    cd $target
    return 0
  fi

  git clone "$repo_url" "$target"
  cd $target
}

