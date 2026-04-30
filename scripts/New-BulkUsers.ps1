<#
.SYNOPSIS
    Creates multiple AD user accounts from a CSV file.

.DESCRIPTION
    Imports employee data from an HR-provided CSV file and
    creates Active Directory accounts in bulk. Assigns each
    user to the correct departmental OU and security group
    automatically based on department field in the CSV.

.PARAMETER CSVPath
    Full path to the CSV file containing employee data.

.EXAMPLE
    .\New-BulkUsers.ps1 -CSVPath "C:\HR\new-employees.csv"

.CSV Format
    FirstName, LastName, Department
    John, Smith, IT
    Beth, Jones, HR
    Mike, Williams, Finance

.NOTES
    Author: [Your Name]
    Date: April 2026
    Requires: Active Directory PowerShell Module
    Run As: Domain Administrator
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$CSVPath
)

Import-Module ActiveDirectory

$domainDN = "DC=techbridge,DC=local"
$domain   = "techbridge.local"

$groupMap = @{
    IT      = "IT-Admins"
    HR      = "HR-Staff"
    Finance = "Finance-Staff"
}

if (-not (Test-Path $CSVPath)) {
    Write-Host "CSV file not found: $CSVPath" -ForegroundColor Red
    exit
}

$employees = Import-Csv -Path $CSVPath
$success   = 0
$failed    = 0

Write-Host "`nProcessing $($employees.Count) employees from CSV...`n" -ForegroundColor Cyan

foreach ($emp in $employees) {
    $username    = ($emp.FirstName[0] + $emp.LastName).ToLower()
    $displayName = "$($emp.FirstName) $($emp.LastName)"
    $upn         = "$username@$domain"
    $ouPath      = "OU=$($emp.Department),OU=TechBridge Users,$domainDN"
    $password    = ConvertTo-SecureString "Welcome@2026!" -AsPlainText -Force

    try {
        New-ADUser `
            -Name $displayName `
            -GivenName $emp.FirstName `
            -Surname $emp.LastName `
            -SamAccountName $username `
            -UserPrincipalName $upn `
            -Path $ouPath `
            -Department $emp.Department `
            -AccountPassword $password `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        Add-ADGroupMember -Identity $groupMap[$emp.Department] -Members $username
        Add-ADGroupMember -Identity "All-Users" -Members $username

        Write-Host "Created: $displayName ($username) - $($emp.Department)" -ForegroundColor Green
        $success++
    }
    catch {
        Write-Host "Failed: $displayName - $_" -ForegroundColor Red
        $failed++
    }
}

Write-Host "`nBulk creation complete" -ForegroundColor Cyan
Write-Host "Successful : $success" -ForegroundColor Green
Write-Host "Failed     : $failed`n" -ForegroundColor Red
