# Business Requirements Document

**Project:** Active Directory and Group Policy Deployment
**Client:** TechBridge Solutions
**Administrator:** Pacifique Agizo
**Date:** April 2026
**Status:** Completed

---

## The Problem

TechBridge Solutions had 30 employees across three departments and no centralized way to manage any of them. User accounts lived on individual machines. There was no standard process for creating them, no password requirements, and no way to cut access when someone left. When an employee was terminated, their credentials continued to work until someone manually tracked down every machine they had ever used.

The specific problems that triggered this project:

- No centralized authentication -- every machine managed its own local accounts
- No password policy -- users set whatever they wanted, including nothing
- No offboarding process -- departed employees kept access indefinitely
- No audit logging -- no record of who logged in, when, or what they did
- Workstations exposed to USB-based data theft with no controls in place
- New employee setup averaging 45 minutes per person due to entirely manual processes

The company had outgrown the approach that works fine for five people. At 30 employees across IT, HR, and Finance, the lack of structure was a security liability and an operational bottleneck.

---

## The Solution

Deploy a Windows Server 2022 Active Directory domain with a department-based OU structure, role-based access control via security groups, a GPO security baseline covering password policy, workstation hardening, software restriction, and audit logging, and PowerShell automation to handle the repetitive parts of user management.

The goal was not just to fix the immediate problems but to build something the company could hand to any competent IT admin and have them understand immediately.

---

## Stakeholders

| Role | Involvement |
|---|---|
| Systems Administrator | Designed, deployed, and documented the entire environment |
| IT Manager | Approved security policies and GPO baseline before deployment |
| HR Department | Provided employee data structure for onboarding and offboarding workflows |
| Finance Department | Confirmed access control requirements for financial systems |

---

## Functional Requirements

| ID | Requirement | Status |
|---|---|---|
| FR-01 | Centralized user authentication via Active Directory | Complete |
| FR-02 | Department-based OU structure for IT, HR, and Finance | Complete |
| FR-03 | Role-based access control via security groups | Complete |
| FR-04 | New user provisioning completed in under 10 minutes | Complete -- averaging 8 minutes |
| FR-05 | Employee offboarding completed in under 2 minutes | Complete |
| FR-06 | Bulk user creation from a defined employee list | Complete |

---

## Security Requirements

| ID | Requirement | Status |
|---|---|---|
| SR-01 | Minimum 12-character password with complexity enforcement | Complete |
| SR-02 | Account lockout after 5 failed login attempts, 30-minute duration | Complete |
| SR-03 | Workstation auto-lock after 10 minutes of inactivity | Complete |
| SR-04 | USB removable storage blocked on all domain workstations | Complete |
| SR-05 | Audit logging enabled for login, account management, and privilege events | Complete |
| SR-06 | Unauthorized software execution restricted on HR and Finance OUs | Complete |

---

## Technical Requirements

| ID | Requirement | Status |
|---|---|---|
| TR-01 | Windows Server 2022 Domain Controller promoted and operational | Complete |
| TR-02 | Active Directory Domain Services role installed and configured | Complete |
| TR-03 | Group Policy Management Console with six GPOs deployed | Complete |
| TR-04 | PowerShell automation scripts written, tested, and documented | Complete |
| TR-05 | Client workstations domain-joined with GPO application verified | Complete |
| TR-06 | All configurations documented with screenshots and SOPs | Complete |

---

## Success Criteria -- Results

| Metric | Target | Result |
|---|---|---|
| New user setup time | Under 10 minutes | 8 minutes |
| Offboarding time | Under 2 minutes | Under 2 minutes |
| Password policy enforcement | 100% of domain users | 100% -- enforced at domain level |
| GPO application | Verified on all domain workstations | Verified via gpresult on WS-IT-01 and WS-HR-02 |
| Audit logging | Enabled and confirmed via Event Viewer | Confirmed -- Security log active on all machines |
| Documentation | SOPs completed for all major processes | 3 SOPs completed and tested |
