Function Get-MVPProfileImage {
<#
    .SYNOPSIS
        Invoke the GetMVPProfileImage REST API to retrieve your MVP profile image

    .DESCRIPTION
        Gets your MVP profile image

    .EXAMPLE
        Get-MVPProfileImage

        It gets your MVP profile image.
#>
[CmdletBinding()]
Param()

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'
    } else {
        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/profile/photo'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey ;
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }

        try {
            Invoke-RestMethod @Splat
        } catch {
            Write-Warning -Message "Failed to invoke the Get-MVPProfile API because $($_.Exception.Message)"
        }
    }
}