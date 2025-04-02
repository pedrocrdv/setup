# _Setup_

Este repositório contém instruções e recursos para configuração do Windows 11, Debian e outros _softwares_.

> Esta configuração é personalizada de acordo com minhas preferências e necessidades.
>
> O uso do Windows 11 como sistema operacional é um requisito do meu atual trabalho profissional.
>
> Prefiro instalar e configurar esses _softwares_ de forma manual e imperativa para controle e aprendizado.

Os comandos deste documento foram escritos para serem executados com o [PowerShell](https://learn.microsoft.com/en-us/powershell/).

## Conteúdos

- [Conteúdos](#conteúdos)
- [_Softwares_](#softwares)
- [`winget`](#winget)
  - [Manutenção](#manutenção)
- [`wsl`](#wsl)
  - [Manutenção](#manutenção-1)
  - [Debian](#debian)
    - [`apt`](#apt)
      - [Manutenção](#manutenção-2)
    - [`brew`](#brew)
      - [Manutenção](#manutenção-3)
- [Repositório](#repositório)
  - [_Resources_](#resources)
  - [_Scritps_](#scritps)
- [`chrome`](#chrome)
- [Manutenção do Windows](#manutenção-do-windows)
  - [Atualizações](#atualizações)
  - [Pacotes _Appx_](#pacotes-appx)

## _Softwares_

Os principais _softwares_ instalados com as instruções deste repositório são:

- [`7z`](https://7-zip.org)
- [`bat`](https://github.com/sharkdp/bat)
- [`brew`](https://github.com/Homebrew/brew)
- [`carapace`](https://github.com/carapace-sh/carapace)
- [`chrome`](https://www.google.com/chrome)
- [`code`](https://code.visualstudio.com)
- [`docker`](https://docs.docker.com/engine)
- [`fish`](https://github.com/fish-shell/fish-shell)
- [`gcloud`](https://cloud.google.com/sdk/docs/install)
- [`gh`](https://github.com/cli/cli)
- [`git`](https://git-scm.com)
- [`podman`](https://github.com/containers/podman)
- [`pwsh`](https://learn.microsoft.com/en-us/powershell)
- [`starship`](https://github.com/starship/starship)
- [`uv`](https://github.com/astral-sh/uv)
- [`winget`](https://github.com/microsoft/winget-cli)
- [`wsl`](https://learn.microsoft.com/en-us/windows/wsl)
- [`yaak`](https://github.com/mountain-loop/yaak)

## `winget`

Certifique-se de que o `winget` está instalado.

Baixe e instale o `winget` manualmente na [Microsoft Store](https://apps.microsoft.com/detail/9NBLGGH4NNS1) caso necessário.

```powershell
winget --version
```

Inicie o PowerShell como administrador e instale os _softwares_ especificados abaixo.

> Os comandos abaixo foram escritos como estão para que seja possível executá-los individualmente.

```powershell
winget install --source "winget" --id "Yaak.app"
winget install --source "winget" --scope "machine" --id "7zip.7zip"
winget install --source "winget" --scope "machine" --id "Git.Git" --override '/VERYSILENT /NODESKTOPICON /NOEXPLORER /COMPONENTS="icons,gitlfs" /NOASSOC /NOSCALAR /PATH'
winget install --source "winget" --scope "machine" --id "GitHub.cli"
winget install --source "winget" --scope "machine" --id "Google.Chrome"
winget install --source "winget" --scope "machine" --id "lsd-rs.lsd"
winget install --source "winget" --scope "machine" --id "Microsoft.PowerShell"
winget install --source "winget" --scope "machine" --id "Microsoft.VisualStudioCode" --override '/VERYSILENT /MERGETASKS="!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatefiles,path"'
winget install --source "winget" --scope "machine" --id "Starship.Starship"
```

> Os _softwares_ especificados abaixo são utilizados apenas em meu trabalho profissional.

```powershell
winget install --source "winget" --scope "machine" --id "Microsoft.PowerBI"
winget install --source "winget" --scope "user" --id "Microsoft.Teams"
```

### Manutenção

Execute `winget list` para listar os _softwares_ instalados.

Utilize a _flag_ `--upgrade-available` para listar apenas os _softwares_ que possuam atualizações disponíveis.

```bash
winget list --source "winget" --scope "machine"

winget list --source "winget" --scope "machine" --upgrade-available
```

Execute `winget upgrade` para atualizar _softwares_ especificados.

Utilize a _flag_ `--all` para atualizar todos os _softwares_ que possuam atualizações disponíveis.

```powershell
winget upgrade --source "winget" --scope "machine" --id "Git.Git"

winget upgrade --source "winget" --scope "machine" --all
```

Execute `winget uninstall` para desinstalar um _software_ especificado.

```powershell
winget uninstall --source "winget" --scope "machine" --id "Git.Git" --all-versions --purge
```

## `wsl`

Instale o `wsl`.

```powershell
wsl --install --no-distribution
Restart-Computer
```

Instale a distribuição Debian no `wsl`.

```powershell
wsl --install "Debian"
```

Configure a distribuição Debian como padrão do `wsl`.

```powershell
wsl --set-default "Debian"
```

### Manutenção

Execute `wsl --update` para atualizar o WSL.

```powershell
wsl --update
```

### Debian

Os comandos desta seção foram escritos para serem executados com o [Bash](https://manpages.debian.org/stretch/bash/bash.1.en.html).

#### `apt`

Utilizando o [`apt`](https://manpages.debian.org/stretch/apt/apt.8.en.html), sincronize os índices de pacotes e instale as atualizações disponíveis.

```bash
sudo apt update && sudo apt upgrade --assume-yes
```

Instale os pacotes especificados abaixo.

```bash
sudo apt install --assume-yes "apt-transport-https" "bat" "build-essential" "ca-certificates" "curl" "file" "fish" "git" "gnupg" "podman" "procps" "unzip" "wget" "zip"
```

Crie o diretório `/etc/apt/keyrings/` com as permissões `0755`, para armazenar chaves GPG.

```bash
sudo install --mode="0755" --directory "/etc/apt/keyrings/"
```

Baixe e converta as chaves GPG especificadas abaixo, salvando-as no diretório `/etc/apt/keyrings/`.

```bash
sudo curl --fail "https://download.docker.com/linux/debian/gpg" | sudo gpg --dearmor --yes --output="/etc/apt/keyrings/docker.gpg"
sudo curl --fail "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | sudo gpg --dearmor --yes --output="/etc/apt/keyrings/gcloud.gpg"
sudo curl --fail "https://cli.github.com/packages/githubcli-archive-keyring.gpg" | sudo gpg --dearmor --yes --output="/etc/apt/keyrings/gh.gpg"
```

Adicione os repositórios especificados abaixo como fontes de pacotes para o `apt`.

Em seguida, com as novas fontes, sincronize os índices de pacotes.

```bash
echo "deb [signed-by=/etc/apt/keyrings/docker.gpg arch=amd64] https://download.docker.com/linux/debian bookworm stable" | sudo tee "/etc/apt/sources.list.d/docker.list" > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/gcloud.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee "/etc/apt/sources.list.d/google-cloud-sdk.list" > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/gh.gpg arch=amd64] https://cli.github.com/packages stable main" | sudo tee "/etc/apt/sources.list.d/github-cli.list" > /dev/null

sudo apt update
```

Instale os pacotes especificados abaixo.

```bash
sudo apt install --assume-yes "docker-ce" "docker-ce-cli" "containerd.io" "docker-buildx-plugin" "docker-compose-plugin"
sudo apt install --assume-yes "google-cloud-cli"
sudo apt install --assume-yes "gh"
```

Adiciona o usuário referenciado pela variável `$USER` ao grupo `"docker"`.

```bash
sudo usermod --append --groups "docker" "$USER"
```

##### Manutenção

Execute `apt list` para listar os pacotes instalados.

Utilize a _flag_ `--upgradable` para listar apenas os pacotes que possuam atualizações disponíveis.

```bash
apt list --installed

apt list --upgradable
```

Execute `apt purge` para remover um pacote especificado.

```bash
sudo apt purge "git" --assume-yes
```

Execute `apt autoremove` para remover pacotes desnecessários.

```bash
sudo apt autoremove
```

#### `brew`

Baixe e execute o _script_ de instalação do Homebrew.

```bash
bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Instale os pacotes especificados abaixo.

```bash
/home/linuxbrew/.linuxbrew/bin/brew install --formula "carapace" "gcc" "lsd" "starship" "uv"
```

##### Manutenção

Execute `brew update` para atualizar o Homebrew.

```bash
brew update
```

Execute `brew list` para listar os pacotes instalados.

Utilize a _flag_ `--installed-on-request` para listar apenas os pacotes instalados manualmente.

```bash
brew list --formula --versions

brew  list --formula --installed-on-request -1
```

Execute `brew outdated` para listar os pacotes instalados que possuam atualizações disponíveis.

```bash
brew outdated --formula
```

Execute `brew upgrade` para atualizar _softwares_ especificados ou todos que possuam atualizações disponíveis.

```bash
brew upgrade --formula "git"

brew upgrade --formula
```

Execute `apt autoremove` para remover pacotes desnecessários.

```bash
brew autoremove
```

Execute `apt cleanup` para remover arquivos desnecessários.

```bash
brew cleanup --prune=all
```

Execute `apt uninstall` para remover um pacote especificado.

```bash
brew uninstall --formula "git"
```

## Repositório

Configure o `gh`.

```powershell
gh auth login --git-protocol="https" --hostname="github.com" --web
```

Clone esse repositório.

> Eu utilizo o diretório `$Env:USERPROFILE/shards/` para salvar repositórios no Windows 11.

```powershell
New-Item -Path "$Env:USERPROFILE" -Name "shards" -ItemType "Directory" -Force

git clone "https://github.com/pedrocrvs/setup.git" $PathRepository "$Env:USERPROFILE/shards/setup"

Set-Location "$Env:USERPROFILE/shards/setup"; git lfs pull
```

### _Resources_

O diretório [`resources/`](resources/) contém arquivos de configuração dos _softwares_ especificados nas seções anteriores.

Por exemplo, o arquivo [`.gitconfig`](resources/git/.gitconfig) para o `git`.

### _Scritps_

O diretório [`scripts/`](scripts/) contém _scripts_ que configuram os _softwares_.

Esses _scripts_ criam _symbolic links_ nos locais esperados pelos _softwares_, apontando para os arquivos em [`resources/`](resources/).

Inicie o PowerShell como administrador e execute o comando abaixo para ativar o _developer mode_ no Windows 11.

O _developer mode_ é necessário para permitir a criação de _symbolic links_ sem permissões de administrador.

```powershell
New-ItemProperty `
    -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" `
    -Name "AllowDevelopmentWithoutDevLicense" `
    -Value 1 `
    -PropertyType DWORD `
    -Force
```

O comando abaixo é um exemplo de como executar um dos _scripts_ individualmente.

```powershell
& ".\powershell\configure-windows-vscode.ps1"
```

Os _scripts_ em [`scripts/administrator/`](scripts/administrator/) só podem ser executados como administrador.

## `chrome`

A configuração do Google Chrome deve ser feita manualmente. Para isso, acesse `chrome://flags`.

Desabilite as _flags_ especificadas abaixo.

- `#autofill-enable-save-and-fill`
- `#autofill-improved-labels`
- `#enable-autofill-credit-card-upload`
- `#fluent-overlay-scrollbars`
- `#fluent-scrollbars`
- `#overlay-scrollbars`
- `#pwm-show-suggestions-on-autofocus`
- `#show-autofill-type-predictions`

Habilite as _flags_ especificadas abaixo.

- `#autofill-remove-payments-butter-dropdown`
- `#enable-gpu-rasterization`
- `#enable-parallel-downloading`
- `#enable-zero-copy`
- `#smooth-scrolling`
- `#threaded-scroll-prevent-rendering-starvation`

## Manutenção do Windows

Inicie o PowerShell como administrador para executar os comandos desta seção.

### Atualizações

Execute os comandos abaixo para tentar solucionar uma atualização mal sucedida do Windows.

```powershell
Stop-Service -Name "bits" -Force
Stop-Service -Name "cryptsvc" -Force
Stop-Service -Name "wuauserv" -Force
Remove-Item -Path "C:\Windows\SoftwareDistribution\" -Recurse -Force
Remove-Item -Path "C:\Windows\System32\catroot2" -Recurse -Force
Invoke-Expression -Command "sfc /scannow"
Invoke-Expression -Command "DISM /Online /Cleanup-Image /RestoreHealth"
Restart-Computer
```

### Pacotes _Appx_

Execute os comandos abaixo para listar e remover pacotes _Appx_ do Windows.

```powershell
(Get-AppxPackage -AllUsers) + (Get-AppxPackage) | Where-Object { -not $_.NonRemovable } | Select-Object -Property "Name", "PackageFullName" -Unique | Sort-Object -Property "Name"

Remove-AppxPackage -AllUsers -Package ""
```

Execute os comandos abaixo para listar e remover pacotes _Appx_ provisionados pelo Windows.

```powershell
Get-AppxProvisionedPackage -Online | Select-Object -Property "DisplayName", "PackageName"

Remove-AppxProvisionedPackage -Online -PackageName ""
```
