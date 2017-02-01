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
    PARAM(
        [System.String]$ProfileID
    )


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/profile?"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    #ProfileID
    if ($ProfileID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/profile/$ProfileID"
    }


    Invoke-RestMethod @Splat

    
}

# Current user
Get-MVPProfile

# Francois-Xavier Cat
Get-MVPProfile -ProfileID 5000475

# Emin Atac
Get-MVPProfile -ProfileID 5000890

