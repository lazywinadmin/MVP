Function Get-MVPContributionVisibility {
<#
    .SYNOPSIS
        Invoke the GetSharingPreferences REST API to retrieve contribution visibility types

    .DESCRIPTION
        Gets a list of Sharing Preference / Visibility Types for Contributions

    .EXAMPLE
        Get-MVPContributionVisibility

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
            Uri = 'https://mvpapi.azure-api.net/mvp/api/contributions/sharingpreferences'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }

        try {
            (Invoke-RestMethod @Splat)
        } catch {
            Write-Warning -Message "Failed to invoke the GetSharingPreferences API because $($_.Exception.Message)"
        }
    }
}
End {}
}