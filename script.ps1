# Script para listar membros do grupo SETIN-CIS no domínio tce.pa
# Importa o módulo Active Directory se ainda não estiver carregado
if (-not (Get-Module -Name ActiveDirectory)) {
    Import-Module ActiveDirectory
}

try {
    # Define as variáveis
    $dominio = "tce.pa"
    $grupo = "CIS"

    # Busca os membros do grupo
    $membros = Get-ADGroupMember -Identity $grupo -Server $dominio | 
        Get-ADUser -Properties DisplayName, Title, EmailAddress |
        Select-Object DisplayName, SamAccountName, Title, EmailAddress

    # Exibe o cabeçalho
    Write-Host "`nMembros do grupo $grupo no dominio $dominio`n" -ForegroundColor Green
    
    # Exibe os membros em formato de tabela
    $membros | Format-Table -AutoSize

    # Exibe o total de membros
    Write-Host "`nTotal de membros: $($membros.Count)" -ForegroundColor Yellow
}
catch {
    Write-Host "Erro ao buscar membros do grupo: $($_.Exception.Message)" -ForegroundColor Red
}