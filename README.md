# Certificate Expiry Monitoring DashBoard

**Certificate expiry monitoring is a CRITICAL. Create beautiful Dashboard without write any HTML Code & grant access by using AD security group to access those pages**.

- Polaris is a micro-framework to build the Wep API/s; simmilar like Flash (Python) but Polaris is having very minimum feathers & that is worked with PowerShell.
Polaris Page can be restricted by Active Directory security group & APIs can be publish using SSL for security.

## Prerequisites
- [Polaris](https://github.com/PowerShell/Polaris)
- [PsWriteHTML](https://github.com/EvotecIT/PSWriteHTML)
- [gMSA (**Optional**)](https://docs.microsoft.com/en-us/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts/)
- AD Security group for RBAC (**Optional**).
- Certificate for SSL (**Optional**).
- Git.

![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) `All optional components are used for security purpose & those are required in Production. Those can be ignored during the testing. ` 

## Description

- 𝗣𝘀𝗪𝗿𝗶𝘁𝗲𝗵𝘁𝗺𝗹 with 𝗣𝗼𝗹𝗮𝗿𝗶𝘀. Both the modules are available in PowerShell Gallery . GIven the links above. Build your Dashboard or Dynamic HTML report with ZERO html code . All feathers are available those are required for a Standard Dashboard. Like pagination , conditional formatting, csv export & many more .
Tested on Windows & Linux . Lots of sample HTML examples are available on **Github** !
- Polaris : Web API Module - API will run as a service optionally gMSA(Group Managed Service Account) could be use with that service.
- Refer MSFT Blog for gMSA:
[gMSA](https://docs.microsoft.com/en-us/windows-server/security/group-managed-service-accounts/getting-started-with-group-managed-service-accounts/)
- **PswriteHTML** : Build your Dashboard or Dynamic HTML report with ZERO html code
- Certificate Teamplate names are hard coded & those need to change manually; dynamic Template's name can be possible using PowerShell Advance Function.

## Implementation Instruction

```powershell
mkdir c:\temp
cd C:\temp\
git clone https://github.com/21bshwjt/pki-polaris.git
mkdir C:\WebApi\Logs
Copy-Item C:\temp\pki-polaris\* -Recurse C:\WebApi\ -Force -Verbose
```
```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
```
```powershell
Install-Module -Name Polaris -AllowClobber -Force
```
```powershell
Install-Module -Name PSWriteHTML -AllowClobber -Force
```
- One AD service account/gMSA is needed for running a Windows scheduled task; that account needs to have CA server’s admin privileges. Code is present into the folder called “build-apicache”. Which will connect the CA server remotely & get the relevant data & export to a JSON file. Schedule task could be run once or twice in a day.
- Polaris will run as a Windows service by using nssm. Code is present in gMSA folder. Download nssm - https://nssm.cc/download . Another service account/gMSA is needed to run the Windows service into the local server with admin privileges.
- Read Polaris documentation to understand how Polaris works.

#### There are three codes those are created the Dashboard sucessfully . Those are under 'routes' , 'subroutes' & 'build-apicache' folders.
#### mainpol.ps1 will run the API & that is the only file that needs to be running by Windows Service or Scheduled tasks. Remaining files will be called during the runtime by mainpol.ps1. Use VSCode or ISE for testing . Create Windows Service associated with mainpol.ps1 once all are going good.   

### [routes]

- Content of **certexpiry.ps1** for anonymous access - **Pointing Subroute**
```powershell
New-PolarisGetRoute -Path "/certexpiry" -Scriptblock {
    $pkiexp = . C:\WebApi\subroutes\certexpiry.ps1
    $Response.SetContentType("text/html")
    $Response.Send($pkiexp)
}
```
- Content of **certexpiry.ps1** for restricted access through AD Security Group - **Pointing Subroute**
- **sg-polaris** is an AD Security group.
```powershell
New-PolarisGetRoute -Path "/certexpiry" -Scriptblock { 
   if( -not $Request.User.IsInRole("sg-polaris") ) {
      $Response.SetContentType('text/html')
      $Html = Get-Content C:\WebApi\htmls\denied.html -Raw
      $Response.Send($Html)
   } else {
      $pkiexp = . C:\WebApi\subroutes\certexpiry.ps1
      $Response.SetContentType("text/html")
      $Response.Send($pkiexp)
   } 
}
```
- Users will get simillar message like below those users are not part of that Group.
 <p><img src="https://github.com/21bshwjt/pki-polaris/blob/7518e2c08fe9bb60c2482c96631ccd55fc353253/Screenshots/denied.JPG" width="300" height="70"></p>

### [subroutes]

- Content of **certexpiry.ps1** - **Dashboard Build Code**
```powershell
[void](Import-Module PSWriteHTML)   
$Title = 'Dashboard | PKI-Expiry'
$icon = 'https://pngmind.com/wp-content/uploads/2019/08/Linkedin-Logo-Png-Transparent-Background.png'
$headertxt = "<h4>Corp Certificate Expiry Report</h4>"
$TableTitle = "MSFT-CA1 Expiry Report"
$data = Get-Content "C:\polaris\pki-polaris\apicache\cert.json" | ConvertFrom-Json
New-HTML -FavIcon $icon -TitleText $Title -Online -AutoRefresh 50 {
    New-HTMLContent -HeaderText $headertxt {
        New-HTMLTable -Title $TableTitle -DataTable $data -HideFooter -PagingOptions @(6, 12, 24) {
         TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator le -Value 364 -Color white -BackgroundColor Red
         TableConditionalFormatting -Name 'DaysUntilExpired' -ComparisonType number -Operator ge -Value 363 -Color Black -BackgroundColor PaleGreen
            
        } 
    }
}
```
- Build beautiful Dasboard like below without writing any HTML/JS code.
<p><img src="https://github.com/21bshwjt/pki-polaris/blob/e5225f83b77bf454b24a32bf63a6aa6eba21d544/Screenshots/Cert_Expiry_new.png" width="800" height="320"></p>

##### Certificate names are missing into the above screenshot because of those are default published Certificates without having Subject name. That will be not the case when new template will be created.

### [build-apicache]

- File called **certexpiry_cachebuilt.ps1** under "build-apicache" folder - **Scheduled tasks Code**.
- Look the comment sections into that code.
- Change CA Server name and CA Template names & Template OIDs into the Code as per your env. Given a screenshot below.
<img src="https://github.com/21bshwjt/pki-polaris/blob/7b896321d49333962f3ed695ca0906fc966b1567/Screenshots/CA.png" width="700" height="320"></p>

## How to access API ?

- Home page URL : http://server-fqdn:81/home | **Test Web Page**. 
<img src="https://github.com/21bshwjt/pki-polaris/blob/7b896321d49333962f3ed695ca0906fc966b1567/Screenshots/home.JPG" width="800" height="200"></p>
- Another API with **PSWriteHTML**; link : http://server-fqdn:81/employees | **Test Web Page**. 
<img src="https://github.com/21bshwjt/pki-polaris/blob/7b896321d49333962f3ed695ca0906fc966b1567/Screenshots/emp.JPG" width="800" height="200"></p>
- Certificate expiry monitoring link with **PsWriteHTML** : http://server-fqdn:81/certexpiry . 

## API Port

- Port can be changed into **mailpol.ps1** .

## Enable SSL
- One Certificate is needed for SSL binding & import that Certificate into API server computer store. 
- Enable the SSL once API is running fine. Replace the mainpol.ps1 from **enable_ssl** folder. **Server IP** & **Certificate thumbprint** are need to change from that code. 
- Read the comments section carefully from **enable_ssl/mainpol.ps1**.   

___________________________________________________________________________________________________________________

- [**Wiki**](https://21bshwjt.github.io/pki-polaris/)
- [**Me@LinkedIn**](https://www.linkedin.com/in/bshwjt/)
- Certificate expiry intial code taken from [**TechNet Forum**](https://social.technet.microsoft.com/Forums/windowsserver/en-US/7c8ecd4f-eb2a-49f9-ae53-aad3e653d788/report-on-soon-to-be-expired-certificates?forum=winserversecurity).  
- Thanks to **Deepak Dhami** , **Siva Nallagatla** , **Prateek Singh** & **Chen V.** Special Thanks to **Przemyslaw Klys** (PswriteHTML Module Devoloper).
 
___________________________________________________________________________________________________________________

![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) `Please Share Your Comments & Feedback.`

