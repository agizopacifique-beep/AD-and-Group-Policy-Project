# Group Policy Objects

## GPO Security Baseline Overview
| GPO Name | Linked To | Purpose |
|---|---|---|
| TechBridge-Password-Policy | techbridge.local | Enforces password complexity domain-wide |
| TechBridge-Workstation-Security | TechBridge Computers OU | Hardens all domain workstations |
| TechBridge-IT-Admin-Rights | IT OU | Grants local admin rights to IT staff |
| TechBridge-Software-Restriction | HR and Finance OUs | Blocks unauthorized application execution |
| TechBridge-Audit-Policy | techbridge.local | Logs all authentication and privilege events |

## GPO Application Order
```
Local Policy
└── Site Policy
    └── Domain Policy (TechBridge-Password-Policy, TechBridge-Audit-Policy)
        └── OU Policy (TechBridge-Workstation-Security)
            └── Child OU Policy (TechBridge-IT-Admin-Rights, TechBridge-Software-Restriction)
```

## Verification Method
All GPOs verified using:
```powershell
gpresult /r
gpresult /h C:\GPO-Report.html
```
