# SOP: New User Onboarding

## Document Information
| | |
|---|---|
| **Document Title** | New User Onboarding Standard Operating Procedure |
| **Department** | Information Technology |
| **Author** | [Your Name] |
| **Date** | April 2026 |
| **Version** | 1.0 |
| **Status** | Active |

## Purpose
Standardize the process of provisioning new employee accounts
in Active Directory to ensure consistent access control,
security compliance, and onboarding efficiency across all
departments.

## Scope
Applies to all new employees joining TechBridge Solutions
across IT, HR, and Finance departments.

## Prerequisites
- Domain Administrator credentials
- Employee details provided by HR (first name, last name, department)
- Active Directory Users and Computers or PowerShell access

## Procedure

### Step 1: Receive Onboarding Request
- HR submits new hire details at least 24 hours before start date
- Confirm department, start date, and manager name
- Verify no duplicate username exists in AD

### Step 2: Create User Account
Run the onboarding script:
```powershell
