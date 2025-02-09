# Verificar se o Python está instalado
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python não está instalado. Por favor, instale o Python primeiro." -ForegroundColor Red
    Exit 1
}

# Verificar se o pip está instalado
$pipVersion = python -m pip --version 2>$null

if (-not $pipVersion) {
    Write-Host "Pip não está instalado. Instalando o Pip..." -ForegroundColor Yellow
    try {
        # Fazer download do get-pip.py
        $pipInstallerUrl = "https://bootstrap.pypa.io/get-pip.py"
        $pipInstallerPath = "$env:Temp\get-pip.py"

        Invoke-WebRequest -Uri $pipInstallerUrl -OutFile $pipInstallerPath -UseBasicParsing

        # Executar o script para instalar o pip
        python $pipInstallerPath
        Remove-Item $pipInstallerPath

        Write-Host "Pip foi instalado com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "Falha ao instalar o Pip: $_" -ForegroundColor Red
        Exit 1
    }
} else {
    Write-Host "Pip já está instalado. Atualizando o Pip..." -ForegroundColor Yellow
    try {
        python -m pip install --upgrade pip
        Write-Host "Pip foi atualizado com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "Falha ao atualizar o Pip: $_" -ForegroundColor Red
        Exit 1
    }
}
