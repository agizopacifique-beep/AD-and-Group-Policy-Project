# AD and Group Policy Project

## What This Is

I built a fully functional Active Directory environment from scratch to simulate what a sysadmin actually does on day one at a small business. Not a tutorial follow-along -- a real deployment with real problems. DC01 went down because a GPO I linked at the wrong scope blocked Server Manager. CLIENT01 could not join the domain because DNS was pointing nowhere. I fixed both without a walkthrough.

The environment runs Windows Server 2022 and Windows 10 Pro on VirtualBox, simulating TechBridge Solutions -- a 30-user IT consulting firm with no existing identity management.

---

## The Problem I Was Solving

TechBridge had no centralized authentication. Every machine managed its own local users. Passwords had no requirements. When someone quit, IT had no single place to cut their access. New employees took 45 minutes to set up because everything was manual and inconsistent.

---

## What I Built

**Active Directory domain** -- `techbridge.local` running on Windows Server 2022. Promoted the server to Domain Controller, configured DNS integration, and built out the full OU hierarchy:

```
techbridge.local
├── TechBridge Users
│   ├── IT
│   ├── HR
│   └── Finance
├── TechBridge Computers
│   ├── Workstations
│   └── Servers
├── Service Accounts
└── Disabled Accounts
```

**Six GPOs** applied across the domain and specific OUs:

| GPO | What It Does |
|---|---|
| TechBridge-Password-Policy | 12-char minimum, complexity on, 90-day expiry, lockout after 5 attempts |
| TechBridge-Workstation-Security | Screen lock at 10 min, USB storage blocked, firewall enforced |
| TechBridge-Audit-Policy | Logs every login, group change, and privilege use to Security Event Log |
| TechBridge-IT-Admin-Rights | Gives IT-Admins local admin on all workstations via Restricted Groups |
| TechBridge-Software-Restriction | Blocks unauthorized executables on HR and Finance machines |
| TechBridge-Desktop-Wallpaper | Pushes branded domain wallpaper to all workstations via SYSVOL |

**Four PowerShell scripts** that handle the repetitive work:

| Script | What It Actually Does |
|---|---|
| `New-EmployeeOnboarding.ps1` | Creates AD user, places in correct OU, assigns security group. Runs in under 10 seconds |
| `Remove-EmployeeAccess.ps1` | Disables account, strips all group memberships, moves to Disabled Accounts OU, logs timestamp |
| `Get-InactiveAccounts.ps1` | Pulls all enabled accounts with no recent login and exports to CSV for review |
| `New-BulkUsers.ps1` | Creates multiple users from a defined list with automatic OU placement and group assignment |

**Three SOPs** that any IT staff member could follow:
- New user onboarding
- Employee offboarding
- Password reset with identity verification

**Six workstations** prestaged in AD before the machines were built -- the way it is actually done in enterprise environments when new hardware arrives:

```
WS-IT-01  / WS-IT-02   → John Smith (IT)
WS-HR-01  / WS-HR-02   → Beth Jones (HR)
WS-FIN-01              → Mike Williams (Finance)
WS-MGR-01              → Administrator
```

---

## What Changed

| Before | After |
|---|---|
| New user setup: 45 minutes | New user setup: under 8 minutes |
| No password requirements | 12-char complexity enforced domain-wide |
| Offboarding: hours, often incomplete | Offboarding: under 2 minutes, verified |
| USB drives: uncontrolled | Blocked via GPO on all workstations |
| No login audit trail | Full event logging on every machine |
| Manual workstation setup | GPOs apply automatically at domain join |

---

## Skills This Project Covers

Active Directory administration, Group Policy design and troubleshooting, RBAC implementation, PowerShell scripting, Windows Server 2022, DNS configuration, workstation domain enrollment, RDP remote management, firewall rule creation, asset management via Managed By attribute, SOP writing, and incident recovery from a self-inflicted GPO misconfiguration.

---

## Environment

| Component | Details |
|---|---|
| Hypervisor | VirtualBox |
| Domain Controller | Windows Server 2022 Evaluation |
| Client Machines | Windows 10 Pro |
| Domain | techbridge.local |
| DC Hostname | DC01 -- 192.168.56.10 (static) |
| Workstations | WS-IT-01, WS-HR-02 (domain joined and tested) |

---

## Repository Layout

```
AD-and-Group-Policy-Project/
├── BUSINESS-REQUIREMENTS.md
├── ad-design/
│   ├── ou-structure.md
│   └── security-groups.md
├── group-policy/
│   ├── README.md
│   ├── password-policy.md
│   ├── workstation-security.md
│   └── audit-policy.md
├── scripts/
│   ├── New-EmployeeOnboarding.ps1
│   ├── Remove-EmployeeAccess.ps1
│   ├── Get-InactiveAccounts.ps1
│   └── New-BulkUsers.ps1
├── documentation/
│   ├── SOP-New-User-Onboarding.md
│   ├── SOP-Employee-Offboarding.md
│   └── SOP-Password-Reset-Procedure.md
└── screenshots/
    ├── ad-structure/
    ├── gpo-configs/
    └── powershell-output/
```
