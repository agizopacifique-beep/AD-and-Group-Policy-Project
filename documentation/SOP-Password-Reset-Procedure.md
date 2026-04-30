# SOP: Password Reset Procedure

## Document Information
| | |
|---|---|
| **Document Title** | Password Reset Standard Operating Procedure |
| **Department** | Information Technology |
| **Author** | [Your Name] |
| **Date** | April 2026 |
| **Version** | 1.0 |
| **Status** | Active |

## Purpose
Provide a secure and consistent process for resetting Active
Directory user passwords while verifying identity to prevent
unauthorized account access.

## Scope
Applies to all domain user accounts on techbridge.local
requiring a password reset due to forgotten passwords,
account lockouts, or security incidents.

## Prerequisites
- Domain Administrator or Help Desk credentials
- Verified identity of requesting user
- Active Directory Users and Computers or PowerShell access

## Identity Verification
Before resetting any password, verify the user's identity
using at least two of the following:

- [ ] Employee ID number
- [ ] Manager name
- [ ] Department and job title
- [ ] Date of birth on file with HR

## Procedure

### Step 1: Receive Reset Request
- User contacts IT helpdesk via phone, ticket, or in person
- Never process password reset requests via email alone
- Document request in ticketing system

### Step 2: Verify User Identity
- Ask for two identity verification items listed above
- If identity cannot be verified escalate to IT Manager
- Do not proceed without successful identity verification

### Step 3: Reset Password
Via PowerShell:
```powershell
Set-ADAccountPassword -Identity "jsmith" `
    -Reset `
    -NewPassword (ConvertTo-SecureString "TempReset@2026!" -AsPlainText -Force)

Set-ADUser -Identity "jsmith" -ChangePasswordAtLogon $true
```
Or via AD Users and Computers:
- Right-click user account > Reset Password
- Enter temporary password: `TempReset@2026!`
- Check "User must change password at next logon"
- Click OK

### Step 4: Unlock Account if Needed
```powershell
Unlock-ADAccount -Identity "jsmith"
```

### Step 5: Communicate New Password
- Provide temporary password via phone only
- Never send passwords via email or chat
- Confirm user can log in successfully
- Close helpdesk ticket

## Completion Checklist
- [ ] Identity verified with two factors
- [ ] Password reset with temporary credential
- [ ] User must change at next logon enforced
- [ ] Account unlocked if locked out
- [ ] New password communicated securely
- [ ] Helpdesk ticket closed and logged

## Security Notes
- Temporary passwords expire at first login
- Never reuse previous passwords (10 password history enforced)
- Suspicious reset requests must be escalated to IT Manager
- All resets are logged via AD Audit Policy GPO

## Related Documents
- SOP-New-User-Onboarding.md
- group-policy/password-policy.md
