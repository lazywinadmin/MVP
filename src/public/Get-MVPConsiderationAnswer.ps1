Function Get-MVPConsiderationAnswer {
<#
    .SYNOPSIS
        Gets your award consideration question answers

    .DESCRIPTION
        Invoke the GetAnswers REST API to retrieve your currently active MVP award consideration question answers

    .EXAMPLE
        Get-MVPConsiderationAnswers

        This example gets your current MVP award consideration question answers.
#>
[CmdletBinding()]
Param()

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'
    } else {
        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/awardconsideration/GetAnswers'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey ;
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }

        try {
            Invoke-RestMethod @Splat
        } catch {
            if ($_.ErrorDetails.Message -like '*active and pending*') {
                Write-Warning -Message ($_.ErrorDetails.Message | ConvertFrom-Json).Message
            } else {
                Write-Warning -Message "Failed to invoke the Get-MVPConsiderationAnswer API because $($_.Exception.Message)"
            }
        }
    }
}
