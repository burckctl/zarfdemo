#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "$CURR_DIR" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

# shellcheck source=./common.sh
source "$CURR_DIR/helpers/common.sh";

section "CREATE ZARF PACKAGE"
# Download and install zarf
section "Install Zarf"
proceed_or_not "Downloaded the binary? Proceed?"
info_pause_exec "Installing zarf" "chmod a+x zarf && sudo mv zarf /usr/local/bin"

# pause to inspect 
section "Inspect a Zarf manifest example"
proceed_or_not "Pause and validate the zarf manifest of game example. Proceed?"

# create zarf package
section "Creating package"
info_pause_exec "Create zarf package" "cd zarf-manifest/game && zarf package create --skip-sbom"
