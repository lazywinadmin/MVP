# MVP
PowerShell Module to interact with the Microsoft MVP API

https://mvpapi.portal.azure-api.net/
https://aka.ms/mvp-api-video

## Usage

### Install the module
```powershell
Install-module -name MVP
```
### Set your connection
```powershell
$Subkey = 'abcdef083b5b482f8d99184d318b12f6'
Set-MVPConfiguration -SubscriptionKey $Subkey
```
A user interface will show to authenticate against the Microsoft API "mvpapi.portal.azure-api.net"

![Alt text](Media/Set-MVPConfiguration01.jpg?raw=true "Set-MVPConfiguration")

![Alt text](Media/Set-MVPConfiguration02.jpg?raw=true "Set-MVPConfiguration")

![Alt text](Media/Set-MVPConfiguration03.jpg?raw=true "Set-MVPConfiguration")


### Check the command available
```powershell
Get-Command -module MVP
```
```
CommandType     Name                                               Version    Source                                                                 
-----------     ----                                               -------    ------                                                                 
Function        Get-MVPContribution                                0.0.1.0    MVP                                                                    
Function        Get-MVPContributionArea                            0.0.1.0    MVP                                                                    
Function        Get-MVPContributionType                            0.0.1.0    MVP                                                                    
Function        Get-MVPContributionVisibility                      0.0.1.0    MVP                                                                    
Function        Get-MVPOnlineIdentity                              0.0.1.0    MVP                                                                    
Function        Get-MVPProfile                                     0.0.1.0    MVP                                                                    
Function        Get-MVPProfileImage                                0.0.1.0    MVP                                                                    
Function        New-MVPContribution                                0.0.1.0    MVP                                                                    
Function        New-MVPOnlineIdentity                              0.0.1.0    MVP                                                                    
Function        Remove-MVPConfiguration                            0.0.1.0    MVP                                                                    
Function        Remove-MVPContribution                             0.0.1.0    MVP                                                                    
Function        Remove-MVPOnlineIdentity                           0.0.1.0    MVP                                                                    
Function        Set-MVPConfiguration                               0.0.1.0    MVP                                                                    
Function        Set-MVPContribution                                0.0.1.0    MVP                                                                    
Function        Set-MVPOnlineIdentity                              0.0.1.0    MVP
```


### Retrieve a MVP Profile

