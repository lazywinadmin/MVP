function New-MVPContribution
{
    [CmdletBinding()]
    PARAM(
        [parameter()]
        [System.String]$ContributionType='video',
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
        Method = 'POST'
        ContentType = 'application/json'
    }


    # Verify the Contribution Type
    $type = Get-MVPContributionType |where {$_.name -eq $ContributionType}

    # Verify the Contribution Technology
    $Technology = Get-MVPContributionArea | where {$_.name -eq $ContributionTechnology}

    # Get the Visibility
    $VisibilityObject = Get-MVPContributionVisibility -Visibility $Visibility

  $Body = @"
{
  "ContributionId": 0,
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