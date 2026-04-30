# SOP: Employee Offboarding

## Document Information
| | |
|---|---|
| **Document Title** | Employee Offboarding Standard Operating Procedure |
| **Department** | Information Technology |
| **Author** | [Your Name] |
| **Date** | April 2026 |
| **Version** | 1.0 |
| **Status** | Active |

## Purpose
Ensure immediate and complete revocation of system access
for departing employees to protect company data, maintain
security compliance, and reduce insider threat exposure.

## Scope
Applies to all departing employees including resignations,
terminations, and contract endings across all departments.

## Prerequisites
- Domain Administrator credentials
- Notification from HR of employee departure
- Employee SamAccountName

## Procedure

### Step 1: Receive Offboarding Notification
- HR notifies IT of departure date and employee details
- For immediate terminations, execute same day
- For resignations, schedule for last day of employment

### Step 2: Disable User Account
Run the offboarding script:
```powershell
.\Remove-EmployeeAccess.ps1 -Username "jsmith"
```
Or manually in AD Users and Computers:
- Locate user account in departmental OU
- Right-click > Disable Account
- Confirm account shows disabled icon

### Step 3: Remove Group Memberships
- Open user Properties > Member Of tab
- Remove from all security groups except Domain Users
- Click Apply > OK

### Step 4: Move to Disabled Accounts OU
- Right-click disabled account > Move
- Select Disabled Accounts OU
- Click OK

### Step 5: Log Offboarding Action
Document the following in the offboarding log:
- Employee name and username
- Date and time of account disable
- Administrator who performed offboarding
- Ticket or request number if applicable

### Step 6: Verify Access Revocation
- Attempt login with disabled account to confirm access denied
- Confirm account no longer appears in any security groups
- Verify account moved to Disabled Accounts OU

## Completion Checklist
- [ ] Account disabled immediately upon departure
- [ ] Removed from all security groups
- [ ] Account moved to Disabled Accounts OU
- [ ] Offboarding logged with timestamp
- [ ] Access revocation verified
- [ ] HR notified of completion

## Retention Policy
Disabled accounts are retained in the Disabled Accounts OU
for 90 days for audit purposes then permanently deleted.

## Expected Completion Time
Under 2 minutes per user

## Related Documents
- SOP-New-User-Onboarding.md
- scripts/Remove-EmployeeAccess.ps1
