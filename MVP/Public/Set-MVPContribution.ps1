function Set-MVPContribution
{
<#
Set-MVPContribution -ContributionID 691729 -Description 'wowwwwwww!!!'
#>
    [CmdletBinding()]
    PARAM(
        [parameter(mandatory=$true)]
        $ContributionID,
        $ContributionType='video',
        $ContributionTechnology='PowerShell',
        $StardDate = '2017/02/01',
        $Title="Test from API",
        $Description="Some Descript",
        $ReferenceUrl="http://lazywinadmin.com",
        $AnnualQuantity=0,
        $SecondAnnualQuantity=0,
        $AnnualReach = 0,
        [ValidateSet('EveryOne','Microsoft')]
        $Visibility = 'Microsoft'
    )
    TRY{
    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/contributions"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode
            ContentType = 'application/json'
            }
        Method = 'PUT'
        ContentType = 'application/json'
    }

    # Retrieve current Object
    $CurrentContributionObject = Get-MVPContribution -ID $ContributionID

    IF($PSBoundParameters['ContributionType'])
    {
        # Verify the Contribution Type
        $type = Get-MVPContributionType |where {$_.name -eq $ContributionType}
    }ELSE{$type = $CurrentContributionObject.ContributionType}

    IF($PSBoundParameters['ContributionTechnology'])
    {
        # Verify the Contribution Technology
        $Technology = Get-MVPContributionArea | where {$_.name -eq $ContributionTechnology}
    }else{$Technology = $CurrentContributionObject.ContributionTechnology}

    # Get the Visibility
    IF($PSBoundParameters['Visibility'])
    {
        $VisibilityObject = Get-MVPContributionVisibility -Visibility $Visibility
    }else{$VisibilityObject=$CurrentContributionObject.Visibility}

    IF(-not$PSBoundParameters['StartDate']){$StartDate=$CurrentContributionObject.StartDate}
    IF(-not$PSBoundParameters['Title']){$Title=$CurrentContributionObject.Title}
    IF(-not$PSBoundParameters['Description']){$Description=$CurrentContributionObject.Description}
    IF(-not$PSBoundParameters['ReferenceUrl']){$ReferenceUrl=$CurrentContributionObject.ReferenceUrl}
    IF(-not$PSBoundParameters['AnnualQuantity']){$AnnualQuantity=$CurrentContributionObject.AnnualQuantity}
    IF(-not$PSBoundParameters['SecondAnnualQuantity']){$StartDate=$CurrentContributionObject.SecondAnnualQuantity}
    IF(-not$PSBoundParameters['AnnualReach']){$StartDate=$CurrentContributionObject.AnnualReach}

  $Body = @"
{
  "ContributionId": $ContributionID,
  "ContributionTypeName": "$($type.name)",
  "ContributionType": {
    "Id": "$($type.id)",
    "Name": "$($type.name)",
    "EnglishName": "$($type.englishname)"
  },
  "ContributionTechnology": {
    "Id": "$($Technology.id)",
    "Name": "$($Technology.name)",
    "AwardName": "$($Technology.awardname)",
    "AwardCategory": "$($Technology.awardcategory)"
  },
  "StartDate": "$StardDate",
  "Title": "$Title",
  "ReferenceUrl": "$ReferenceUrl",
  "Visibility": {
    "Id": $($VisibilityObject.id),
    "Description": "$($VisibilityObject.Description)",
    "LocalizeKey": "$($VisibilityObject.LocalizeKey)"
  },
  "AnnualQuantity": $AnnualQuantity,
  "SecondAnnualQuantity": $SecondAnnualQuantity,
  "AnnualReach": $AnnualReach,
  "Description": "$Description"
}
"@  
    Invoke-RestMethod @Splat -Body $Body

    }
    CATCH{
        $PSCmdlet.ThrowTerminatingError($_)
    }
}