Function Get-MVPContributionType {
<#
    .SYNOPSIS
        Invoke the GetContributionTypes REST API to retrieve contribution types

    .DESCRIPTION
        Gets a list of contribution types


    .EXAMPLE
        Get-MVPContributionType

        It gets the list of contribution types
#>
[CmdletBinding()]
Param()
Begin {}
Process {

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {

    Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'

    } else {

        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/contributions/contributiontypes'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }
        try {
             [PSCustomObject[]](Invoke-RestMethod @Splat)
        } catch {
            Write-Warning -Message "Failed to invoke the GetContributionTypes API because $($_.Exception.Message)"
        }
    }
}
End {}
}