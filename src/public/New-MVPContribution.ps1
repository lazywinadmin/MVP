Function New-MVPContribution {
<#
    .SYNOPSIS
        Invoke the PostContribution REST API

    .DESCRIPTION
        Creates a new Contribution item

    .PARAMETER ContributionTechnology
        Specifies the Contribution technology
        This parameter is dynamic and is retrieving the information from Get-MVPContributionArea

    .PARAMETER AdditionalTechnologies
        Specifies an additional Contribution
        This parameter is dynamic and is retrieving the information from Get-MVPContributionArea

    .PARAMETER ContributionType
        Specifies the Contribution Type
        This parameter is dynamic and is retrieving the information from Get-MVPContributionType

    .PARAMETER StartDate
        Specifies the Date of the activity

    .PARAMETER Title
        Specifies the Title of the activity

    .PARAMETER Description
        Specifies the Description of the activity

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
    $Splat = @{
        startdate ='2018/10/10'
        Title='Test from mvpapi.azure-api.net'
        Description = 'Description sample'
        ReferenceUrl='https://github.com/lazywinadmin/MVP'
        AnnualQuantity='1'
        SecondAnnualQuantity='0'
        AnnualReach = '0'
        Visibility = 'EveryOne' # Get-MVPContributionVisibility
        ContributionType = 'Blog Site Posts' # Get-MVPContributionType
        ContributionTechnology = 'PowerShell' # Get-MVPContributionArea
        AdditionalTechnologies = 'ARM & DevOps on Azure (Chef, Puppet, Salt, Ansible, Dev/Test Lab)' # Get-MVPContributionArea
    }
    New-MVPContribution @splat

    This will create a new MVP Contribution using the current session opened by Set-MVPConfiguration

    .NOTES
        https://github.com/lazywinadmin/MVP
#>
[CmdletBinding(SupportsShouldProcess=$true)]
Param(
    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]$StartDate = (Get-Date -Format 'yyyy/MM/dd'),

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]$Title='Test from mvpapi.azure-api.net',

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]$Description='Description sample',

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]$ReferenceUrl='https://github.com/lazywinadmin/MVP',

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]$AnnualQuantity='1',

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]$SecondAnnualQuantity='0',

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [String]$AnnualReach = '0',

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [ValidateSet('EveryOne','Microsoft','MVP Community','Microsoft Only')]
    [String]$Visibility = 'Microsoft'
)
DynamicParam {
    # Create dictionary
    $Dictionary = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

    # ContributionTechnology
    $ParameterName = 'ContributionTechnology'
    $AttribColl1 = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
    $Param1Att = New-Object -TypeName System.Management.Automation.ParameterAttribute
    $Param1Att.Mandatory = $true
    $Param1Att.ValueFromPipelineByPropertyName = $true
    $Param1Att.ParameterSetName = '__AllParameterSets'
    $AttribColl1.Add($Param1Att)
    $AttribColl1.Add((New-Object -TypeName System.Management.Automation.ValidateSetAttribute -ArgumentList (Get-MVPContributionArea -All | Select-Object -ExpandProperty Name)))
    $Dictionary.Add($ParameterName,(New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter -ArgumentList ($ParameterName, [string], $AttribColl1)))

    # ContributionType
    $ParameterID = 'ContributionType'
    $AttribColl2 = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
    $Param2Att = New-Object -TypeName System.Management.Automation.ParameterAttribute
    $Param2Att.Mandatory = $true
    $Param2Att.ValueFromPipelineByPropertyName=$true
    $Param2Att.ParameterSetName = '__AllParameterSets'
    $AttribColl2.Add($Param2Att)
    $AttribColl2.Add((New-Object -TypeName System.Management.Automation.ValidateSetAttribute -ArgumentList (Get-MVPContributionType | Select-Object -ExpandProperty Name)))
    $Dictionary.Add($ParameterID,(New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter -ArgumentList ($ParameterID, [string], $AttribColl2)))

    # AdditionalTechnologies
    $ParameterName3 = 'AdditionalTechnologies'
    $AttribColl3 = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
    $Param3Att = New-Object -TypeName System.Management.Automation.ParameterAttribute
    $Param3Att.Mandatory = $false
    $Param3Att.ValueFromPipelineByPropertyName = $true
    $Param3Att.ParameterSetName = '__AllParameterSets'
    $AttribColl3.Add($Param3Att)
    $AttribColl3.Add((New-Object -TypeName System.Management.Automation.ValidateSetAttribute -ArgumentList (Get-MVPContributionArea -All | Select-Object -ExpandProperty Name)))
    $Dictionary.Add($ParameterName3,(New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter -ArgumentList ($ParameterName3, [string[]], $AttribColl3)))

    #Return dictionary
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
                ContentType = 'application/json; charset=utf-8'
                }
            Method = 'POST'
            ContentType = 'application/json; charset=utf-8'
            ErrorAction = 'Stop'
        }

        if (-not $Script:MVPCachedTypes) {
            $Script:MVPCachedTypes = [ordered] @{
                ContributionType = Get-MVPContributionType
                ContributionArea = Get-MVPContributionArea -All
                Visibility       = Get-MVPContributionVisibility
            }
        }

        # Verify the Contribution Type
        $type = $Script:MVPCachedTypes['ContributionType'] | Where-Object -FilterScript { $_.name -eq $PSBoundParameters['ContributionType'] }

        # Verify the Contribution Technology
        $Technology = $Script:MVPCachedTypes['ContributionArea'] | Where-Object -FilterScript { $_.name -eq $PSBoundParameters['ContributionTechnology'] }

        # Verify the Additional Technology
        [Array] $AdditionalTechnologies = $Script:MVPCachedTypes['ContributionArea'] | Where-Object -FilterScript { $_.name -in $PSBoundParameters['AdditionalTechnologies'] }

        # Get the Visibility
        $VisibilityObject = $Script:MVPCachedTypes['Visibility'] | Where-Object -FilterScript { $_.Description -eq $Visibility }

        $HashTableContribution = @{
            "ContributionId"         = 0
            "ContributionTypeName"   = "$($type.name)"
            "ContributionType"       = @{
                "Id"          = "$($type.id)"
                "Name"        = "$($type.name)"
                "EnglishName" = "$($type.englishname)"
            }
            "ContributionTechnology" = @{
                "Id"            = "$($Technology.id)"
                "Name"          = "$($Technology.name)"
                "AwardName"     = "$($Technology.awardname)"
                "AwardCategory" = "$($Technology.awardcategory)"
            }
            "StartDate"              = "$StartDate"
            "Title"                  = "$Title"
            "ReferenceUrl"           = "$ReferenceUrl"
            "Visibility"             = @{
                "Id"          = $($VisibilityObject.id)
                "Description" = "$($VisibilityObject.Description)"
                "LocalizeKey" = "$($VisibilityObject.LocalizeKey)"
            }
            "AnnualQuantity"         = $AnnualQuantity
            "SecondAnnualQuantity"   = $SecondAnnualQuantity
            "AnnualReach"            = $AnnualReach
            "Description"            = "$Description"
        }
        if ($AdditionalTechnologies) {
            $HashTableContribution["AdditionalTechnologies"] = @(
                foreach ($Technology in $AdditionalTechnologies) {
                    @{
                        "Id"            = "$($Technology.id)"
                        "Name"          = "$($Technology.name)"
                        "AwardName"     = "$($Technology.awardname)"
                        "AwardCategory" = "$($Technology.awardcategory)"
                    }
                }
            )
        }
        $Body = $HashTableContribution | ConvertTo-Json
        try {
            if ($pscmdlet.ShouldProcess($Body, "Create a new contribution")){
                Write-Verbose -Message "About to create a new contribution with Body $($Body)"
                Invoke-RestMethod @Splat -Body $Body
            }
        } catch {
            Write-Warning -Message "Failed to invoke the PostContribution API because $($_.Exception.Message)"
        }
    }
}
End {}
}