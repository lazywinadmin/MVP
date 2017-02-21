function Remove-MVPContribution
{
<#
Remove-MVPContribution -ID 683377
#>
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact="High")]
    PARAM(
        [parameter(Mandatory=$true)]
        [System.String]$ID
    )


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/contributions?id=$ID"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
        Method = 'DELETE'
    }

    if ($pscmdlet.ShouldProcess($ID,"Remove item")) {
        Invoke-RestMethod @Splat
    }
}