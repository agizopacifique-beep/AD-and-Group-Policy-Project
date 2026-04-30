# Security Groups and Role-Based Access Control

## Group Design
| Group Name | Type | Scope | Members | Purpose |
|---|---|---|---|---|
| IT-Admins | Security | Global | IT staff | Full administrative rights on domain workstations |
| HR-Staff | Security | Global | HR personnel | Access to HR systems and shared folders |
| Finance-Staff | Security | Global | Finance personnel | Access to Finance systems and shared folders |
| All-Users | Security | Global | All employees | Standard workstation access and shared resources |
| Service-Accounts | Security | Global | Service accounts | Application and service authentication |

## Access Control Matrix
| Resource | IT-Admins | HR-Staff | Finance-Staff | All-Users |
|---|---|---|---|---|
| Domain Controller | Full Admin | No Access | No Access | No Access |
| HR Shared Folder | Read | Full Access | No Access | No Access |
| Finance Shared Folder | Read | No Access | Full Access | No Access |
| General Shared Folder | Full Access | Read/Write | Read/Write | Read/Write |
| Workstations | Local Admin | Standard User | Standard User | Standard User |

## Group Nesting Strategy
```
All-Users
├── HR-Staff
├── Finance-Staff
└── IT-Admins
```

## Design Decisions
| Decision | Justification |
|---|---|
| Global scope groups | Best practice for user groups in single-domain environments |
| Least privilege access | Users receive only permissions required for their role |
| Dedicated IT-Admins group | Separates admin rights from standard user accounts |
| Disabled accounts removed from all groups | Immediate access revocation upon offboarding |
