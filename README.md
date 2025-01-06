# _Setup_

Este repositório contém instruções e recursos para configuração do Windows 11, Debian e outros _softwares_.

> Esta configuração é personalizada de acordo com minhas preferências e necessidades.
>
> O uso do Windows 11 como sistema operacional é um requisito do meu atual emprego.
>
> Prefiro instalar e configurar esses _softwares_ de forma manual e imperativa para controle e aprendizado.

Os comandos deste documento foram escritos para serem executados no PowerShell.

## _Softwares_

Os principais _softwares_ instalados com as instruções deste repositório são:

- [`7z`](https://7-zip.org)
- [`alacritty`](https://github.com/alacritty/alacritty)
- [`brew`](https://github.com/Homebrew/brew)
- [`carapace`](https://github.com/carapace-sh/carapace)
- [`code`](https://code.visualstudio.com)
- [`docker`](https://docs.docker.com/desktop/setup/install/linux/debian)
- [`fish`](https://github.com/fish-shell/fish-shell)
- [`gcloud`](https://cloud.google.com/sdk/docs/install)
- [`gh`](https://github.com/cli/cli)
- [`git`](https://git-scm.com)
- [`lsd`](https://github.com/lsd-rs/lsd)
- [`pwsh`](https://learn.microsoft.com/en-us/powershell)
- [`starship`](https://github.com/starship/starship)
- [`uv`](https://github.com/astral-sh/uv)
- [`winget`](https://github.com/microsoft/winget-cli)
- [`wsl`](https://learn.microsoft.com/en-us/windows/wsl)

## `winget`

Certifique-se de que o `winget` está instalado.

```powershell
winget --version
```

Baixe e instale o `winget` manualmente na [Microsoft Store](https://apps.microsoft.com/detail/9NBLGGH4NNS1) caso necessário.

Inicie o PowerShell como administrador e instale os _softwares_ especificados abaixo.

> Os comandos abaixo foram escritos como estão para que seja possível executá-los individualmente.

```powershell
winget install --source "winget" --scope "machine" --id "Microsoft.VCRedist.2015+.x64"
winget install --source "winget" --scope "machine" --id "Microsoft.VCRedist.2015+.x86"
winget install --source "winget" --scope "machine" --id "7zip.7zip"
winget install --source "winget" --scope "machine" --id "Alacritty.Alacritty"
winget install --source "winget" --scope "machine" --id "Git.Git" --override '/VERYSILENT /NODESKTOPICON /NOEXPLORER /COMPONENTS="icons,gitlfs" /NOASSOC /NOSCALAR /PATH'
winget install --source "winget" --scope "machine" --id "GitHub.cli"
winget install --source "winget" --scope "machine" --id "lsd-rs.lsd"
winget install --source "winget" --scope "machine" --id "Microsoft.PowerShell"
winget install --source "winget" --scope "machine" --id "Microsoft.VisualStudioCode" --override '/VERYSILENT /MERGETASKS="!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatefiles,path"'
winget install --source "winget" --scope "machine" --id "Starship.Starship"
```

## `wsl`

Instale ou atualize o `wsl`.

```powershell
wsl --install --no-distribution
wsl --update
```

Instale a distribuição Debian no `wsl`.

```powershell
wsl --install "Debian"
```

Configure a distribuição Debian como padrão do `wsl`.

```powershell
wsl --set-default "Debian"
```

### Debian

Os comandos desta seção foram escritos para serem executados no [Bash](https://manpages.debian.org/stretch/bash/bash.1.en.html).

Utilizando o [`apt`](https://manpages.debian.org/stretch/apt/apt.8.en.html), sincronize os índices de pacotes e instale as atualizações disponíveis.

```bash
sudo apt update && sudo apt upgrade --assume-yes
```

Instale os pacotes especificados abaixo.

```bash
sudo apt install --assume-yes "apt-transport-https" "build-essential" "ca-certificates" "curl" "file" "fish" "git" "gnupg" "procps" "wget"
```

Crie o diretório `/etc/apt/keyrings/` com as permissões `0755`, para armazenar chaves GPG.

```bash
sudo install --mode="0755" --directory "/etc/apt/keyrings/"
```

Baixe e converta as chaves GPG especificadas abaixo, salvando-as no diretório `/etc/apt/keyrings/`.

```bash
sudo curl --fail "https://download.docker.com/linux/debian/gpg" | sudo gpg --dearmor --yes --output="/etc/apt/keyrings/docker.gpg"
sudo curl --fail "https://packages.cloud.google.com/apt/doc/apt-key.gpg" | sudo gpg --dearmor --yes --output="/etc/apt/keyrings/cloud.google.gpg"
sudo curl --fail "https://cli.github.com/packages/githubcli-archive-keyring.gpg" | sudo gpg --dearmor --yes --output="/etc/apt/keyrings/githubcli-archive-keyring.gpg"
```

Adicione os repositórios especificados abaixo como fontes de pacotes para o `apt`.

Em seguida, com as novas fontes, sincronize os índices de pacotes.

```bash
echo "deb [signed-by=/etc/apt/keyrings/docker.gpg arch=amd64] https://download.docker.com/linux/debian bookworm stable" | sudo tee "/etc/apt/sources.list.d/docker.list" > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee "/etc/apt/sources.list.d/google-cloud-sdk.list" > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg arch=amd64] https://cli.github.com/packages stable main" | sudo tee "/etc/apt/sources.list.d/github-cli.list" > /dev/null

sudo apt update
```

Instale os pacotes especificados abaixo.

```bash
sudo apt install --assume-yes "containerd.io" "docker-buildx-plugin" "docker-ce-cli" "docker-ce" "docker-compose-plugin"
sudo apt install --assume-yes "google-cloud-cli"
sudo apt install --assume-yes "gh"
```

Adicione o usuário definido na variável `$USER` ao grupo `"docker"`.

```bash
sudo usermod --append --groups "docker" $USER
```

Baixe e execute o _script_ de instalação do Homebrew.

```bash
bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Instale, utilizando o Homebrew, os pacotes especificados abaixo.

```bash
/home/linuxbrew/.linuxbrew/bin/brew install "carapace" "gcc" "lsd" "starship" "uv"
```

## Repositório

Configure o `gh` para clonar esse repositório.

```powershell
gh auth login --git-protocol="https" --hostname="github.com" --web
```

Além das intruções acima, esse repositório possui recursos e _scripts_.

### Recursos

O diretório [`resources/`](resources/) contém arquivos para a configuração dos _softwares_ especificados nas seções anteriores.

Esses recursos consistem principalmente em arquivos de configuração, como o [`.gitconfig`](resources/git/.gitconfig).

### _Scritps_

O diretório [`scripts/`](scripts/) contém _scripts_ que configuram os _softwares_.

Esses _scripts_ majoritariamente copiam arquivos de [`resources/`](resources/) para os locais esperados pelos _softwares_.

O comando abaixo é um exemplo de como executar um dos _scripts_ individualmente.

```powershell
& ".\powershell\configure-windows-vscode.ps1"
```

O comando abaixo executa todos os _scripts_.

```powershell
Get-ChildItem -Path ".\scripts\" -File | ForEach-Object { & $_.FullName }
```

Os _scripts_ em [`scripts/administrator/`](scripts/administrator/) só podem ser executados como administrador.
