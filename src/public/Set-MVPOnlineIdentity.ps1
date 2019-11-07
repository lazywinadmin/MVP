Function Set-MVPOnlineIdentity {
<#
    .SYNOPSIS
        Invoke the PutOnlineIdentity REST API

    .DESCRIPTION
        Updates an Online Identity

    .PARAMETER ID
        Specify the Id of the online identity in a int32 format

    .PARAMETER SocialNetwork
        Specify the Social Network

    .PARAMETER URL
        Specify the URL

    .PARAMETER AllowMicrosoftToQueryMyId
        Specify if you want to allo Microsoft to query the ID

    .PARAMETER Visibility
        Specify the Visbility (see Get-MVPContributionVisibility)

    .EXAMPLE
        Get-MVPOnlineIdentity -ID  123872 |
            Set-MVPOnlineIdentity -Verbose -SocialNetwork Code

    .EXAMPLE
        Get-MVPOnlineIdentity -ID  123872 |
        Set-MVPOnlineIdentity -Verbose -URL 'https://facebook.com/myprofile'

#>
[CmdletBinding(SupportsShouldProcess=$true)]
Param(
    [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
    [Alias('PrivateSiteId')]
    [int32]$ID,

    [Parameter()]
    [ValidateSet('Blog','Code','Codeplex','Exchange DL Subscription Email','Facebook','GitHub','Google+','Instagram',
                 'Klout','LinkedIn','Meetup','Microsoft ASP.NET Forum','Microsoft IIS Forum','MS Community (MS Answers)',
                 'MSDN/Technet','Naver ID','Other','StackOverflow','Twitter','Website','Windows/Windows Phone Dev Center ID',
                 'Xbox Live gamertag','Xing','Yammer','YouTube')]
    [String]$SocialNetwork = 'Twitter',

    [Parameter()]
    [String]$URL = 'https://mvpapi.azure-api.net',

    [Switch]$AllowMicrosoftToQueryMyId,

    [Parameter()]
    [ValidateSet('EveryOne','Microsoft','MVP Community','Microsoft Only')]
    [String]$Visibility = 'Microsoft'
    )
Begin {}
Process {

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {

        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'

    } else {

        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/onlineidentities'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
                ContentType = 'application/json'
            }
            Method = 'PUT'
            ContentType = 'application/json'
            ErrorAction = 'Stop'
        }

        # Retrieve online identity
        $CurrentIdentityObject = Get-MVPOnlineIdentity -ID $ID

        if ($CurrentIdentityObject) {

            # Get the Visibility
            if ($PSBoundParameters['Visibility']) {
                $VisibilityObject =  Get-MVPContributionVisibility | Where-Object -FilterScript {$_.Description -eq $Visibility }
            } else {
                $VisibilityObject=$CurrentIdentityObject.OnlineIdentityVisibility
            }
            if (-not$PSBoundParameters['SocialNetwork'])  { $SocialNetwork=$CurrentIdentityObject.SocialNetwork.Name }
            if (-not$PSBoundParameters['URL'])            { $URL=$CurrentIdentityObject.URL }
            if ($AllowMicrosoftToQueryMyId) {
                $PrivacyConsentStatus  = 'true'
            } else {
                $PrivacyConsentStatus = 'false'
            }

            switch ($SocialNetwork) {
                # missing 'Microsoft Connect' requires an MS account
                # missing 'Microsoft Office 365 forum' requires a displayname

                'Blog'     { $SNid = '202a47c1-33ca-e211-9b1f-00155da65f6a' ; break }
                'Code'     { $SNid = 'a57a64ac-33ca-e211-9b1f-00155da65f6a' ; break }
                'Codeplex' { $SNid = '334c64f8-417f-e311-93ff-002dd80c017c' ; break }
                'Exchange DL Subscription Email' {
                             $SNid = 'c3fc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'Facebook' { $SNid = 'c5fc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'GitHub'   { $SNid = 'ddf7c919-8081-e311-9401-00155da64d68' ; break }
                'Google+'  { $SNid = 'fd2a7ec7-1b60-e611-80ef-fc15b428778c' ; break }
                'Instagram'{ $SNid = '0ba62aea-1b60-e611-80ef-fc15b428778c' ; break }
                'Klout'    { $SNid = 'c9fc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'LinkedIn' { $SNid = 'cbfc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'Meetup'   { $SNid = '2b93c914-089f-e511-8114-c4346bac0abc' ; break }
                'Microsoft ASP.NET Forum' {
                             $SNid = '614bd123-4278-e311-9401-00155da64d68' ; break }
                'Microsoft IIS Forum' {
                             $SNid = 'ac372b19-4278-e311-9401-00155da64d68' ; break }
                'MS Community (MS Answers)' {
                             $SNid = 'cdfc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'MSDN/Technet' {
                             $SNid = 'cffc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'Naver ID' { $SNid = 'd1fc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'Other'    { $SNid = 'ddfc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'StackOverflow'  {
                             $SNid = '9aeda924-8081-e311-9401-00155da64d68' ; break }
                'Twitter'  { $SNid = 'd5fc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'Website'  { $SNid = '222a47c1-33ca-e211-9b1f-00155da65f6a' ; break }
                'Windows/Windows Phone Dev Center ID' {
                             $SNid = 'e673a268-8081-e311-9401-00155da64d68' ; break }
                'Xbox Live gamertag' {
                             $SNid = 'c7fc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'Xing'     { $SNid = 'd7fc56aa-4255-e211-811c-00155d2ee30b' ; break }
                'Yammer'   { $SNid = 'e473a268-8081-e311-9401-00155da64d68' ; break }
                'YouTube'  { $SNid = 'd9fc56aa-4255-e211-811c-00155d2ee30b' ; break }
                default    {}
            }

            $Body = @"
{
  "PrivateSiteId": "$($ID)",
  "SocialNetwork": {
    "Id": "$($SNid)",
    "Name": "$($SocialNetwork)",
    "IconUrl": "",
    "SystemCollectionEnabled": false
  },

  "Url": "$($URL)",
  "OnlineIdentityVisibility": {
    "Id": $($VisibilityObject.id),
    "Description": "$($VisibilityObject.Description)",
    "LocalizeKey": "$($VisibilityObject.LocalizeKey)"
  },
  "ContributionCollected": true,
  "DisplayName": "",
  "UserId": "",
  "MicrosoftAccount": "",
  "PrivacyConsentStatus": $($PrivacyConsentStatus),
  "PrivacyConsentCheckStatus": true,
  "PrivacyConsentCheckDate": "",
  "PrivacyConsentUnCheckDate": "",
  "Submitted": true
}
"@

            try {
                if ($pscmdlet.ShouldProcess($Body, "Updating Online Identity")){
                    Write-Verbose -Message "About to update online identity $($ID) with Body $($Body)"
                    Invoke-RestMethod @Splat -Body $Body
                }
            } catch {
                Write-Warning -Message "Failed to invoke the PutOnlineIdentity API because $($_.Exception.Message)"
            }

        } else {
            Write-Warning -Message "Online Id $($ID) probably not found"
        }
    }
}
End {}
}