```powershell
Get-MVPProfile -ID 5000475 #Francois-Xavier Cat
```
```
Metadata             : @{PageTitle=Francois-Xavier Cat is a Microsoft MVP in PowerShell who has been in the IT field since 2007. He is currently an 
                       Automation Specialist in a large Financial company.; TemplateName=; Keywords=; Description=}
MvpId                : 5000475
YearsAsMvp           : 4
FirstAwardYear       : 2014
AwardCategoryDisplay : Cloud and Datacenter Management
TechnicalExpertise   : 
InTheSpotlight       : False
Headline             : Francois-Xavier Cat is a Microsoft MVP in PowerShell who has been in the IT field since 2007. He is currently an Automation 
                       Specialist in a large Financial company.
Biography            : Francois-Xavier Cat is from France but has been living in Montreal, Quebec, Canada since 2004.
                       
                       In 2014, He was concurrently awarded his first MVP PowerShell by Microsoft and PowerShell Hero 2014 award by PowerShell.org. 
                       In 2015, he was also nominated Sapien Technologies MVP.
                       
                       You can follow his blog at http://lazywinadmin.com
DisplayName          : Francois-Xavier Cat
FullName             : Francois-Xavier Cat
PrimaryEmailAddress  : 
ShippingCountry      : Canada
ShippingStateCity    : Montreal, QC
Languages            : French, English
OnlineIdentities     : {@{PrivateSiteId=39435; SocialNetwork=; Url=https://www.facebook.com/fxavierc; OnlineIdentityVisibility=; 
                       ContributionCollected=False; DisplayName=; UserId=; MicrosoftAccount=; PrivacyConsentStatus=False; 
                       PrivacyConsentCheckStatus=False; PrivacyConsentCheckDate=; PrivacyConsentUnCheckDate=; Submitted=False}, 
                       @{PrivateSiteId=74012; SocialNetwork=; Url=https://www.facebook.com/lazywinadmin; OnlineIdentityVisibility=; 
                       ContributionCollected=False; DisplayName=; UserId=; MicrosoftAccount=; PrivacyConsentStatus=True; 
                       PrivacyConsentCheckStatus=False; PrivacyConsentCheckDate=; PrivacyConsentUnCheckDate=; Submitted=False}, 
                       @{PrivateSiteId=56689; SocialNetwork=; Url=http://klout.com/LazyWinAdm; OnlineIdentityVisibility=; 
                       ContributionCollected=False; DisplayName=; UserId=; MicrosoftAccount=; PrivacyConsentStatus=False; 
                       PrivacyConsentCheckStatus=False; PrivacyConsentCheckDate=; PrivacyConsentUnCheckDate=; Submitted=False}, 
                       @{PrivateSiteId=39415; SocialNetwork=; Url=http://ca.linkedin.com/in/fxcat; OnlineIdentityVisibility=; 
                       ContributionCollected=False; DisplayName=; UserId=; MicrosoftAccount=; PrivacyConsentStatus=True; 
                       PrivacyConsentCheckStatus=False; PrivacyConsentCheckDate=; PrivacyConsentUnCheckDate=; Submitted=False}...}
Certifications       : {@{PrivateSiteId=9874; Id=a2136352-509a-e411-bbc8-6c3be5a82b68; Title=VMware VCP510-DCV,; CertificationVisibility=}}
Activities           : 
CommunityAwards      : {@{PrivateSiteId=12499; Title=SAPIEN MVP; Description="SAPIEN Most Valuable Professional (MVP) award. It’s our way to 
                       recognize and show
                       our appreciation for community members who promote our products and contribute
                       to their improvement and success."; DateEarned=2015-01-16T00:00:00; 
                       ReferenceUrl=http://www.sapien.com/company/mvp/13/Francois-Xavier_Cat; AwardRecognitionVisibility=}, @{PrivateSiteId=6179; 
                       Title=PowerShell Hero; Description=; DateEarned=2014-01-08T00:00:00; 
                       ReferenceUrl=http://powershell.org/wp/2014/01/08/announcing-our-2014-powershell-heroes/; AwardRecognitionVisibility=}}
NewsHighlights       : {}
UpcomingEvent        : {}
```



### Retrieve Contribution Type
```powershell
Get-MVPContributionType | Select-Object -ExpandProperty Name
```
```
Article
Blog Site Posts
Book (Author)
Book (Co-Author)
Code Project/Tools
Code Samples
Conference (booth presenter)
Conference (organizer)
Forum Moderator
Forum Participation (3rd Party forums)
Forum Participation (Microsoft Forums)
Mentorship
Open Source Project(s)
Other
Product Group Feedback
Site Owner
Speaking (Conference)
Speaking (Local)
Speaking (User group)
Technical Social Media (Twitter, Facebook, LinkedIn...)
Translation Review, Feedback and Editing
User Group Owner
Video
Webcast
WebSite Posts
```
### Retrieve Contribution Area
```powershell
# Retrieve current Area
Get-MVPContributionArea
```
```
AwardName                       ContributionArea                                                                                                     
---------                       ----------------                                                                                                     
Cloud and Datacenter Management {@{Id=b003f4ef-066b-e511-810b-fc15b428ced0; Name=Azure Stack; AwardName=Cloud and Datacenter Management; AwardCate...
```

