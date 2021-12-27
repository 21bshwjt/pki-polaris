# Certificate Expiry Monitoring DashBoard

<span style="color: orange;">Certificate expiry monitoring is a CRITICAL. Create beautiful Dashboard without write any HTML Code & grant access by using AD security group to access those pages</span>.

### Prerequisites
   # 1.[Polaris (Optional)](https://github.com/PowerShell/Polaris)
   # 2.[PsWriteHTML](https://github.com/EvotecIT/PSWriteHTML)
   # 3.[gMSA (Optional)](https://docs.microsoft.com/en-us/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts/)
   # 4.[PSSQLite (Optional)](https://www.powershellgallery.com/packages/PSSQLite/1.1.0/)           

#### 1. 𝗣𝘀𝗪𝗿𝗶𝘁𝗲𝗵𝘁𝗺𝗹 with 𝗣𝗼𝗹𝗮𝗿𝗶𝘀. Both the modules are available in PowerShell Gallery . GIven the links above. Build your Dashboard or Dynamic HTML report with ZERO html code . All feathers are available those are required for a Standard Dashboard. Like pagination , conditional formatting, csv export & many more .
Tested on Windows & Linux . Lots of sample HTML examples are available on 𝔾𝕚𝕥𝕙𝕦𝕓 !

#### 2. Polaris : Web API Module - API will run as a service optionally gMSA(Group Managed Service Account) could be use with that service.
Refer MSFT Blog for gMSA:
[gMSA](https://docs.microsoft.com/en-us/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts/)
#### 3. PswriteHTML : Build your Dashboard or Dynamic HTML report with ZERO html code
#### 4. PsSQLite : Database Management (PsSQLite is an optional component); Data store can be done into txt, csv , json & so on.
#### 5. Certificate Teamplate names are hard coded & thsoe need to change manually; dynamic Template's name can be possible using PowerShell Advance Function.

Polaris : Polaris is a micro-framework to build the Wep API/s; simmilar like Flash (Python) but Polaris is having very minimum feathers & that is worked with PowerShell.
Polaris Page can be restricted by Active Directory security group & APIs can be publish using SSL for security .

Thanks to Deepak Dhami , Siva Nallagatla , Prateek Singh & Chen V.
Special Thanks to Przemyslaw Klys (PswriteHTML Module Devoloper)

[Wiki](https://21bshwjt.github.io/pki-polaris/)

### Please share your comments & feedback.

