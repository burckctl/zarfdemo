#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "$CURR_DIR" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

# shellcheck source=./common.sh
source "$CURR_DIR/helpers/common.sh";

section "CREATE ZARF PACKAGE"
# Download and install zarf
section "Install Zarf"
info_pause_exec "Download zarf" "wget -O zarf https://zarfbinariessa01.blob.core.windows.net/binaries/bin/zarf?sp=r&st=2022-11-30T10:52:46Z&se=2022-11-30T18:52:46Z&spr=https&sv=2021-06-08&sr=b&sig=Vcf%2BgvKIHv%2B%2FM3pYqyr%2FSkthlickz3eDKY2qr4aPcjM%3D"
info_pause_exec "Installing zarf" "chmod a+x zarf && sudo mv zarf /usr/local/bin"

# pause to inspect 
section "Inspect a Zarf manifest example"
proceed_or_not "Pause and validate the zarf manifest of game example. Proceed?"

# create zarf package
section "Creating package"
info_pause_exec "Create zarf package" "cd zarf-manifest/game && zarf package create --skip-sbom"
