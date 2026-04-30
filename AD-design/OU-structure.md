# Active Directory Organizational Unit Structure

## Domain
`techbridge.local`

## OU Design Diagram
```
techbridge.local
├── OU = TechBridge Users
│   ├── OU = IT          (5 users)
│   ├── OU = HR          (10 users)
│   └── OU = Finance     (15 users)
├── OU = TechBridge Computers
│   ├── OU = Workstations
│   └── OU = Servers
├── OU = Service Accounts
└── OU = Disabled Accounts
```

## OU Descriptions
| OU | Purpose |
|---|---|
| TechBridge Users | Parent container for all employee accounts |
| IT | Systems administrators and technical staff |
| HR | Human resources personnel |
| Finance | Accounting and finance personnel |
| TechBridge Computers | Parent container for all domain machines |
| Workstations | Employee desktops and laptops |
| Servers | Domain servers and infrastructure |
| Service Accounts | Non-interactive accounts for applications and services |
| Disabled Accounts | Offboarded employees retained for 90 days per policy |

## Design Decisions
| Decision | Justification |
|---|---|
| Department-based OUs | Enables targeted GPO application per department |
| Separate Computers OU | Isolates workstation policies from user policies |
| Service Accounts OU | Limits blast radius if a service account is compromised |
| Disabled Accounts OU | Maintains audit trail while revoking access immediately |
