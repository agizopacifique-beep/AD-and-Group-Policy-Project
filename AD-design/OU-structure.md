# Organizational Unit Structure

## Domain: `techbridge.local`

```
techbridge.local
├── TechBridge Users
│   ├── IT          (5 users)
│   ├── HR          (10 users)
│   └── Finance     (15 users)
├── TechBridge Computers
│   ├── Workstations
│   └── Servers
├── Service Accounts
└── Disabled Accounts
```

---

## Why This Structure

Most small businesses dump everything into the default Users container and wonder why GPOs are hard to manage. This design avoids that by separating objects into logical containers from the start.

**TechBridge Users** holds all employee accounts, split by department. The split matters because IT, HR, and Finance each need different GPOs. You cannot target a GPO to a mix of departments without OUs -- you end up applying everything to everyone or nothing to anyone.

**TechBridge Computers** is separate from users entirely. This is not optional if you want clean GPO targeting. A computer GPO linked to the Workstations OU applies at boot regardless of who logs in. A user GPO linked to HR applies to Beth regardless of which machine she sits at. Mixing them in one container breaks that logic.

**Service Accounts** gets its own OU because service accounts are not people. They do not log in interactively, they do not need the same password policies, and if one gets compromised you want to contain the damage. Keeping them isolated means you can apply a separate fine-grained password policy and audit them independently without touching user accounts.

**Disabled Accounts** is where offboarded employees land, not the recycle bin. The account gets disabled and stripped of all group memberships immediately -- access is gone. But the object stays here for 90 days before deletion. That window covers audit requests, HR disputes, and forensic investigations where you need to know what groups someone was in.

---

## OU Reference

| OU | What Lives Here |
|---|---|
| TechBridge Users | Parent container -- no accounts created directly here |
| IT | Sysadmins and technical staff (5 accounts) |
| HR | Human resources personnel (10 accounts) |
| Finance | Accounting and finance staff (15 accounts) |
| TechBridge Computers | Parent container -- no computer objects created directly here |
| Workstations | Domain-joined desktops and laptops |
| Servers | Domain servers excluding DC01 |
| Service Accounts | Application and service accounts -- no interactive login |
| Disabled Accounts | Offboarded employee accounts retained for 90 days |
