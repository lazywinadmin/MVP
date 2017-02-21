function Get-MVPOnlineIdentity
{
<#
Get-MVPOnlineIdentity
Get-MVPOnlineIdentity -ID 106307
Get-MVPOnlineIdentity -NominationID "??"
#>
    [CmdletBinding()]
    PARAM(
        [System.String]$ID,
        $NominationID
    )


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    
    if ($ID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities/$ID"
    }
    if ($NominationID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities/$NominationID"
    }


    Invoke-RestMethod @Splat
    
}