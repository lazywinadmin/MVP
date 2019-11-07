Function Set-MVPContribution {
<#
    .SYNOPSIS
        Invoke the PutContribution REST API

    .DESCRIPTION
        Updates a Contribution item

    .PARAMETER ContributionID
        Specify the Contribution ID to modify

    .PARAMETER ContributionTechnology
        Specify the ContributionTechnology (see Get-MVPContributionArea)

    .PARAMETER ContributionType
        Specify the ContributionType (see Get-MVPContributionType)

    .PARAMETER StartDate
        Specify the StartDate of the contribution

        Example '2018/10/10'
    .PARAMETER Title
        Specify the Title of your contribution

    .PARAMETER Description
        Specify the Description of your contribution

    .PARAMETER ReferenceUrl
        Specifies the Url of the activity

    .PARAMETER AnnualQuantity
        Specifies the Annual quantity.
        Default is 1

    .PARAMETER SecondAnnualQuantity
        Specifies the Second Annual quantity.
        Default is 0

    .PARAMETER AnnualReach
        Specifies the Annual Reach
        Default is 0

    .PARAMETER Visibility
        Specifies the audience that will be able to see your activity
        Values: 'EveryOne','Microsoft','MVP Community','Microsoft Only'
        Default = 'Microsoft'

    .EXAMPLE
        Set-MVPContribution -ContributionID 691729 -Description 'wowwwwwww!!!'

    .EXAMPLE
        Get-MVPContribution -ContributionId 700210 | Set-MVPContribution -Description "wwooowww!!" -Verbose
#>
[CmdletBinding(SupportsShouldProcess=$true)]
Param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
    [int32]$ContributionID,

    [Parameter()]
    [string]$ContributionType='video',

    [Parameter()]
    [string]$ContributionTechnology='PowerShell',

    [Parameter()]
    [String]$StartDate = '2017/02/01',

    [Parameter()]
    [String]$Title='Test from mvpapi.azure-api.net',

    [Parameter()]
    [String]$Description='Description sample',

    [Parameter()]
    [String]$ReferenceUrl='https://github.com/lazywinadmin/MVP',

    [Parameter()]
    [String]$AnnualQuantity='0',

    [Parameter()]
    [String]$SecondAnnualQuantity='0',

    [Parameter()]
    [String]$AnnualReach = '0',

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
            Uri = 'https://mvpapi.azure-api.net/mvp/api/contributions'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
                ContentType = 'application/json'
            }
            Method = 'PUT'
            ContentType = 'application/json'
            ErrorAction = 'Stop'
        }

        # Retrieve contribution
        $CurrentContributionObject = Get-MVPContribution -ID $ContributionID

        if ($CurrentContributionObject) {

            if ($PSBoundParameters['ContributionType']) {
                # Verify the Contribution Type
                $type = Get-MVPContributionType | Where-Object -FilterScript {$_.name -eq $ContributionType}
            } else {
                $type = $CurrentContributionObject.ContributionType
            }

            if ($PSBoundParameters['ContributionTechnology']) {
                # Verify the Contribution Technology
                $Technology = Get-MVPContributionArea -All | Where-Object -FilterScript {$_.name -eq $ContributionTechnology}
            } else {
                $Technology = $CurrentContributionObject.ContributionTechnology
            }

            # Get the Visibility
            if ($PSBoundParameters['Visibility']) {
                $VisibilityObject =  Get-MVPContributionVisibility | Where-Object -FilterScript {$_.Description -eq $Visibility }
            } else {
                $VisibilityObject=$CurrentContributionObject.Visibility
            }

            if (-not$PSBoundParameters['StartDate'])            { $StartDate=$CurrentContributionObject.StartDate }
            if (-not$PSBoundParameters['Title'])                { $Title=$CurrentContributionObject.Title }
            if (-not$PSBoundParameters['Description'])          { $Description=$CurrentContributionObject.Description }
            if (-not$PSBoundParameters['ReferenceUrl'])         { $ReferenceUrl=$CurrentContributionObject.ReferenceUrl }
            if (-not$PSBoundParameters['AnnualQuantity'])       { $AnnualQuantity=$CurrentContributionObject.AnnualQuantity }
            if (-not$PSBoundParameters['SecondAnnualQuantity']) { $SecondAnnualQuantity=$CurrentContributionObject.SecondAnnualQuantity }
            if (-not$PSBoundParameters['AnnualReach'])          { $AnnualReach=$CurrentContributionObject.AnnualReach }

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
  "StartDate": "$StartDate",
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
            if ($type -and $Technology) {
                try {
                    if ($pscmdlet.ShouldProcess($Body, "Updating Contribution")){
                        Write-Verbose -Message "About to update contribution $($ContributionID) with Body $($Body)"
                        Invoke-RestMethod @Splat -Body $Body
                    }
                } catch {
                    Write-Warning -Message "Failed to invoke the PutContribution API because $($_.Exception.Message)"
                }
            } else {
                Write-Warning -Message "Either contributiontype or contributionarea isn't recognized"
            }
        } else {
            Write-Warning -Message "ContributionId $($ContributionID) probably not found"
        }
    }
}
End {}
}