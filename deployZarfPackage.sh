#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "$CURR_DIR" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

# shellcheck source=./common.sh
source "$CURR_DIR/helpers/common.sh";

section "DEPLOY ZARF PACKAGE INTO SECURE LOCATION `"airgapped`""
info_pause_exec_options "Create K3D Cluster" "k3d cluster create demo --no-lb --k3s-arg '--disable=traefik@server:*' --k3s-arg '--disable=metrics-server@server:*'"
info_pause_exec "check init package exists" "ls -la"
info_pause_exec "init cluster" "zarf init --components git-server --confirm"
proceed_or_not "was zarf-package-big-bang-core-demo-amd64.tar.zst package downloaded, proceed?"
info_pause_exec "deploy games to cluster" "zarf package deploy zarf-package-big-bang-core-demo-amd64.tar.zst"
