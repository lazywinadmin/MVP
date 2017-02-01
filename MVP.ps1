function Set-MVPConfiguration
{
	[CmdletBinding()]
	PARAM ($PrimaryKey,$AuthorizationCode)
	Write-Verbose -Message "Set MVP Primary Key: $PrimaryKey"
	$global:MVPPrimaryKey = $PrimaryKey
    $global:MVPAuthorizationCode = $AuthorizationCode
}


Set-MVPConfiguration -PrimaryKey '<key>' -AuthorizationCode '<Auth>'

function Get-MVPProfile
{
    [CmdletBinding()]
    PARAM()
    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    Invoke-RestMethod -Uri "https://mvpapi.azure-api.net/mvp/api/profile?" -Headers @{
        "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
        Authorization = $Global:MVPAuthorizationCode

    } -Verbose
}

Get-MVPProfile

