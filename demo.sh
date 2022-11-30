# install k3d
curl -s https://raw.githubusercontent.com/rancher/k3d/master/install.sh | bash
# create cluster
k3d cluster create demo --no-lb --k3s-arg '--disable=traefik@server:*' --k3s-arg '--disable=metrics-server@server:*'
# install k9s
curl -sS https://webinstall.dev/k9s | bash
#  get zarf binary and zarf init from my binaries
wget -O zarf "https://zarfbinariessa01.blob.core.windows.net/binaries/bin/zarf?sp=r&st=2022-11-30T10:52:46Z&se=2022-11-30T18:52:46Z&spr=https&sv=2021-06-08&sr=b&sig=Vcf%2BgvKIHv%2B%2FM3pYqyr%2FSkthlickz3eDKY2qr4aPcjM%3D"
wget -O zarf-init-amd64-v0.22.2.tar.zst "https://zarfbinariessa01.blob.core.windows.net/binaries/bin/zarf-init-amd64-v0.22.2.tar.zst?sp=r&st=2022-11-30T10:53:21Z&se=2022-11-30T18:53:21Z&spr=https&sv=2021-06-08&sr=b&sig=Y6BABjlq2CaXZFhOwS5Pd24uDs9n7JbzHMJ9IpLYk70%3D"
chmod a+x zarf
sudo mv zarf /usr/local/bin

echo "create package for game"
cd zarf-manifest/game
zarf package create --skip-sbom 
echo "deploying the package"
zarf package deploy ./zarf-package-dos-games-amd64.tar.zst 
