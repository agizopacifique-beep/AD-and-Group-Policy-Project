# SOP: New User Onboarding

**Department:** Information Technology
**Author:** Pacifique Agizo
**Date:** April 2026
**Version:** 1.0

---

## Purpose

New employees need access on day one. Not day two, not after IT gets around to it. This SOP exists so that whoever runs the onboarding always does it the same way, in the same order, with the same result -- regardless of how busy the day is.

---

## Scope

All new employees joining TechBridge Solutions across IT, HR, and Finance departments.

---

## What You Need Before Starting

- Domain Administrator credentials
- Employee details from HR: first name, last name, department, and start date
- Confirmation that the request came in at least 24 hours before the start date

If HR submits same-day, push back. Accounts provisioned in a rush get provisioned wrong.

---

## Procedure

### Step 1: Receive the Request

HR submits new hire details at least 24 hours before the employee's first day. When the request comes in, confirm three things before touching anything:

1. Department is one of the three supported: IT, HR, or Finance
2. Start date is confirmed -- not tentative
3. No existing account with the same username already exists in AD

Check for duplicates:

```powershell
Get-ADUser -Filter {SamAccountName -eq "jsmith"}
```

If that returns a result, flag it with HR before creating anything.

---

### Step 2: Create the Account

Run the onboarding script with the employee details:

```powershell
.\New-EmployeeOnboarding.ps1 -FirstName "John" -LastName "Smith" -Department "IT"
```

The script creates the account in the correct departmental OU, sets a temporary password, assigns the right security group, adds the user to All-Users, and forces a password change at first login.

If you need to do it manually:

1. Open **Active Directory Users and Computers**
2. Navigate to the correct department OU under TechBridge Users
3. Right-click the OU and select **New > User**
4. Enter first name, last name, and logon name following the format: first initial + last name (e.g. `jsmith`)
5. Set temporary password: `Welcome@2026!`
6. Uncheck **User must change password at next logon** -- check it instead
7. Click **Finish**
8. Open the user's **Member Of** tab and add the correct department group and All-Users

---

### Step 3: Verify Group Membership

Open the new account and confirm the **Member Of** tab shows:

- The correct department group (IT-Admins, HR-Staff, or Finance-Staff)
- All-Users

If either is missing, add it before moving on. Missing group membership means missing access on day one, which means a call to IT five minutes after the employee sits down.

---

### Step 4: Verify GPO Application

Log into a domain workstation with the new account credentials and run:

```powershell
gpresult /r
```

Confirm the correct GPOs are listed under Applied Group Policy Objects. If the department GPO is missing, check that the account landed in the right OU.

---

### Step 5: Hand Off Credentials

Give the employee their username and temporary password before they arrive. Do not email the password. Phone call or in-person handoff only.

Let them know the password must be changed at first login and give them the IT helpdesk contact in case anything goes wrong.

---

## Completion Checklist

- [ ] No duplicate username found before provisioning
- [ ] Account created in the correct departmental OU
- [ ] Temporary password set with forced change at first login
- [ ] Department security group assigned
- [ ] All-Users group assigned
- [ ] GPO application verified on a domain workstation
- [ ] Credentials handed off securely

---

## Expected Time

Under 10 minutes using the script. Under 15 minutes manually.

---

## Related

- `SOP-Employee-Offboarding.md`
- `SOP-Password-Reset-Procedure.md`
- `scripts/New-EmployeeOnboarding.ps1`
