function Get-MVPProfile
{<#
# Current user
Get-MVPProfile

# Francois-Xavier Cat
Get-MVPProfile -ID 5000475

# Emin Atac
Get-MVPProfile -ID 5000890
#>
    [CmdletBinding()]
    PARAM(
        [System.String]$ID
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
    if ($ID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/profile/$ID"
    }


    Invoke-RestMethod @Splat

    
}