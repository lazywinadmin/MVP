Function Set-MVPConfiguration {
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

.NOTES
    https://github.com/lazywinadmin/MVP
#>
[CmdletBinding(SupportsShouldProcess=$true)]
PARAM (
    [Parameter()]
    [System.String]$ClientID='0000000048193351',

    [Parameter(Mandatory)]
    [System.String]$SubscriptionKey
)
Process {
    Try{
        $Scriptname = (Get-Variable -name MyInvocation -Scope 0 -ValueOnly).MyCommand

        Write-Verbose -Message "[$Scriptname] Get OAuth Autorization code"
        Get-MVPOAuthAutorizationCode -ClientID $ClientID -SubscriptionKey $SubscriptionKey -ErrorAction Stop
        Write-Verbose -Message "[$Scriptname] Successfully call the Get-MVPOAuthAutorizationCode function"

        if ($MVPOauth2) {
            if ($pscmdlet.ShouldProcess($ClientID, "Updating Configuration")){
                Write-Verbose -Message "[$Scriptname] OAuth Autorization code retrieved"
                Write-Verbose -Message "[$Scriptname] Set Variables 'MVPPrimaryKey' and 'MVPAuthorizationCode'"
                $global:MVPPrimaryKey = $SubscriptionKey
                $global:MVPAuthorizationCode = ('{0} {1}' -f $MVPOauth2.token_type,$MVPOauth2.access_token)
                Write-Verbose -Message "[$Scriptname] Successfully set the global variables MVPPrimaryKey and MVPAuthorizationCode"
            }
        } else {
            Write-Error -Message "[$Scriptname] Failed to define an MVPAuthorizationCode variable"
        }

    }
    catch
    {
        # Return the last error
        $PSCmdlet.ThrowTerminatingError($_)
    }
}
}