# teoria-2021-mar
codigo visto en clase de teoria de la computacion, marzo 2021

## Instalar haskell
### Windows
Abrir powershell como **administrador** y poner:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
(Opcional) Instalar interfaz grafica para chocolatey `choco install chocolateygui`

Instalar haskell-platform:
    - Por consola, en un powershell como administrador (puede ser el anterior) poner `choco install haskell-platform`
    - Por la gui, abrir chocolatey gui, en la seccion chocolatey (la que esta a la izquierda) buscar haskell-platform, instalar

### Linux
  - Debian/Ubuntu y derivados `sudo apt-get install haskell-platform`
  - RHEL `sudo yum install haskell-platform`
  - Fedora `sudo dnf install haskell-platform`
  - Generico `curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`

### MacOS
1. Instalar Xcode
2. Instalar haskell
    - Mac Intel, en terminal poner `curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`
    - Mac M1 (de las nuevas), poner `curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | arch -x86_64 /bin/bash`
