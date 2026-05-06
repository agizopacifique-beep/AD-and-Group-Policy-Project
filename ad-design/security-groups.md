# Security Groups and Role-Based Access Control

## The Core Idea

Permissions are never assigned to individual users. They are assigned to groups. A user gets access by being a member of the right group -- nothing more. When someone leaves, you disable the account and strip the group memberships. Access is gone across every resource simultaneously without touching a single permission entry.

That is RBAC. It sounds simple because it is. Most access control problems in small businesses come from not doing this consistently.

---

## Groups

| Group | Members | What It Grants |
|---|---|---|
| IT-Admins | IT staff | Local admin on all workstations, read access to department shares |
| HR-Staff | HR personnel | Full access to HR shared folder, standard workstation user |
| Finance-Staff | Finance personnel | Full access to Finance shared folder, standard workstation user |
| All-Users | Everyone | Standard workstation login, read/write on general shared folder |
| Service-Accounts | Application accounts | Service authentication only -- no interactive login |

All groups are Security type with Global scope. Global scope is the right choice for a single-domain environment -- it keeps things simple and the groups can be assigned permissions anywhere in the domain.

---

## Who Can Access What

| Resource | IT-Admins | HR-Staff | Finance-Staff | All-Users |
|---|---|---|---|---|
| Domain Controller | Full Admin | No Access | No Access | No Access |
| HR Shared Folder | Read | Full Access | No Access | No Access |
| Finance Shared Folder | Read | No Access | Full Access | No Access |
| General Shared Folder | Full Access | Read/Write | Read/Write | Read/Write |
| Workstations | Local Admin | Standard User | Standard User | Standard User |

IT has read access to department shares for troubleshooting purposes -- not write. If IT needs to modify HR or Finance files that goes through a ticket and a manager approval, not standing permissions.

The Domain Controller is IT-Admins only. No other group touches it. This is not optional.

---

## Group Nesting

```
All-Users
├── HR-Staff
├── Finance-Staff
└── IT-Admins
```

Every employee is in All-Users. Department groups are nested inside it. This means anything granted to All-Users -- like general shared folder access or standard workstation login -- flows down automatically. You do not maintain two group memberships per user. You add someone to their department group and they inherit everything All-Users covers.

---

## Design Decisions Worth Explaining

**Least privilege throughout.** HR cannot see Finance data. Finance cannot see HR data. IT can read both but not write. Nobody has more access than their job requires. This is not just security policy -- it limits the damage when an account gets compromised.

**IT-Admins is separate from the Administrator account.** Day to day work happens with a standard domain account. Admin rights come from group membership on specific machines, not from logging in as Administrator. Logging into a workstation as Administrator for routine tasks is a bad habit that this design prevents.

**Service accounts are isolated.** They live in their own OU, their own group, and they do not appear in department groups or All-Users. If a service account credential leaks the blast radius is contained to whatever that service account was actually authorized to do -- not everything a regular employee can reach.

**Offboarding removes group memberships immediately.** Disabling an account blocks login. But group memberships on a disabled account can still grant access in some configurations. The offboarding script strips every group membership at the same time as the disable. Both happen in the same script run.
