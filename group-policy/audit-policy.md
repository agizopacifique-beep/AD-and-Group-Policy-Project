# GPO: TechBridge-Audit-Policy

## Overview
| | |
|---|---|
| **GPO Name** | TechBridge-Audit-Policy |
| **Linked To** | techbridge.local |
| **Scope** | All domain computers |
| **Purpose** | Maintain audit trail of authentication and privilege activity |

## Policy Settings
| Setting | Value | Path |
|---|---|---|
| Audit logon events | Success and Failure | Computer Config > Windows Settings > Security Settings > Advanced Audit Policy > Logon/Logoff |
| Audit account logon events | Success and Failure | Same path as above |
| Audit account management | Success and Failure | Computer Config > Windows Settings > Security Settings > Advanced Audit Policy > Account Management |
| Audit privilege use | Success and Failure | Computer Config > Windows Settings > Security Settings > Advanced Audit Policy > Privilege Use |
| Audit policy change | Success and Failure | Computer Config > Windows Settings > Security Settings > Advanced Audit Policy > Policy Change |
| Audit object access | Failure | Computer Config > Windows Settings > Security Settings > Advanced Audit Policy > Object Access |

## Event Log Settings
| Setting | Value |
|---|---|
| Security log maximum size | 196608 KB |
| Retention method | Overwrite events as needed |

## Business Justification
Audit logging creates an accountable record of all authentication 
events, privilege escalations, and policy changes. This supports 
incident response investigations, insider threat detection, and 
demonstrates compliance with security frameworks requiring audit trails.

## Compliance Alignment
| Framework | Control |
|---|---|
| NIST SP 800-53 | AU-2: Audit Events |
| CIS Controls v8 | Control 8: Audit Log Management |
| CompTIA Security+ | Domain 4.0: Operations and Incident Response |
