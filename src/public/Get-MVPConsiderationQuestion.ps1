Function Get-MVPConsiderationQuestion {
<#
    .SYNOPSIS
        Gets your award consideration question Questions

    .DESCRIPTION
        Invoke the GetCurrentQuestions REST API to retrieve your currently active MVP award consideration questions.

        Also returns answers if they have been registered.

    .EXAMPLE
        Get-MVPConsiderationQuestions

        This example gets your current MVP award consideration question Questions.
#>
[CmdletBinding()]
Param()

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'
    } else {
        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/awardconsideration/getcurrentquestions'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey ;
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }

        try {
            Invoke-RestMethod @Splat
        } catch {
            Write-Warning -Message "Failed to invoke the Get-MVPConsiderationQuestion API because $($_.Exception.Message)"
        }
    }
}
