#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "$CURR_DIR" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

source "$CURR_DIR/helpers/common.sh";

section "DEPLOY ZARF PACKAGE INTO SECURE LOCATION \"airgapped\""

# download the required binaries
proceed_or_not "Download zarf, zarf init package and example package. Proceed?"

section "CREATE CLUSTER"
info_pause_exec "Install k3d" "curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash"
info_pause_exec "Install k9s" "curl -sS https://webinstall.dev/k9s | bash"
info_pause_exec "Create K3D Cluster" "k3d cluster create demo --no-lb --k3s-arg '--disable=traefik@server:*' --k3s-arg '--disable=metrics-server@server:*'"

section "ZARF INIT CLUSTER"
info_pause_exec "init cluster" "zarf init --components git-server --confirm"

section "DEPLOY ZARF PACKAGE"
info_pause_exec "deploy games to cluster" "zarf package deploy zarf-package-big-bang-core-demo-amd64.tar.zst"

section "PLAY"
info_pause_exec "connect to game service" "zarf connect xyz"
