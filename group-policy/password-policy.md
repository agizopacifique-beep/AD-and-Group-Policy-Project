# GPO: TechBridge-Password-Policy

**Linked To:** techbridge.local
**Scope:** All domain users

---

## What This GPO Does

Credential attacks are the most common entry point into a network. Weak passwords, reused passwords, and accounts with no lockout policy make it easy. This GPO removes those weaknesses across every account in the domain from a single configuration.

Everything here applies automatically at login. Users cannot work around it by changing their password back to a previous one, setting something short, or ignoring complexity requirements. The domain enforces it regardless of what the user prefers.

---

## Password Policy Settings

`Computer Configuration > Windows Settings > Security Settings > Account Policies > Password Policy`

| Setting | Value | Why |
|---|---|---|
| Minimum password length | 12 characters | Short passwords fall to brute force quickly. 12 characters raises the bar significantly without being impractical for daily use |
| Password complexity | Enabled | Requires uppercase, lowercase, number, and symbol. Prevents dictionary words and simple patterns |
| Maximum password age | 90 days | Limits how long a compromised credential stays valid without anyone knowing |
| Minimum password age | 1 day | Stops users from changing their password 10 times in a row to get back to their original one |
| Enforce password history | 10 passwords | Works with minimum age to prevent cycling. The last 10 passwords cannot be reused |

---

## Account Lockout Settings

`Computer Configuration > Windows Settings > Security Settings > Account Policies > Account Lockout Policy`

| Setting | Value | Why |
|---|---|---|
| Account lockout threshold | 5 failed attempts | Stops brute force and password spraying. Five attempts is enough for a legitimate user who misremembers their password -- it is not enough for an attacker running a script |
| Account lockout duration | 30 minutes | Auto-unlocks after 30 minutes. Most locked-out users can wait. If they cannot, they call the helpdesk and go through identity verification |
| Reset lockout counter after | 30 minutes | Resets the failed attempt count after 30 minutes of no activity. Prevents slow-drip attacks from staying under the threshold indefinitely |

---

## How These Settings Work Together

The password history and minimum age settings are designed to be used together. Without minimum age, a user can change their password, change it again immediately, and keep going until they cycle back to their original one -- defeating the history setting entirely. With both in place, that route is closed.

The lockout duration being equal to the counter reset period is intentional. An attacker trying 4 attempts every 29 minutes would never trigger a lockout. Setting both to 30 minutes means that approach does not work.

---

## What This Does Not Cover

This GPO applies the domain-wide password policy. It does not cover service accounts, which have different requirements and should be managed with Fine-Grained Password Policies applied directly to the Service Accounts OU. Service account passwords should be longer, more complex, and never expire -- but that is a separate configuration.

---

## Compliance Alignment

| Framework | Control |
|---|---|
| NIST SP 800-63B | Memorized secret requirements |
| CIS Controls v8 | Control 5: Account Management |
| CompTIA Security+ | Domain 3.0: Implementation |
