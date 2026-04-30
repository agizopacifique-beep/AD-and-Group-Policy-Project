<#
.SYNOPSIS
    Automates employee offboarding in Active Directory.

.DESCRIPTION
    Disables the user account, removes from all security groups,
    moves account to Disabled Accounts OU, and logs offboarding
    details. Reduces offboarding time to under 2 minutes and
    ensures immediate access revocation.

.PARAMETER Username
    The SamAccountName of the employee being offboarded.

.EXAMPLE
    .\Remove-EmployeeAccess.ps1 -Username "jsmith"

.NOTES
    Author: [Your Name]
    Date: April 2026
    Requires: Active Directory PowerShell Module
    Run As: Domain Administrator
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$Username
)

Import-Module ActiveDirectory

$domainDN      = "DC=techbridge,DC=local"
$disabledOU    = "OU=Disabled Accounts,$domainDN"
$logFile       = "C:\Logs\Offboarding-$(Get-Date -Format 'yyyy-MM-dd').log"
$timestamp     = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Create log directory if needed
if (-not (Test-Path "C:\Logs")) {
    New-Item -ItemType Directory -Path "C:\Logs" | Out-Null
}

Write-Host "`nStarting offboarding for $Username..." -ForegroundColor Cyan

# Verify user exists
try {
    $user = Get-ADUser -Identity $Username -Properties MemberOf, DisplayName
    Write-Host "User found: $($user.DisplayName)" -ForegroundColor Green
}
catch {
    Write-Host "User not found: $Username" -ForegroundColor Red
    exit
}

# Disable account
try {
    Disable-ADAccount -Identity $Username
    Write-Host "Account disabled: $Username" -ForegroundColor Green
}
catch {
    Write-Host "Error disabling account: $_" -ForegroundColor Red
}

# Remove from all groups except Domain Users
try {
    $groups = $user.MemberOf
    foreach ($group in $groups) {
        Remove-ADGroupMember -Identity $group -Members $Username -Confirm:$false
    }
    Write-Host "Removed from all security groups" -ForegroundColor Green
}
catch {
    Write-Host "Error removing from groups: $_" -ForegroundColor Red
}

# Move to Disabled Accounts OU
try {
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $disabledOU
    Write-Host "Account moved to Disabled Accounts OU" -ForegroundColor Green
}
catch {
    Write-Host "Error moving account: $_" -ForegroundColor Red
}

# Log offboarding
$logEntry = "$timestamp | OFFBOARDED | $Username | $($user.DisplayName)"
Add-Content -Path $logFile -Value $logEntry
Write-Host "Offboarding logged to $logFile" -ForegroundColor Green

Write-Host "`nOffboarding complete for $($user.DisplayName)`n" -ForegroundColor Cyan
