<#
.SYNOPSIS
    Automates new employee onboarding in Active Directory.

.DESCRIPTION
    Creates a new AD user account, assigns department OU placement,
    adds user to appropriate security groups, and enforces password
    policy compliance. Reduces onboarding time from 45 minutes to
    under 10 minutes.

.PARAMETER FirstName
    Employee first name.

.PARAMETER LastName
    Employee last name.

.PARAMETER Department
    Employee department. Accepted values: IT, HR, Finance.

.EXAMPLE
    .\New-EmployeeOnboarding.ps1 -FirstName "John" -LastName "Smith" -Department "IT"

.NOTES
    Author: [Your Name]
    Date: April 2026
    Requires: Active Directory PowerShell Module
    Run As: Domain Administrator
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$FirstName,

    [Parameter(Mandatory = $true)]
    [string]$LastName,

    [Parameter(Mandatory = $true)]
    [ValidateSet("IT", "HR", "Finance")]
    [string]$Department
)

Import-Module ActiveDirectory

# Variables
$domainDN    = "DC=techbridge,DC=local"
$domain      = "techbridge.local"
$username    = ($FirstName[0] + $LastName).ToLower()
$displayName = "$FirstName $LastName"
$upn         = "$username@$domain"
$ouPath      = "OU=$Department,OU=TechBridge Users,$domainDN"
$password    = ConvertTo-SecureString "Welcome@2026!" -AsPlainText -Force

$groupMap = @{
    IT      = "IT-Admins"
    HR      = "HR-Staff"
    Finance = "Finance-Staff"
}

Write-Host "`nStarting onboarding for $displayName..." -ForegroundColor Cyan

# Create AD user
try {
    New-ADUser `
        -Name $displayName `
        -GivenName $FirstName `
        -Surname $LastName `
        -SamAccountName $username `
        -UserPrincipalName $upn `
        -Path $ouPath `
        -Department $Department `
        -AccountPassword $password `
        -Enabled $true `
        -PasswordNeverExpires $false `
        -ChangePasswordAtLogon $true

    Write-Host "User account created: $username" -ForegroundColor Green
}
catch {
    Write-Host "Error creating user: $_" -ForegroundColor Red
    exit
}

# Add to department security group
try {
    Add-ADGroupMember -Identity $groupMap[$Department] -Members $username
    Add-ADGroupMember -Identity "All-Users" -Members $username
    Write-Host "Added to groups: $($groupMap[$Department]), All-Users" -ForegroundColor Green
}
catch {
    Write-Host "Error adding to groups: $_" -ForegroundColor Red
}

Write-Host "`nOnboarding complete for $displayName" -ForegroundColor Cyan
Write-Host "Username : $username" -ForegroundColor White
Write-Host "UPN      : $upn" -ForegroundColor White
Write-Host "OU       : $ouPath" -ForegroundColor White
Write-Host "Temp Pass: Welcome@2026! (must change at first login)`n" -ForegroundColor Yellow
