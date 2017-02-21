function Get-MVPContributionArea
{
    [CmdletBinding()]
    PARAM()


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/contributionareas"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    (Invoke-RestMethod @Splat).contributions.contributionarea
}