# MVP PowerShell Module

![](media/MicrosoftMVPLogo.png)

[![Build Status](https://dev.azure.com/lazywinadmin/MVP/_apis/build/status/lazywinadmin.MVP?branchName=master)](https://dev.azure.com/lazywinadmin/MVP/_build/latest?definitionId=18&branchName=master)

PowerShell Module to interact with the Microsoft MVP API and manage your contributions (Get, Add, Update and Remove), retrieve contributions type and technologies, retrieve a mvp profile and maintain your online identities.

**Youtube video**: [Using the PowerShell MVP Module](https://www.youtube.com/watch?v=UeRvlMzfsT8)

## Table of Contents
* [Getting Started](#Usage)
* [Configure connection](#Configure)
* [Requirements](#requirements)
* [Commands](#commands)
  * [Get-MVPProfile](#GetMVPProfile)
  * [Get-MVPContributionType](#GetMVPContributionType)
  * [Get-MVPContributionArea](#GetMVPContributionArea)
  * [Get-MVPContribution](#GetMvpContribution)
  * [New-MVPContribution](#NewMvpContribution)
  * [New-MVPContribution (multiple)](#NewMvpContributionMultiple)
  * [Remove-MVPContribution](#RemoveMvpContribution)
  * [Remove-MVPContribution (Multiple)](#RemoveMvpContributionMultiple)
  * [Show-MVPProfile](#ShowMvpProfile)
* [Authentication](#Authentication)
* [Persistent SubscriptionKey](#PersistentSubscriptionKey)
* [Clear Authenticaton](#Clearauthentication)
* [ToDo](#Todo)
* [Contributing](#Contributing)
* [More Information](#MoreInformation)

<a name="Usage"/>

## Getting Started

```powershell
# Install the Module from the PowerShell Gallery
Install-module -Name MVP -Scope CurrentUser -Repository PSGallery
```

<a name="Configure"/>

### Configure Connection

In order to use this module you need to get a Subscription Key from [https://mvpapi.portal.azure-api.net/](https://mvpapi.portal.azure-api.net/), [see the steps below](#Configure) or follow the documentation from Microsoft:

* [Getting Started with Microsoft MVP API](https://mvp.microsoft.com/en-us/Opportunities/my-opportunities-api-getting-started)
* [Microsoft Video Tutorial](https://aka.ms/mvp-api-video)
* [Microsoft MVP API](https://mvpapi.portal.azure-api.net/)

Fortunalely the step above just need to be done once.

Once you have access, follow the following steps to retrieve the Subscription Key.

1. Go to the [Microsoft MVP API Developer Portal](https://mvpapi.portal.azure-api.net/)
2. Click the ```Sign In``` button and sign in with your Microsoft Account. It must be the same Microsoft Account as you use for your Microsoft MVP Site access.
3. Subscribe to the ```MVP Production``` product.
4. Go to the ```PRODUCTS``` tab, and choose ```MVP Production```.
5. Click the ```Subscribe``` button.
6. This request will be reviewed and Accepted / Declined by the admin in one or two business days. The admin verifies your access permission based on your Microsoft Account. It must be the same Microsoft Account as you use for your Microsoft MVP Site access.
7. Once approved, on the top right corner click on your name and select ```PROFILE```
8. You should see a subscription for the ```MVP Production```
9. On the ```Primary Key``` line, select ```Show``` and this is your Subscription Key
10. You are ready to use the module, see below


```powershell
# Set your connection to the MVP API
$SubscriptionKey = 'abcdef083b5b482f8d99184d318b12f6' # this is a fake key btw ;)
Set-MVPConfiguration -SubscriptionKey $SubscriptionKey
```

A user interface will show to authenticate against the Microsoft API "mvpapi.portal.azure-api.net"

![Alt text](media/Set-MVPConfiguration01.jpg?raw=true "Set-MVPConfiguration")

![Alt text](media/Set-MVPConfiguration02.jpg?raw=true "Set-MVPConfiguration")

![Alt text](media/Set-MVPConfiguration03.jpg?raw=true "Set-MVPConfiguration")

<a name="commands"/>

### Commands

```powershell
# Retrieve all the commands
Get-Command -module MVP
```

Output:
```
CommandType Name                          Version Source
----------- ----                          ------- ------
Function    Get-MVPContribution           0.0.3   MVP
Function    Get-MVPContributionArea       0.0.3   MVP
Function    Get-MVPContributionType       0.0.3   MVP
Function    Get-MVPContributionVisibility 0.0.3   MVP
Function    Get-MVPOnlineIdentity         0.0.3   MVP
Function    Get-MVPProfile                0.0.3   MVP
Function    Get-MVPProfileImage           0.0.3   MVP
Function    New-MVPContribution           0.0.3   MVP
Function    New-MVPOnlineIdentity         0.0.3   MVP
Function    Remove-MVPConfiguration       0.0.3   MVP
Function    Remove-MVPContribution        0.0.3   MVP
Function    Remove-MVPOnlineIdentity      0.0.3   MVP
Function    Set-MVPConfiguration          0.0.3   MVP
Function    Set-MVPContribution           0.0.3   MVP
Function    Set-MVPOnlineIdentity         0.0.3   MVP
Function    Show-MVPProfile               0.0.3   MVP
Function    Test-MVPContribution          0.0.3   MVP
```

<a name="GetMVPProfile"/>

### Retrieve a MVP Profile


```powershell
# Retrieve your own profile
Get-MVPProfile

# Retrieve a specific profile
Get-MVPProfile -ID 5000475
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


<a name="GetMVPContributionType"/>

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


<a name="GetMVPContributionArea"/>

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
```
</details>


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


<a name="GetMvpContribution"/>


### Get Your Contributions

This will retrieve your contributions. By default it returns 5 entries.
``` powershell
Get-MVPContribution # By default it will return 5 entries only
```

You can change the limit using -Limit
```powershell
Get-MVPContribution -Limit 100 # This will retrieve 100 entries
```



<a name="NewMvpContribution"/>

### Create a New Contribution
```powershell
$Splat = @{
StartDate ='2020/10/20'
Title='Test from mvpapi.azure-api.net'
Description = 'Description sample'
ReferenceUrl='https://github.com/lazywinadmin/MVP'
AnnualQuantity='1'
SecondAnnualQuantity='0'
AnnualReach = '0'
Visibility = 'Everyone' # Get-MVPContributionVisibility
ContributionType = 'Blog/Website Post' # Get-MVPContributionType
ContributionTechnology = 'PowerShell' # Get-MVPContributionArea
}

New-MVPContribution @Splat
```

Output:
```
ContributionId         : 123456
ContributionTypeName   : Blog/Website Post
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog/Website Post; EnglishName=Blog/Website Post}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
AdditionalTechnologies : {}
StartDate              : 2020-10-20T00:00:00
Title                  : Test from mvpapi.azure-api.net
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Description sample
```

You can double check on the MVP website, the entry was created

![Alt text](media/New-MVPContribution02.jpg?raw=true "New-MVPContribution")


If you are not sure which ContributionTechnology or ContributionType, the function has dynamicparameters that can help you find the right information, example:

![Alt text](media/New-MVPContribution01.jpg?raw=true "New-MVPContribution")
![Alt text](media/New-MVPContribution03.jpg?raw=true "New-MVPContribution")



<a name="NewMvpContributionMultiple"/>

### Create Multiple Contributions

__From a CSV__

CSV Content [(file)](Examples/):
```
startdate,title,description,referenceurl,AnnualQuantity,SecondAnnualQuantity,AnnualReach,Visibility,ContributionType,ContributionTechnology
2020-12-01,Test1,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-02,Test2,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-03,Test3,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-04,Test4,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-05,Test5,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-06,Test6,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-07,Test7,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-08,Test8,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-09,Test9,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
2020-12-10,Test10,Some content,https://github.com/lazywinadmin/MVP,1,0,0,Everyone,Blog/Website Post,PowerShell
```

```powershell
Import-Csv .\Examples\MultipleEntries.csv | New-MVPContribution
```
The above command will create all the entries

<details>
<summary>Output</summary>

```
ContributionId         : 731771
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-01T00:00:00
Title                  : Test1
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731772
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-02T00:00:00
Title                  : Test2
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731773
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-03T00:00:00
Title                  : Test3
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731774
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-04T00:00:00
Title                  : Test4
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731775
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-05T00:00:00
Title                  : Test5
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731776
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-06T00:00:00
Title                  : Test6
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731777
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-07T00:00:00
Title                  : Test7
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731778
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-08T00:00:00
Title                  : Test8
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731779
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-09T00:00:00
Title                  : Test9
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content

ContributionId         : 731780
ContributionTypeName   : Blog Site Posts
ContributionType       : @{Id=df6464de-179a-e411-bbc8-6c3be5a82b68; Name=Blog Site Posts; EnglishName=Blog Site Posts}
ContributionTechnology : @{Id=7cc301bb-189a-e411-93f2-9cb65495d3c4; Name=PowerShell; AwardName=; AwardCategory=}
StartDate              : 2017-12-10T00:00:00
Title                  : Test10
ReferenceUrl           : https://github.com/lazywinadmin/MVP
Visibility             : @{Id=299600000; Description=Public; LocalizeKey=}
AnnualQuantity         : 1
SecondAnnualQuantity   : 0
AnnualReach            : 0
Description            : Some content
```
</details>

We can see all the entries were created on the portal

![Alt text](media/New-MVPContribution04.jpg?raw=true "New-MVPContribution")


<a name="RemoveMvpContribution"/>

### Remove an Entry
```powershell
Remove-MVPContribution -ID 731771
```
<a name="RemoveMvpContributionMultiple"/>

### Remove Multiple Entries at once
This will delete the entries between 731771 and 731780
```powershell
731771..731780 | foreach-object {
    if(Get-MVPContribution -ID $_){
        Remove-MVPContribution -ID $_
    }
}
```

<a name="ShowMvpProfile"/>

### Show an MVP Profile
This will display the specified MVP IDs in the default browser.
```powershell
Show-MVPProfile -ID 4025267
```


<a name="Authentication"/>

## Authentication

As seen in [Configure connection](#Configure) when you start using the module, you will need to authenticate against Microsoft Live OAuth.

 * Ocp-Apim-Subscription-Key : Subscription key which provides access to this API. Found in your Profile.
 * Authorization : OAuth 2.0 access token obtained from MSFT Live OAuth. Supported grant types: Authorization code.

<a name="PersistentSubscriptionKey"/>

## Persistent SubscriptionKey

If you want to save your SubscriptionKey, we recommend you store it inside your PowerShell profile.
For example, you can add the following:

```
# MVP Subscription Key
$MVPSubscriptionKey = '<YOUR KEY>'
Set-MVPConfiguration -SubscriptionKey $MVPSubscriptionKey
```

Accessing your PowerShell profile:

```
notepad $profile
```

<a name="Clearauthentication"/>

## Clear the authentication from your browser

During authentication, the module opens an Internet Explorer window to authenticate the user against the Microsoft backend.

If you need to clear this information, you'll need to clear the Internet Explorer cache.


<a name="Contributing"/>

## Contributing

Would love contributors, suggestions, feedback, and other help! Feel free to open an Issue ticket.

See [Contributing](CONTRIBUTING.md) file.

Thanks to our contributors!

* @p0w3rsh3ll
* @Windos
* @JPRuskins

<a name="MoreInformation"/>

## More Information

* [Microsoft - mvpapi.portal.azure-api.net](https://mvpapi.portal.azure-api.net/)
* [Microsoft - mvp-api-video](https://aka.ms/mvp-api-video)
* [MVP.PSGitHub module](https://github.com/markekraus/MVP.PSGitHub/) by @markekraus - PowerShell Utility Functions for Adding PowerShell GitHub Contributions to the Microsoft MVP API
* [Update Youtube video contributions script](https://github.com/julioarruda/UpdateMVPContributions) by @julioarruda - PowerShell script to update the View count in existing Microsoft MVP Contributions