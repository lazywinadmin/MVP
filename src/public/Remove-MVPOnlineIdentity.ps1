Function Remove-MVPOnlineIdentity {
<#
    .SYNOPSIS
        Invoke the DeleteOnlineIdentity REST API

    .DESCRIPTION
        Deletes an online identity

    .PARAMETER ID
        It's the id of an online identity

    .EXAMPLE
#>
[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='High')]
Param(
    [Parameter(Mandatory)]
    [Alias('PrivateSiteId')]
    [int32]$ID
)
Begin {}
Process {

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'
    } else {

        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        $Splat = @{
            Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities?id=$($ID)"
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
            }
            Method = 'DELETE'
            ErrorAction = 'Stop'
        }

        if ($pscmdlet.ShouldProcess($ID,'Remove item')) {

            try {
                Invoke-RestMethod @Splat
                Write-Verbose -Message "Online Identity $($ID) deleted"
            } catch {
                Write-Warning -Message "Failed to invoke the DeleteOnlineIdentity API because $($_.Exception.Message)"
            }
        }
    }
}
End {}
}