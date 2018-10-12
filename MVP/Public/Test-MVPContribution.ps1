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
        # Borrowing dynsmic parameters from New-MVPContribution
        # Using this should mean that supplied values are valid and correct
        $Dictionary = New-Object -TypeName System.Management.Automation.RuntimeDefinedParameterDictionary

        $ParameterName = 'ContributionTechnology'
        $AttribColl1 = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $Param1Att = New-Object System.Management.Automation.ParameterAttribute
        $Param1Att.Mandatory = $false
        $Param1Att.ValueFromPipelineByPropertyName = $true
        $Param1Att.ParameterSetName = '__AllParameterSets'
        $AttribColl1.Add($Param1Att)
        $AttribColl1.Add((New-Object System.Management.Automation.ValidateSetAttribute(Get-MVPContributionArea -All | Select-Object -ExpandProperty Name)))
        $Dictionary.Add($ParameterName,(New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttribColl1)))

        $ParameterID = 'ContributionType'
        $AttribColl2 = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $Param2Att = New-Object System.Management.Automation.ParameterAttribute
        $Param2Att.Mandatory = $false
        $Param2Att.ValueFromPipelineByPropertyName=$true
        $Param2Att.ParameterSetName = '__AllParameterSets'
        $AttribColl2.Add($Param2Att)
        $AttribColl2.Add((New-Object System.Management.Automation.ValidateSetAttribute(Get-MVPContributionType | Select-Object -ExpandProperty Name)))
        $Dictionary.Add($ParameterID,(New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterID, [string], $AttribColl2)))
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
