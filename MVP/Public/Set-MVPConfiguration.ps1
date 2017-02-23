Function Set-MVPConfiguration {
[CmdletBinding()]
PARAM (
    [Parameter()]
    [string]$ClientID='0000000048193351',

    [Parameter(Mandatory)]
    [string]$SubscriptionKey
)
Begin {}
Process {
    try {
        Get-MVPOAuthAutorizationCode -ClientID $ClientID -SubscriptionKey $SubscriptionKey -ErrorAction Stop
        Write-Verbose -Message 'Successfully call the Get-MVPOAuthAutorizationCode function'
    } catch {
        Write-Warning -Message 'Something went wrong with the private function Get-MVPOAuthAutorizationCode'
    }
    if ($MVPOauth2) {
        $global:MVPPrimaryKey = $SubscriptionKey
        $global:MVPAuthorizationCode = ('{0} {1}' -f $MVPOauth2.token_type,$MVPOauth2.access_token)
        Write-Verbose -Message 'Successfully set the global variables MVPPrimaryKey and MVPAuthorizationCode'
    } else {
        Write-Warning -Message 'Failed to define an MVPAuthorizationCode variable'
    }
}
End {}
}
<#
    .SYNOPSIS
        Get an Oauth Autorization code

    .DESCRIPTION
        Call the private Get-MVPOAuthAutorizationCode function and define both an MVPPrimaryKey and MVPAuthorizationCode global variable

    .PARAMETER SubscriptionKey
        It's the primary key or secondary key you get in your profile on this page https://mvpapi.portal.azure-api.net/developer

    .PARAMETER ClientID
        It's the clientID you see in the url of the MVPAuth application on your https://account.live.com/consent/Manage page

    .EXAMPLE

    Set-MVPConfiguration -SubscriptionKey $myKey

#>