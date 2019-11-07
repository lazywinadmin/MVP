Function Test-MVPContribution {
<#
.SYNOPSIS
    Tests for matching MVP Contributions on your MVP profile

.DESCRIPTION
    The Test-MVPContribution function looks for contributions that match supplied criteria.

    It can either return a boolean value, or the matching object.

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

.PARAMETER ReferenceUrl
    Specifies the Url of the activity

.PARAMETER ReturnMatch
    Returns the matching contribution, rather than a boolean value

.EXAMPLE
    Test-MVPContribution -Title 'PowerShell Command Precedence' -ReferenceUrl 'https://lazywinadmin.com/2017/06/CommandPrecedence.html'

    This command returns $true if a contribution is found with both a matching title and url

.EXAMPLE
    Test-MVPContribution -Title 'User Group Presentation - FRPSUG' -ReturnMatch

    This command returns the matching contribution object if it is found

.NOTES
    https://github.com/lazywinadmin/MVP
#>
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [String]$StartDate,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [String]$Title,

        [Parameter(ValueFromPipelineByPropertyName=$true)]
        [String]$ReferenceUrl,

        [Switch]$ReturnMatch
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
        $Param1Att.Mandatory = $false
        $Param1Att.ValueFromPipelineByPropertyName = $true
        $Param1Att.ParameterSetName = '__AllParameterSets'
        $AttribColl1.Add($Param1Att)
        $AttribColl1.Add((New-Object -TypeName System.Management.Automation.ValidateSetAttribute -ArgumentList (Get-MVPContributionArea -All | Select-Object -ExpandProperty Name)))
        $Dictionary.Add($ParameterName,(New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter -ArgumentList ($ParameterName, [string], $AttribColl1)))

        # ContributionType
        $ParameterID = 'ContributionType'
        $AttribColl2 = New-Object -TypeName System.Collections.ObjectModel.Collection[System.Attribute]
        $Param2Att = New-Object -TypeName System.Management.Automation.ParameterAttribute
        $Param2Att.Mandatory = $false
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
        $Dictionary.Add($ParameterName3,(New-Object -TypeName System.Management.Automation.RuntimeDefinedParameter -ArgumentList ($ParameterName3, [string], $AttribColl3)))

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

            Write-Verbose -message "[$Scriptname] Getting all contributions, using New-MVPContribution"
            $Contributions = [System.Collections.ArrayList]::new()
            $ContribLimit = 100
            $More = $true

            while ($More) {
                $Offset = $ContribLimit - 100
                Write-Verbose -message "[$Scriptname] Getting $ContribLimit contributions with an offset of $Offset"
                $ContribGroup = Get-MVPContribution -Limit $ContribLimit -Offset $Offset

                if (($ContribGroup | Measure-Object).Count -lt 100) {
                    Write-Verbose -message "[$Scriptname] Last set of contributions received"
                    $More = $false
                } else {
                    Write-Verbose -message "[$Scriptname] 100 contributions received, there may be more..."
                    $ContribLimit += 100
                }

                Write-Verbose -message "[$Scriptname] Adding contributions to collection"
                foreach ($Contrib in $ContribGroup) {
                    $null = $Contributions.Add($Contrib)
                }
            }

            Write-Verbose -message "[$Scriptname] Testing collection against supplied criteria"
            $MacthFound = $false
            foreach ($Contribution in $Contributions) {
                $PossibleMatch = $true
                foreach ($BoundParam in $PSBoundParameters.GetEnumerator()) {
                    $Key = $BoundParam.Key
                    if ($Contribution.$Key -notlike "$($BoundParam.Value)*") {
                        $PossibleMatch = $false
                        break
                    }
                }

                if ($PossibleMatch) {
                    $MacthFound = $true

                    if ($ReturnMatch) {
                        $Contribution
                    }

                    break
                }
            }

            if (!$ReturnMatch) {
                $MacthFound
            }
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}
