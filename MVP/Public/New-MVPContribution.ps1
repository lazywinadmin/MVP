Function New-MVPContribution {
<#
    .SYNOPSIS
        Invoke the PostContribution REST API

    .DESCRIPTION
        Creates a new Contribution item

    .PARAMETER ContributionTechnology
    .PARAMETER ContributionType
    .PARAMETER StartDate
    .PARAMETER Title
    .PARAMETER Description
    .PARAMETER ReferenceUrl
    .PARAMETER AnnualQuantity
    .PARAMETER SecondAnnualQuantity
    .PARAMETER AnnualReach
    .PARAMETER Visibility

    .EXAMPLE
        New-MVPContribution -ContributionType Video -ContributionTechnology PowerShell 
#>
[CmdletBinding()]
Param(
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
DynamicParam {

    $Dictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

    $ParameterName = 'ContributionTechnology'
    $AttribColl1 = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $Param1Att = New-Object System.Management.Automation.ParameterAttribute
    $Param1Att.Mandatory = $true
    $Param1Att.ParameterSetName = '__AllParameterSets'
    $AttribColl1.Add($Param1Att)
    $AttribColl1.Add((New-Object System.Management.Automation.ValidateSetAttribute(Get-MVPContributionArea -All | Select-Object -ExpandProperty Name)))
    $Dictionary.Add($ParameterName,(New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttribColl1)))

    $ParameterID = 'ContributionType'
    $AttribColl2 = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
    $Param2Att = New-Object System.Management.Automation.ParameterAttribute
    $Param2Att.Mandatory = $true
    $Param2Att.ParameterSetName = '__AllParameterSets'
    $AttribColl2.Add($Param2Att)
    $AttribColl2.Add((New-Object System.Management.Automation.ValidateSetAttribute(Get-MVPContributionType | Select-Object -ExpandProperty Name)))
    $Dictionary.Add($ParameterID,(New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterID, [string], $AttribColl2)))
    $Dictionary
}
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
            Method = 'POST'
            ContentType = 'application/json'
            ErrorAction = 'Stop'
        }

        # Verify the Contribution Type
        $type = Get-MVPContributionType | Where {$_.name -eq $PSBoundParameters['ContributionType']}

        # Verify the Contribution Technology
        $Technology = Get-MVPContributionArea -All | Where {$_.name -eq $PSBoundParameters['ContributionTechnology']}

        # Get the Visibility
        $VisibilityObject = Get-MVPContributionVisibility | Where {$_.Description -eq $Visibility }

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
        try {
            Write-Verbose "About to create a new contribution with Body $($Body)"
            Invoke-RestMethod @Splat -Body $Body
        } catch {
            Write-Warning -Message "Failed to invoke the PostContribution API because $($_.Exception.Message)"
        }
    }     
}
End {}
}