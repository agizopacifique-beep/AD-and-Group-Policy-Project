# AD-and-Group-Policy-Project
Built and provisioned a Windows Server 2022 Active Directory  domain for a 30-user SMB environment. Implemented RBAC via security  groups, enforced GPO security baseline across departmental OUs, and  automated user lifecycle management with PowerShell covering identity  management, workstation hardening, and audit policy configuration.
## Business Scenario
| | |
|---|---|
| **Company** | TechBridge Solutions |
| **Industry** | IT Consulting |
| **Size** | 30 employees |
| **Departments** | IT, HR, Finance |
| **Problem** | No centralized identity management or security controls |
| **My Role** | Systems Administrator |

## Skills Demonstrated
| Skill | Tools Used |
|---|---|
| Active Directory Administration | Windows Server 2022, AD DS |
| Group Policy Management | GPMC, GPO Editor |
| Identity & Access Management | Security Groups, OUs, RBAC |
| PowerShell Automation | PowerShell 5.1 |
| Security Hardening | GPO Baseline, Audit Policy |
| IT Documentation | SOPs, Runbooks |
| User Lifecycle Management | Onboarding, Offboarding Scripts |

## Project Deliverables
- Fully configured AD domain `techbridge.local`
- Department-based OU structure with RBAC security groups
- 5 GPO security baseline policies
- 4 PowerShell automation scripts
- 3 Standard Operating Procedures (SOPs)
- Full screenshot documentation of build process

## Impact Metrics
| Metric | Before | After |
|---|---|---|
| New user setup time | 45 minutes | 8 minutes |
| Password policy enforcement | None | 12-char complexity required |
| Employee offboarding time | Hours | Under 2 minutes |
| Unauthorized USB access | Uncontrolled | Blocked via GPO |
| Login audit trail | None | Full event logging enabled |

## Repository Structure
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
```

## Environment
| Component | Details |
|---|---|
| Hypervisor | VirtualBox |
| Domain Controller | Windows Server 2022 Evaluation |
| Client Machine | Windows 10 Enterprise Evaluation |
| Domain Name | techbridge.local |
| DC Hostname | DC01 |
| Client Hostname | CLIENT01 |
