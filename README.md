# MSFT Certificate Expiry Report | Dash-Board
 ###  Required Polaris(PS Module) , PSSQLite(PS Module) , PSWriteHtml(PS Module) & Active Directory gMSA(Optional).
 
Certificate expiry monitoring is a CRITICAL for all the Orgs. Create your own Dashboard without write any HTML Code & grant the access by using AD security group to access thsoe pages 
 
1. 𝗣𝘀𝗪𝗿𝗶𝘁𝗲𝗵𝘁𝗺𝗹 with 𝗣𝗼𝗹𝗮𝗿𝗶𝘀. Both the modules are available in PowerShell Gallery . Build your Dashboard or Dynamic HTML report with ZERO html code . All feathers are available those are required for a Standard Dashboard. Like pagination , conditional formatting, csv export & many more .
Tested on Windows & Linux . Lots of sample HTML examples are available on 𝔾𝕚𝕥𝕙𝕦𝕓 !

#### 2. Polaris : Web API Module - API will run as a service optionally gMSA(Group Managed Service Account) could be use with that service.
Refer this MSFT Blog for gMSA : https://docs.microsoft.com/en-us/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts
#### 3. PswriteHTML : Build your Dashboard or Dynamic HTML report with ZERO html code
#### 4. PsSQLite : Database Management (PsSQLite is an optional component); Data store can be done into txt, csv , json & so on.
#### 5. Certificate Teamplate names are hard coded & thsoe need to change manually; dynamic Template's name can be possible using PowerShell Advance Function.

Polaris : Polaris is a micro-framework to build the Wep API/s; simmilar like Flash (Python) but Polaris is having very minimum feathers & that is worked with PowerShell.
Polaris Page can be restricted by Active Directory security group & APIs can be publish using SSL for security .

Thanks to Deepak Dhami , Siva Nallagatla , Prateek Singh & Chen V.
Special Thanks to Przemyslaw Klys (PswriteHTML Module Devoloper)

### Please share your comments & feedback.

