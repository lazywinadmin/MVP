Function Test-MVPContribution {
<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER OnePlaceholder

.PARAMETER TwoPlaceholder

.PARAMETER ThreePlaceholder

.EXAMPLE

.EXAMPLE

.NOTES
    https://github.com/lazywinadmin/MVP
#>
    [CmdletBinding()]
    Param(
        [int32]$One,
        [int32]$Two,
        [int32]$Three
    )
    DynamicParam {
        # Borrowing dynamic parameters from New-MVPContribution
        # Using this should mean that supplied values are valid and correct

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
        $AttribColl1.Add((New-Object -TypeName System.Management.Automation.ValidateSetAttribute(Get-MVPContributionArea -All | Select-Object -ExpandProperty Name)))
        $Dictionary.Add($ParameterName,(New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttribColl1)))
        
        # ContributionType
        $ParameterID = 'ContributionType'
        $AttribColl2 = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
        $Param2Att = New-Object -TypeName System.Management.Automation.ParameterAttribute
        $Param2Att.Mandatory = $true
        $Param2Att.ValueFromPipelineByPropertyName=$true
        $Param2Att.ParameterSetName = '__AllParameterSets'
        $AttribColl2.Add($Param2Att)
        $AttribColl2.Add((New-Object -TypeName System.Management.Automation.ValidateSetAttribute(Get-MVPContributionType | Select-Object -ExpandProperty Name)))
        $Dictionary.Add($ParameterID,(New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($ParameterID, [string], $AttribColl2)))
        
        # AdditionalTechnologies
        $ParameterName3 = 'AdditionalTechnologies'
        $AttribColl3 = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
        $Param3Att = New-Object -TypeName System.Management.Automation.ParameterAttribute
        $Param3Att.Mandatory = $false
        $Param3Att.ValueFromPipelineByPropertyName = $true
        $Param3Att.ParameterSetName = '__AllParameterSets'
        $AttribColl3.Add($Param3Att)
        $AttribColl3.Add((New-Object -TypeName System.Management.Automation.ValidateSetAttribute(Get-MVPContributionArea -All | Select-Object -ExpandProperty Name)))
        $Dictionary.Add($ParameterName3,(New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter($ParameterName3, [string], $AttribColl3)))
        
        #Return dictionary
        $Dictionary
    }
    Process {
        $Scriptname = (Get-Variable -name MyInvocation -Scope 0 -ValueOnly).MyCommand
        if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
            Write-Warning -Message "[$Scriptname] You need to use Set-MVPConfiguration first to set the Primary Key"
            break
        }
        Try {
            Write-Verbose -message "[$Scriptname] Set Configuration"
            Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey
            Write-Verbose -message "[$Scriptname] Build Splatting"
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}
