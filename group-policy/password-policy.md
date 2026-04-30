# GPO: TechBridge-Password-Policy

## Overview
| | |
|---|---|
| **GPO Name** | TechBridge-Password-Policy |
| **Linked To** | techbridge.local |
| **Scope** | All domain users |
| **Purpose** | Enforce password complexity and rotation standards |

## Policy Settings
| Setting | Value | Path |
|---|---|---|
| Minimum password length | 12 characters | Computer Config > Windows Settings > Security Settings > Account Policies > Password Policy |
| Password complexity | Enabled | Same path as above |
| Maximum password age | 90 days | Same path as above |
| Minimum password age | 1 day | Same path as above |
| Enforce password history | 10 passwords remembered | Same path as above |
| Account lockout threshold | 5 failed attempts | Computer Config > Windows Settings > Security Settings > Account Policies > Account Lockout Policy |
| Account lockout duration | 30 minutes | Same path as above |
| Reset lockout counter after | 30 minutes | Same path as above |

## Business Justification
Enforcing password complexity and rotation reduces the risk of 
credential-based attacks including brute force and password spraying. 
Account lockout thresholds mitigate unauthorized access attempts 
while balancing operational impact on end users.

## Compliance Alignment
| Framework | Control |
|---|---|
| NIST SP 800-63B | Memorized secret requirements |
| CIS Controls v8 | Control 5: Account Management |
| CompTIA Security+ | Domain 3.0: Implementation |
