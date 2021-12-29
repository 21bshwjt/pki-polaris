<!DOCTYPE html>
<html>
   <head>
      <title>HTML img Tag</title>
   </head>

   <body>
# Certificate Expiry Monitoring DashBoard

<span style="color: orange;">Certificate expiry monitoring is a CRITICAL. Create beautiful Dashboard without write any HTML Code & grant access by using AD security group to access those pages</span>.

## Prerequisites
   ### 1.[Polaris](https://github.com/PowerShell/Polaris)
   ### 2.[PsWriteHTML](https://github.com/EvotecIT/PSWriteHTML)
   ### 3.[gMSA (Optional)](https://docs.microsoft.com/en-us/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts/)
   ### 4. AD Security group for RBAC.
   ### 5. Certificate for SSL.
   
#### 1. 𝗣𝘀𝗪𝗿𝗶𝘁𝗲𝗵𝘁𝗺𝗹 with 𝗣𝗼𝗹𝗮𝗿𝗶𝘀. Both the modules are available in PowerShell Gallery . GIven the links above. Build your Dashboard or Dynamic HTML report with ZERO html code . All feathers are available those are required for a Standard Dashboard. Like pagination , conditional formatting, csv export & many more .
Tested on Windows & Linux . Lots of sample HTML examples are available on 𝔾𝕚𝕥𝕙𝕦𝕓 !

#### 2. Polaris : Web API Module - API will run as a service optionally gMSA(Group Managed Service Account) could be use with that service.
Refer MSFT Blog for gMSA:
[gMSA](https://docs.microsoft.com/en-us/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts/)
#### 3. PswriteHTML : Build your Dashboard or Dynamic HTML report with ZERO html code
#### 4. Certificate Teamplate names are hard coded & thsoe need to change manually; dynamic Template's name can be possible using PowerShell Advance Function.

Polaris : Polaris is a micro-framework to build the Wep API/s; simmilar like Flash (Python) but Polaris is having very minimum feathers & that is worked with PowerShell.
Polaris Page can be restricted by Active Directory security group & APIs can be publish using SSL for security .

[Wiki](https://21bshwjt.github.io/pki-polaris/)
### Build beautiful Dasboard like below without writing any HTML/JS code. 
<img src="https://github.com/21bshwjt/pki-polaris/blob/63b395c292623f578c4d20042d6eefb3cb2dae56/Cert_Expiry.png" alt="Certificate Expiry Dashboard" width="700" height="320">
##### Certificate names are missing into the above screenshot because of those are default published Certificates without having Subject name. That will be not the case when new template will be created.

### Implementation Instruction
##### 1.	Install Polaris Module.
##### 2.	Install PsWriteHTML Module.
##### 3.	One AD service account/gMSA is needed for running a Windows scheduled task; that account needs to have CA server’s admin privileges. Code is present into the folder called “build-apicache”. Which will connect the CA server remotely & get the relevant data & export to a JSON file. Schedule task could be run once or twice in a day.
##### 4.	Polaris will run as a Windows service by using nssm. Code is present in gMSA folder. Download nssm - https://nssm.cc/download . Another service account/gMSA is needed to run the Windows service into the local server with admin privileges.
##### 5. Read Polaris documentation to understand how Polaris works.
##### 6. Change CA Server name and CA Template names & Template OIDs as per your env. Given a screenshot below.
<img src="https://github.com/21bshwjt/pki-polaris/blob/ad518d935a95c4d95a8f9103e5d72ca2a09175a0/CA.png" alt="CA" width="700" height="320">

###### Thanks to Deepak Dhami , Siva Nallagatla , Prateek Singh & Chen V. Special Thanks to Przemyslaw Klys (PswriteHTML Module Devoloper).

### Please share your comments & feedback.

</body>
</html>