```powershell
# Retrieve current Area items
Get-MVPContributionArea | Select-Object -ExpandProperty ContributionArea
```
```

Id            : b003f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Stack
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : b803f4ef-066b-e511-810b-fc15b428ced0
Name          : Chef/Puppet in Datacenter
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : be03f4ef-066b-e511-810b-fc15b428ced0
Name          : Container Management
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : c603f4ef-066b-e511-810b-fc15b428ced0
Name          : Datacenter Management
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 90c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Enterprise Security
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 7ac301bb-189a-e411-93f2-9cb65495d3c4
Name          : Group Policy
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : d003f4ef-066b-e511-810b-fc15b428ced0
Name          : High Availability
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 9ec301bb-189a-e411-93f2-9cb65495d3c4
Name          : Hyper-V
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : e203f4ef-066b-e511-810b-fc15b428ced0
Name          : Linux on Hyper-V
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : e403f4ef-066b-e511-810b-fc15b428ced0
Name          : Linux on System Center/Operations Management Suite
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : e603f4ef-066b-e511-810b-fc15b428ced0
Name          : Networking
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 7cc301bb-189a-e411-93f2-9cb65495d3c4
Name          : PowerShell
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 4604f4ef-066b-e511-810b-fc15b428ced0
Name          : Storage
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 98c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Windows Server for Small and Medium Business
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False
```

```powershell
# Retrieve all Areas items
Get-MVPContributionArea -All
```

<details>
<summary>Output</summary>

