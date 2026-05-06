# SOP: Employee Offboarding

**Department:** Information Technology
**Author:** [Pacifique Agizo]
**Date:** April 2026
**Version:** 1.0

---

## Purpose

When an employee leaves, their access needs to go with them -- immediately. This SOP covers how that happens, whether the departure is planned or not.

The risk window between someone's last day and IT cutting their access is where most insider incidents happen. This process closes that window.

---

## Scope

All departing employees: resignations, terminations, and contract endings across every department.

Terminations are executed the same day notification is received. Resignations are scheduled for the employee's last working day unless security circumstances require earlier action.

---

## What You Need Before Starting

- Domain Administrator credentials
- Employee's SamAccountName (e.g. `jsmith`)
- HR notification confirming the departure

---

## Procedure

### Step 1: Receive the Notification

HR contacts IT with the employee name, username, and departure date. For terminations, that notification triggers immediate action -- not end of day, not tomorrow morning. Same hour if possible.

For resignations, confirm the last working date with HR and schedule the offboarding to run that day before the employee's shift ends.

---

### Step 2: Disable the Account and Strip Access

Run the offboarding script:

```powershell
.\Remove-EmployeeAccess.ps1 -Username "jsmith"
```

The script handles everything in sequence: disables the account, removes all group memberships, moves the object to the Disabled Accounts OU, and logs the action with a timestamp.

If you need to do it manually:

1. Open **Active Directory Users and Computers**
2. Find the account in its departmental OU
3. Right-click the account and select **Disable Account**
4. Open **Properties > Member Of**
5. Remove every group except Domain Users
6. Right-click the account and select **Move**
7. Choose **Disabled Accounts** OU and confirm

---

### Step 3: Log the Action

Record the following in the offboarding log immediately after completing the steps:

- Employee full name and SamAccountName
- Date and exact time the account was disabled
- Your name as the administrator who performed the action
- HR ticket or request number if one exists

This log is your audit trail. If anyone questions when access was revoked or who did it, this is what you point to.

---

### Step 4: Verify

Do not skip this step.

- Attempt a login with the disabled account and confirm it is denied
- Check the **Member Of** tab and confirm no security groups remain
- Confirm the account appears in the Disabled Accounts OU

Takes 90 seconds and eliminates any doubt that the job is done.

---

### Step 5: Notify HR

Reply to HR confirming offboarding is complete. Include the timestamp from the log. This closes the loop and documents that IT acted on the notification.

---

## Completion Checklist

- [ ] Account disabled
- [ ] All security groups removed
- [ ] Account moved to Disabled Accounts OU
- [ ] Action logged with timestamp and admin name
- [ ] Login attempt confirmed as denied
- [ ] HR notified of completion

---

## Retention Policy

Disabled accounts stay in the Disabled Accounts OU for 90 days before permanent deletion. That window covers audit requests, access disputes, and any forensic work that might come up after someone leaves.

Do not delete accounts before the 90-day mark without written approval from IT management.

---

## Expected Time

Under 2 minutes using the script. Under 5 minutes manually.

---

## Related

- `SOP-New-User-Onboarding.md`
- `scripts/Remove-EmployeeAccess.ps1`
