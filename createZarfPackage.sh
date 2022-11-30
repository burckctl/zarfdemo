#!/bin/bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )";
[ -d "$CURR_DIR" ] || { echo "FATAL: no current dir (maybe running in zsh?)";  exit 1; }

# shellcheck source=./common.sh
source "$CURR_DIR/helpers/common.sh";

section "SETTING UP ENVIRONMENT FOR CREATING GAME PACKAGE"
info_pause_exec "Install k3d" "curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash"
info_pause_exec "Install k9s" "curl -sS https://webinstall.dev/k9s | bash"
info_pause_exec "Download zarf" "wget -O zarf https://zarfbinariessa01.blob.core.windows.net/binaries/bin/zarf?sp=r&st=2022-11-30T10:52:46Z&se=2022-11-30T18:52:46Z&spr=https&sv=2021-06-08&sr=b&sig=Vcf%2BgvKIHv%2B%2FM3pYqyr%2FSkthlickz3eDKY2qr4aPcjM%3D"
info_pause_exec "Download init package" "wget -O zarf-init-amd64-v0.22.2.tar.zst https://zarfbinariessa01.blob.core.windows.net/binaries/bin/zarf-init-amd64-v0.22.2.tar.zst?sp=r&st=2022-11-30T10:53:21Z&se=2022-11-30T18:53:21Z&spr=https&sv=2021-06-08&sr=b&sig=Y6BABjlq2CaXZFhOwS5Pd24uDs9n7JbzHMJ9IpLYk70%3D"
info_pause_exec "Installing zarf" "chmod a+x zarf && sudo mv zarf /usr/local/bin"

section "CREATING ZARF PACKAGE FOR GAME"
log "Check zarf template"
info_pause_exec "Create zarf package" "cd zarf-manifest/game && zarf package create --skip-sbom"
log "Upload package to SA account"
info_pause_exec_options "upload file" "az storage azcopy blob upload -c binaries --account-name zarfbinariessa01 -s zarf-package-dos-games-amd64.tar.zst && cd .."

