# Define o caminho do arquivo com os IPs
$filePath = ".\IPs.txt"
$COMUNIDADE = Read-Host "Informe a comunidade SNMP"
$VERSAO = Read-Host "Informe a versão SNMP"
 
Write-Host "`n"  # Adiciona uma quebra de linha após cada conjunto de comandos para um IP
 
# Função para execução do SNMPWalk
function ExecuteSnmpWalk {
    param (
        [string]$IP,
        [string]$command
    )
 
    try {
        Write-Host "O SysName do $IP é:"
        $result = Invoke-Expression ($command -replace "`$IP", $IP)
        if ($result -eq $null -or $result -match "OID=.1.3.6.1.2.1.1.5.0,") {
            $result | Select-Object -Index (3) | ForEach-Object { $_.Split('=')[3].Trim() } # Adiciona uma quebra de linha após cada bloco
        }
        else {
            # Exibição apenas do valor com delimitador do terceiro '=' da saída SNMPWalk
            Write-Host "Não comunicável"
        }
 
    }
    catch [System.Net.WebException] {
            Write-Host "Timeout ao se conectar ao IP $IP."
            # Adicione a lógica de tratamento de timeout aqui, se necessário
        }
    }
 
# Verifica se o arquivo existe
if (Test-Path $filePath) {
    # Lê os IPs do arquivo
    $IPs = Get-Content $filePath
 
    # Define os comandos a serem executados
    $commands = @(
        ".\SnmpWalk.exe -r:`$IP -c:$COMUNIDADE -v:$VERSAO -os:1.3.6.1.2.1.1.4.0 -op:1.3.6.1.2.1.1.5.0"
    )
 
    # Executa os comandos para cada IP
    foreach ($IP in $IPs) {
        foreach ($command in $commands) {
            ExecuteSnmpWalk -IP $IP -command $command
        }
        Write-Host "`n"  # Adiciona uma quebra de linha após cada conjunto de comandos para um IP
    }
} else {
    Write-Host "O arquivo $filePath não foi encontrado."
}
