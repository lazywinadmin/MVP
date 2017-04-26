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
Set-MVPConfiguration -SubscriptionKey $ApplicationID$Subkey
```
A user interface will show to authenticate against the Microsoft API "mvpapi.portal.azure-api.net"

![Alt text](media/Set-MVPConfiguration01.jpg?raw=true "Set-MVPConfiguration")

![Alt text](media/Set-MVPConfiguration02.jpg?raw=true "Set-MVPConfiguration")

![Alt text](media/Set-MVPConfiguration03.jpg?raw=true "Set-MVPConfiguration")


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