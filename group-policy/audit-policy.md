# GPO: TechBridge-Audit-Policy

**Linked To:** techbridge.local
**Scope:** All domain computers

---

## What This GPO Does

Without audit logging, you have no way to know what happened on your network. Someone's account gets compromised and you cannot tell when the attacker first logged in, what they accessed, or whether they changed anything. This GPO fixes that by turning on event logging across every domain machine for the things that matter most -- logins, account changes, privilege use, and policy modifications.

The logs land in the Windows Security Event Log on each machine. In a larger environment they would be forwarded to a SIEM. Here they are available locally and reviewable via Event Viewer or PowerShell.

---

## Policy Settings

**Logon/Logoff**
`Computer Configuration > Windows Settings > Security Settings > Advanced Audit Policy > Logon/Logoff`

| Setting | Value |
|---|---|
| Audit Logon | Success and Failure |
| Audit Account Logon Events | Success and Failure |

Success captures every completed login -- who logged in, when, and from which machine. Failure captures every rejected attempt. A spike in failures from a single account is usually a brute force attempt or a locked-out user. Either way, you want to see it.

---

**Account Management**
`Computer Configuration > Windows Settings > Security Settings > Advanced Audit Policy > Account Management`

| Setting | Value |
|---|---|
| Audit Account Management | Success and Failure |

Logs every account creation, deletion, password change, and group membership modification. If someone adds themselves to IT-Admins without authorization, this catches it. If an account gets created outside the normal provisioning process, this catches it.

---

**Privilege Use**
`Computer Configuration > Windows Settings > Security Settings > Advanced Audit Policy > Privilege Use`

| Setting | Value |
|---|---|
| Audit Sensitive Privilege Use | Success and Failure |

Logs when elevated privileges are used -- things like taking ownership of files, acting as part of the OS, or restoring files and directories. Standard users should never trigger these events. When they do, it is worth investigating.

---

**Policy Change**
`Computer Configuration > Windows Settings > Security Settings > Advanced Audit Policy > Policy Change`

| Setting | Value |
|---|---|
| Audit Policy Change | Success and Failure |

Logs any change to audit policies, user rights assignments, or trust relationships. One of the first things an attacker does after gaining access is disable logging so their activity stops being recorded. This setting logs the attempt to do that before it takes effect.

---

**Object Access**
`Computer Configuration > Windows Settings > Security Settings > Advanced Audit Policy > Object Access`

| Setting | Value |
|---|---|
| Audit Object Access | Failure only |

Failure only here -- success would generate too much noise on a domain this size. Failed access attempts against files or folders you do not have permission to open are worth logging. Every successful file open is not.

---

## Event Log Configuration

| Setting | Value |
|---|---|
| Security log maximum size | 196608 KB (192 MB) |
| Retention method | Overwrite events as needed |

192 MB is enough to retain several days of events on a 30-user domain without manual intervention. Overwrite keeps the log from filling up and stopping new events from being recorded -- which is worse than losing old entries.

---

## Key Event IDs to Know

| Event ID | What It Means |
|---|---|
| 4624 | Successful login |
| 4625 | Failed login |
| 4720 | User account created |
| 4726 | User account deleted |
| 4728 | Member added to a security group |
| 4732 | Member added to local Administrators |
| 4719 | Audit policy changed |
| 4672 | Special privileges assigned at login |

These are the ones worth checking first during any incident investigation.

---

## Compliance Alignment

| Framework | Control |
|---|---|
| NIST SP 800-53 | AU-2: Audit Events |
| CIS Controls v8 | Control 8: Audit Log Management |
| CompTIA Security+ | Domain 4.0: Operations and Incident Response |