```
Id            : b003f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Stack
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : b803f4ef-066b-e511-810b-fc15b428ced0
Name          : Chef/Puppet in Datacenter
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : be03f4ef-066b-e511-810b-fc15b428ced0
Name          : Container Management
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : c603f4ef-066b-e511-810b-fc15b428ced0
Name          : Datacenter Management
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 90c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Enterprise Security
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 7ac301bb-189a-e411-93f2-9cb65495d3c4
Name          : Group Policy
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : d003f4ef-066b-e511-810b-fc15b428ced0
Name          : High Availability
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 9ec301bb-189a-e411-93f2-9cb65495d3c4
Name          : Hyper-V
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : e203f4ef-066b-e511-810b-fc15b428ced0
Name          : Linux on Hyper-V
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : e403f4ef-066b-e511-810b-fc15b428ced0
Name          : Linux on System Center/Operations Management Suite
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : e603f4ef-066b-e511-810b-fc15b428ced0
Name          : Networking
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 7cc301bb-189a-e411-93f2-9cb65495d3c4
Name          : PowerShell
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 4604f4ef-066b-e511-810b-fc15b428ced0
Name          : Storage
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 98c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Windows Server for Small and Medium Business
AwardName     : Cloud and Datacenter Management
AwardCategory : My Awarded Category
Statuscode    : 0
Active        : False

Id            : 52c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Access
AwardName     : Access
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4ac301bb-189a-e411-93f2-9cb65495d3c4
Name          : Dynamics AX
AwardName     : Business Solutions
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4cc301bb-189a-e411-93f2-9cb65495d3c4
Name          : Dynamics CRM
AwardName     : Business Solutions
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4ec301bb-189a-e411-93f2-9cb65495d3c4
Name          : Dynamics GP
AwardName     : Business Solutions
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 50c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Dynamics NAV
AwardName     : Business Solutions
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 60c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Project
AwardName     : Business Solutions
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 9003f4ef-066b-e511-810b-fc15b428ced0
Name          : Analytics Platform System
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 9a03f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Data Lake
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 9c03f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure DocumentDB
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 9e03f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure HDInsight and Hadoop, Spark, & Storm on Azure
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : a003f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Machine Learning
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : a603f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Search
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ac03f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure SQL Data Warehouse
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ae03f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure SQL Database
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : b403f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Stream Analytics
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : c203f4ef-066b-e511-810b-fc15b428ced0
Name          : Cortana Intelligence Suite
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : d403f4ef-066b-e511-810b-fc15b428ced0
Name          : Information Management (ADF, SSIS, & Data Sync)
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ed4c8e60-b30a-e611-8121-c4346bacebc4
Name          : Microsoft R Services
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 3204f4ef-066b-e511-810b-fc15b428ced0
Name          : Power BI
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 78c301bb-189a-e411-93f2-9cb65495d3c4
Name          : SQL Server
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4404f4ef-066b-e511-810b-fc15b428ced0
Name          : SQL Server Reporting Services & Analysis Services
AwardName     : Data Platform
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : d203f4ef-066b-e511-810b-fc15b428ced0
Name          : Identity and Access
AwardName     : Enterprise Mobility
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : d603f4ef-066b-e511-810b-fc15b428ced0
Name          : Information Protection
AwardName     : Enterprise Mobility
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 3c04f4ef-066b-e511-810b-fc15b428ced0
Name          : RDS/Azure Remote App
AwardName     : Enterprise Mobility
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4a04f4ef-066b-e511-810b-fc15b428ced0
Name          : System Center Configuration Manager & Microsoft Intune
AwardName     : Enterprise Mobility
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 54c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Excel
AwardName     : Excel
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 9203f4ef-066b-e511-810b-fc15b428ced0
Name          : Application Integration
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : c803f4ef-066b-e511-810b-fc15b428ced0
Name          : ARM & DevOps on Azure (Chef, Puppet, Salt, Ansible, Dev/Test Lab)
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 9403f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure App Service
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 9603f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Backup & Recovery
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : b603f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Compute (VM, VMSS, Cloud Services)
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : e003f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Container Services (Docker, Windows Server)
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 45a28288-b30a-e611-8121-c4346bacebc4
Name          : Azure HPC/Batch
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : a203f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Media Service & CDN
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : a403f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Networking
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : a803f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Security
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : aa03f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Service Fabric
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : b203f4ef-066b-e511-810b-fc15b428ced0
Name          : Azure Storage
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : da03f4ef-066b-e511-810b-fc15b428ced0
Name          : IoT on Azure and Azure Messaging (Event Hub and Service Bus)
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 3e04f4ef-066b-e511-810b-fc15b428ced0
Name          : SDK support on Azure (.NET, Node.js, Java, PHP, Python, GO, Ruby)
AwardName     : Microsoft Azure
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ea03f4ef-066b-e511-810b-fc15b428ced0
Name          : O365 API Development
AwardName     : Office Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ec03f4ef-066b-e511-810b-fc15b428ced0
Name          : Office Add-in Development
AwardName     : Office Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ee03f4ef-066b-e511-810b-fc15b428ced0
Name          : Office Development for Android
AwardName     : Office Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : f003f4ef-066b-e511-810b-fc15b428ced0
Name          : Office Development for iOS
AwardName     : Office Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : f203f4ef-066b-e511-810b-fc15b428ced0
Name          : Office Development with Angular.js
AwardName     : Office Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : f403f4ef-066b-e511-810b-fc15b428ced0
Name          : Office Development with Node.js
AwardName     : Office Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : f603f4ef-066b-e511-810b-fc15b428ced0
Name          : Office Development with PHP
AwardName     : Office Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4204f4ef-066b-e511-810b-fc15b428ced0
Name          : SharePoint Add-in Development
AwardName     : Office Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ca03f4ef-066b-e511-810b-fc15b428ced0
Name          : Exchange
AwardName     : Office Servers and Services
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 70c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Office365
AwardName     : Office Servers and Services
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4004f4ef-066b-e511-810b-fc15b428ced0
Name          : SharePoint
AwardName     : Office Servers and Services
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 6ac301bb-189a-e411-93f2-9cb65495d3c4
Name          : Skype for Business
AwardName     : Office Servers and Services
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 5a04f4ef-066b-e511-810b-fc15b428ced0
Name          : Yammer
AwardName     : Office Servers and Services
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 5ac301bb-189a-e411-93f2-9cb65495d3c4
Name          : OneNote
AwardName     : OneNote
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 5cc301bb-189a-e411-93f2-9cb65495d3c4
Name          : Outlook
AwardName     : Outlook
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 5ec301bb-189a-e411-93f2-9cb65495d3c4
Name          : PowerPoint
AwardName     : PowerPoint
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 64c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Visio
AwardName     : Visio
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : aec301bb-189a-e411-93f2-9cb65495d3c4
Name          : .NET
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 0b2c2181-02e4-e611-80fe-3863bb34cb20
Name          : Accessibility
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 82c301bb-189a-e411-93f2-9cb65495d3c4
Name          : ASP.NET/IIS
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ba03f4ef-066b-e511-810b-fc15b428ced0
Name          : Clang/LLVM
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : c003f4ef-066b-e511-810b-fc15b428ced0
Name          : Cordova
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 8ac301bb-189a-e411-93f2-9cb65495d3c4
Name          : Developer Security
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : cc03f4ef-066b-e511-810b-fc15b428ced0
Name          : Front End Web Dev
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : ce03f4ef-066b-e511-810b-fc15b428ced0
Name          : Grunt/Gulp
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : dc03f4ef-066b-e511-810b-fc15b428ced0
Name          : Java
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : de03f4ef-066b-e511-810b-fc15b428ced0
Name          : Javascript/Typescript
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : e803f4ef-066b-e511-810b-fc15b428ced0
Name          : Node.js
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 3004f4ef-066b-e511-810b-fc15b428ced0
Name          : PHP
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 3a04f4ef-066b-e511-810b-fc15b428ced0
Name          : Python
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4c04f4ef-066b-e511-810b-fc15b428ced0
Name          : Unity
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 8cc301bb-189a-e411-93f2-9cb65495d3c4
Name          : Visual C++
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 84c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Visual Studio ALM
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 4e04f4ef-066b-e511-810b-fc15b428ced0
Name          : Visual Studio Extensibility
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 5804f4ef-066b-e511-810b-fc15b428ced0
Name          : Xamarin
AwardName     : Visual Studio and Development Technologies
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 1183268f-7773-e511-8110-fc15b4285d7c
Name          : Surface Deployment & Management
AwardName     : Windows and Devices for IT
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 5404f4ef-066b-e511-810b-fc15b428ced0
Name          : Windows for IT
AwardName     : Windows and Devices for IT
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 5004f4ef-066b-e511-810b-fc15b428ced0
Name          : Windows App Development
AwardName     : Windows Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : c1b41e30-5af2-e611-80fe-3863bb35ef70
Name          : Windows Design
AwardName     : Windows Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 5604f4ef-066b-e511-810b-fc15b428ced0
Name          : Windows Hardware Engineering (IoT, Mobile, and Desktop)
AwardName     : Windows Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 3ec301bb-189a-e411-93f2-9cb65495d3c4
Name          : Windows Mixed Reality
AwardName     : Windows Development
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

Id            : 66c301bb-189a-e411-93f2-9cb65495d3c4
Name          : Word
AwardName     : Word
AwardCategory : Other Award Category
Statuscode    : 0
Active        : False

```
</details>




## Authentication
 * Ocp-Apim-Subscription-Key : Subscription key which provides access to this API. Found in your Profile.
 * Authorization : OAuth 2.0 access token obtained from MSFT Live OAuth. Supported grant types: Authorization code.

## Issues
 * Not able to retrieve the Authentication Hash from MSFT Live OAuth using PowerShell. (for now you can retrieve your hash using the 'TRY IT' on https://mvpapi.portal.azure-api.net/


## Function Todo
- [x] Get-MVPContribution (All and by ID)
- [x] Get-MVPContributionArea
- [x] Get-MVPContributionType
- [x] Get-MVPContributionVisibility
- [x] Get-MVPOnlineIdentity (All, By ID, By NomindationID)
- [x] Get-MVPProfile (Current and by ID)
- [x] Get-MVPProfileImage
- [x] New-MVPContribution (POST)
- [x] New-MVPOnlineIdentity (POST)
- [x] Remove-MVPContribution (DELETE)
- [x] Remove-MVPOnlineIdentity (DELETE)
- [x] Set-MVPConfiguration
- [x] Set-MVPContribution (PUT) (to edit an existing one)
- [x] Set-MVPOnlineIdentity (PUT)
- [x] Remove-MVPConfiguration