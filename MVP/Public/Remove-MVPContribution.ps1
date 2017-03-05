Function Remove-MVPContribution {
<#
    .SYNOPSIS
        Invoke the DeleteContribution REST API

    .DESCRIPTION
        Deletes a Contribution item

    .PARAMETER ID
        It's the id of a contribution

    .EXAMPLE
#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact='High')]
Param(
    [Parameter(Mandatory)]
    [String]$ID
)
Begin {}
Process {

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
	    Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'
    } else {

        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        $Splat = @{
            Uri = "https://mvpapi.azure-api.net/mvp/api/contributions?id=$($ID)"
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
                Write-Verbose -Message "Contribution $($ID) deleted"
            } catch {
                Write-Warning -Message "Failed to invoke the DeleteContribution API because $($_.Exception.Message)"
            }
        }
    }
}
End {}
}