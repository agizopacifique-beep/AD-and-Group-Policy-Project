<#
.SYNOPSIS
    Audits Active Directory for inactive user accounts.

.DESCRIPTION
    Identifies user accounts with no login activity within a
    specified number of days. Exports results to CSV for
    administrator review before any account action is taken.
    Supports ongoing access control hygiene and compliance.

.PARAMETER DaysInactive
    Number of days without login to flag account as inactive.
    Default is 30 days.

.EXAMPLE
    .\Get-InactiveAccounts.ps1 -DaysInactive 30

.NOTES
    Author: [Your Name]
    Date: April 2026
    Requires: Active Directory PowerShell Module
    Run As: Domain Administrator
#>

param (
    [int]$DaysInactive = 30
)

Import-Module ActiveDirectory

$cutoffDate  = (Get-Date).AddDays(-$DaysInactive)
$reportPath  = "C:\Reports\Inactive-Accounts-$(Get-Date -Format 'yyyy-MM-dd').csv"
$timestamp   = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Create reports directory if needed
if (-not (Test-Path "C:\Reports")) {
    New-Item -ItemType Directory -Path "C:\Reports" | Out-Null
}

Write-Host "`nScanning for accounts inactive for $DaysInactive+ days..." -ForegroundColor Cyan

$inactiveUsers = Get-ADUser -Filter {
    LastLogonDate -lt $cutoffDate -and Enabled -eq $true
} -Properties LastLogonDate, Department, EmailAddress |
Select-Object `
    Name,
    SamAccountName,
    Department,
    EmailAddress,
    LastLogonDate,
    @{Name="DaysInactive"; Expression={
        (New-TimeSpan -Start $_.LastLogonDate -End (Get-Date)).Days
    }}

if ($inactiveUsers.Count -eq 0) {
    Write-Host "No inactive accounts found." -ForegroundColor Green
}
else {
    $inactiveUsers | Export-Csv -Path $reportPath -NoTypeInformation
    Write-Host "Found $($inactiveUsers.Count) inactive accounts" -ForegroundColor Yellow
    Write-Host "Report exported to: $reportPath" -ForegroundColor Green
    $inactiveUsers | Format-Table -AutoSize
}

Write-Host "`nAudit complete: $timestamp`n" -ForegroundColor Cyan
