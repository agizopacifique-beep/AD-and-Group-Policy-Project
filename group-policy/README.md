# Group Policy Objects

## Security Baseline

Six GPOs cover the domain. Each one is linked at the right scope -- domain-wide where the policy needs to apply to everyone, OU-level where it needs to apply to a specific group only.

| GPO | Linked To | What It Does |
|---|---|---|
| TechBridge-Password-Policy | techbridge.local | Password complexity, length, age, and account lockout for all users |
| TechBridge-Workstation-Security | TechBridge Computers OU | Screen lock, USB storage block, firewall enforcement on all workstations |
| TechBridge-Audit-Policy | techbridge.local | Logs every login attempt, group change, and privilege use domain-wide |
| TechBridge-IT-Admin-Rights | IT OU | Adds IT-Admins group to local Administrators on workstations |
| TechBridge-Software-Restriction | HR and Finance OUs | Blocks unauthorized executables on HR and Finance machines |
| TechBridge-Desktop-Wallpaper | techbridge.local | Pushes branded domain wallpaper to all workstations via SYSVOL |

---

## How GPOs Apply

Windows applies GPOs in a fixed order. Later policies win when settings conflict.

```
Local Policy
└── Site Policy
    └── Domain Policy
        (TechBridge-Password-Policy, TechBridge-Audit-Policy, TechBridge-Desktop-Wallpaper)
        └── OU Policy
            (TechBridge-Workstation-Security)
            └── Child OU Policy
                (TechBridge-IT-Admin-Rights, TechBridge-Software-Restriction)
```

This is LSDOU -- Local, Site, Domain, OU. The practical implication is that an OU-level GPO can override a domain-level one if they configure the same setting. That is by design. IT-Admins need local admin rights that the workstation security policy would otherwise restrict -- the IT OU policy runs last and wins.

Scope matters more than most people realise. During this deployment, the Software Restriction GPO was initially linked at the domain level instead of the HR and Finance OUs. It immediately blocked Server Manager on the Domain Controller. The fix was removing the domain-level link and relinking at the correct OU scope. The lesson: always link restriction policies at the most specific scope possible and test before applying to production.

---

## Verifying GPOs Are Applied

After any GPO change, verify application on an affected machine before closing the work:

```powershell
# Quick summary in the terminal
gpresult /r

# Full HTML report saved to disk
gpresult /h C:\GPO-Report.html
```

`gpresult /r` shows which GPOs applied to the current user and computer, which were filtered out, and which were denied. If a GPO you expect to see is missing, that output tells you why.

To force an immediate refresh without waiting for the background refresh cycle:

```powershell
gpupdate /force
```

Run this on the client after making a change on the DC. Then run `gpresult /r` to confirm the new policy shows up in the applied list.
