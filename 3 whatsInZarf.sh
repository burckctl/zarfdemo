#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "$CURR_DIR" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

source "$CURR_DIR/helpers/common.sh";

section "Looking under the hood"

# download the required binaries
info_pause_exec "Connect to GitEA" "zarf connect git"
info_pause_exec "Connect to harbor" "zarf connect registry"

section "Deploy sample in default"
info_pause_exec "Deploy sample in default ns" "kubectl apply -f sampleAlpine.yaml -n default"

section "Deploy sample in zarf managed"
info_pause_exec "Deploy sample in zarf ns" "kubectl apply -f sampleAlpine.yaml -n zarf"
