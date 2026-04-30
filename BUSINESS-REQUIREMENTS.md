# Business Requirements Document

## Project Information
| | |
|---|---|
| **Project Name** | Active Directory and Group Policy Deployment |
| **Client** | TechBridge Solutions |
| **Environment** | Small Business - 30 Users |
| **Administrator** | [Your Name] |
| **Date** | April 2026 |
| **Status** | Completed |

## Business Problem
TechBridge Solutions operated without centralized identity 
management, leaving user accounts, access controls, and 
workstation security entirely unmanaged. As the company grew 
to 30 employees across three departments, the following risks 
and inefficiencies were identified:

- No centralized authentication or access control
- User accounts created manually with no standard process
- No password complexity requirements enforced
- Departing employees retained system access after termination
- No audit trail for login events or privilege use
- Workstations unprotected against unauthorized USB storage
- New employee setup taking 45 minutes per user

## Proposed Solution
Deploy a Windows Server 2022 Active Directory domain with 
department-based Organizational Units, role-based access control 
via security groups, a GPO security baseline, and PowerShell 
automation to standardize and secure IT operations.

## Stakeholders
| Role | Responsibility |
|---|---|
| Systems Administrator | Design, deploy, and maintain AD infrastructure |
| IT Manager | Approve security policies and GPO baseline |
| HR Department | Provide employee data for onboarding and offboarding |
| Finance Department | Confirm access control requirements |

## Functional Requirements
| ID | Requirement |
|---|---|
| FR-01 | Centralized user authentication via Active Directory |
| FR-02 | Department-based OU structure for IT, HR, and Finance |
| FR-03 | Role-based access control via security groups |
| FR-04 | New user provisioning completed in under 10 minutes |
| FR-05 | Employee offboarding completed in under 2 minutes |
| FR-06 | Bulk user creation from HR-provided CSV file |

## Security Requirements
| ID | Requirement |
|---|---|
| SR-01 | Minimum 12-character password with complexity enforcement |
| SR-02 | Account lockout after 5 failed login attempts |
| SR-03 | Workstation auto-lock after 10 minutes of inactivity |
| SR-04 | USB removable storage blocked on all workstations |
| SR-05 | Audit logging enabled for all login and privilege events |
| SR-06 | Unauthorized software execution restricted on HR and Finance OUs |

## Technical Requirements
| ID | Requirement |
|---|---|
| TR-01 | Windows Server 2022 Domain Controller |
| TR-02 | Active Directory Domain Services role installed |
| TR-03 | Group Policy Management Console configured |
| TR-04 | PowerShell 5.1 automation scripts tested and documented |
| TR-05 | Client workstations domain-joined and GPO verified |
| TR-06 | All configurations documented with screenshots |

## Success Criteria
| Metric | Target |
|---|---|
| New user setup time | Under 10 minutes |
| Offboarding time | Under 2 minutes |
| Password policy enforcement | 100% of domain users |
| GPO application | Verified on all domain workstations |
| Audit logging | Enabled and confirmed via Event Viewer |
| Documentation | SOPs completed for all major processes |
