Function Get-MVPProfile {
<#
    .SYNOPSIS
        Invoke the GetMVPProfile REST API to retrieve an MVP profile summary

    .DESCRIPTION
        Gets a user public profile with the MVP id passed as a parameter or gets your MVP profile summary without parameter

    .PARAMETER ID
        It's an MVP id

    .EXAMPLE
        Get-MVPProfile

        It gets your MVP profile summary

    .EXAMPLE
        Get-MVPProfile -ID 5000475

        It gets the public profile of Francois-Xavier Cat

    .EXAMPLE
        Get-MVPProfile -ID '5000890'

        It gets the public profile of Emin Atac
#>
[CmdletBinding()]
Param(
    [Parameter()]
    [String]$ID
)
Begin {}
Process {
    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {

        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'

    } else {

        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/profile?'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey ;
                Authorization = $global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop' ;
        }

        if ($ID) {
            $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/profile/$ID"
        }

        try {
            Invoke-RestMethod @Splat
        } catch {
            Write-Warning -Message "Failed to invoke the Get-MVPProfile API because $($_.Exception.Message)"
        }
    }
}
End {}
}