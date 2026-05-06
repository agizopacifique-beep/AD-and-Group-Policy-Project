# SOP: Password Reset Procedure

**Department:** Information Technology
**Author:** Pacifique Agizo
**Date:** April 2026
**Version:** 1.0

---

## Purpose

A password reset is one of the most common ways an attacker gets into a system. Someone calls the helpdesk, pretends to be an employee, and walks away with access. This SOP exists to make sure that does not happen here -- every reset goes through identity verification, no exceptions.

---

## Scope

All domain accounts on `techbridge.local` requiring a password reset due to forgotten passwords, account lockouts, or security incidents.

---

## What You Need Before Starting

- Domain Administrator or Help Desk credentials
- A way to verify the requesting user's identity
- Access to Active Directory Users and Computers or PowerShell

---

## Identity Verification

Before touching anything in AD, confirm who you are talking to. Two verification items are required -- not one, not optional.

Accepted verification methods:

- Employee ID number
- Manager's full name
- Department and job title
- Date of birth on file with HR

If the person on the other end cannot provide two of these, stop. Do not reset the password. Escalate to the IT Manager and document the attempt.

Email-only reset requests are never processed. Phone, ticket, or in person only. If someone emails asking for a password reset, reply asking them to call or come in.

---

## Procedure

### Step 1: Log the Request

Open a ticket before doing anything else. Record the employee name, username, time of contact, and the channel they used (phone, walk-in, ticket system). If something goes wrong later, this is your record that the request was legitimate and handled correctly.

---

### Step 2: Verify Identity

Ask for two items from the verification list above. Take your time here -- this is the most important step. A 30-second verification check is worth more than the 10 minutes it takes to investigate a compromised account.

If anything feels off -- the person is evasive, cannot answer basic questions, or the request is unusually urgent -- escalate to the IT Manager before proceeding.

---

### Step 3: Reset the Password

Via PowerShell:

```powershell
Set-ADAccountPassword -Identity "jsmith" `
    -Reset `
    -NewPassword (ConvertTo-SecureString "TempReset@2026!" -AsPlainText -Force)

Set-ADUser -Identity "jsmith" -ChangePasswordAtLogon $true
```

Via AD Users and Computers:

1. Locate the account in its departmental OU
2. Right-click the account and select **Reset Password**
3. Enter the temporary password: `TempReset@2026!`
4. Check **User must change password at next logon**
5. Click **OK**

---

### Step 4: Unlock the Account if Needed

Lockouts and forgotten passwords often go together. Check and unlock in the same step:

```powershell
Unlock-ADAccount -Identity "jsmith"
```

In AD Users and Computers, open the account properties and check the **Account** tab for the unlock option if the PowerShell route is unavailable.

---

### Step 5: Deliver the Temporary Password

Phone only. Read the temporary password out loud to the user -- do not type it into an email, a chat message, or a ticket comment. Those channels are not secure and the password should not exist anywhere in writing after this conversation.

Confirm the user can log in successfully before closing the ticket. If they cannot, work through it with them before ending the call.

Update the ticket with completion time and close it.

---

## Completion Checklist

- [ ] Request logged in ticketing system before any action taken
- [ ] Identity verified with two items from the approved list
- [ ] Suspicious requests escalated rather than processed
- [ ] Password reset with temporary credential
- [ ] User must change password at next logon enforced
- [ ] Account unlocked if it was locked out
- [ ] Temporary password delivered by phone only
- [ ] User confirmed successful login before ticket closed

---

## Security Notes

Every password reset is logged automatically by the Audit Policy GPO -- Event ID 4723 in the Security log. If a reset request later turns out to be fraudulent, that log tells you exactly when it happened and which admin account performed it.

Temporary passwords expire at first login. The 10-password history policy prevents cycling back to old passwords. Neither of these requires any manual enforcement -- they are handled by the domain password policy.

Any reset request that cannot be verified, feels pressured, or comes from an unusual channel goes to the IT Manager. Document it regardless of outcome.

---

## Related

- `SOP-New-User-Onboarding.md`
- `group-policy/password-policy.md`
