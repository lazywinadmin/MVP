function Set-MVPConfiguration
{
<#
Set-MVPConfiguration -PrimaryKey '<key>' -AuthorizationCode '<Auth>'
#>
	[CmdletBinding()]
	PARAM (
        $ClientID,
        $SubscriptionKey)
	
    $output = Get-MVPOAuthAutorizationCode -ClientID $ClientID -SubscriptionKey $SubscriptionKey
    $global:MVPPrimaryKey = $SubscriptionKey
    $global:MVPAuthorizationCode = ('{0} {1}' -f $output.token_type,$output.access_token)
}