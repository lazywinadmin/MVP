Function Get-MVPContributionArea {
<#
    .SYNOPSIS
        Invoke the GetContributionAreas REST API to retrieve your contribution areas

    .DESCRIPTION
        Gets a list of Contribution areas grouped by Award Names

    .PARAMETER Other
        It gets the list of Other Award Categories

    .PARAMETER All
        It gets the list of all Award Category names

    .EXAMPLE
        Get-MVPContributionArea

        It gets the list of your awarded Categories

    .EXAMPLE
        Get-MVPContributionArea -Other
        
        It gets the list of Other award categories
#>
[CmdletBinding(DefaultParameterSetName='Mine')]
Param(
    [parameter(ParameterSetName='Other')]
    [switch]$Other,

    [parameter(ParameterSetName='All')]
    [switch]$All
)
Begin {}
Process {


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
    } else {

        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey
        
        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/contributions/contributionareas'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }
        try {
            $careas = (Invoke-RestMethod @Splat)

            Switch($PsCmdlet.ParameterSetName) {
                'Mine' {
                    ($careas | Where { $_.AwardCategory -eq 'My Awarded Category' }).Contributions
                    break
                }
                'Other' {
                    ($careas | Where { $_.AwardCategory -eq 'Other Award Category' }).Contributions.contributionarea
                    break
                }
                'All' {
                    $careas.Contributions.contributionarea
                    break
                }
                default{}

            }
        } catch {
            Write-Warning -Message "Failed to invoke the GetContributionAreas API because $($_.Exception.Message)"
        }
    }
}
End {}
}