# Ejecutar PowerShell como Administrador
$HostsFile = "$env:SystemRoot\System32\drivers\etc\hosts"
$Line = "127.0.0.1 jenkins gitlab artifactory"
$Content = Get-Content $HostsFile -ErrorAction Stop

if (($Content -match "jenkins") -and ($Content -match "gitlab") -and ($Content -match "artifactory")) {
    Write-Host "Las entradas jenkins/gitlab/artifactory ya existen en $HostsFile"
} else {
    Add-Content -Path $HostsFile -Value $Line
    Write-Host "Entradas añadidas: $Line"
}
