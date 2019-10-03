Function Lock-MVPConsiderationAnswer {
<#
    .SYNOPSIS
        Invoke the SubmitAnswers REST API

    .DESCRIPTION
        Submits and finalizes all answers for award consideration questions

    .EXAMPLE
    Lock-MVPConsiderationAnswer

    This will submit and finalize all answers for MVP award consideration questions. No changes will be possible after execution.

    .NOTES
        https://github.com/lazywinadmin/MVP
#>
[CmdletBinding(SupportsShouldProcess = $true,
               ConfirmImpact = 'High')]
Param()
Begin {}
Process {
    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'
    } else {
        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/awardconsideration/SubmitAnswers'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
                }
            Method = 'POST'
            ErrorAction = 'Stop'
        }

        try {
            Write-Verbose -Message "About to submit and finalize all MVP award consideration questions."
            if ($PSCmdlet.ShouldProcess('Submitting and finalizing all MVP award consideration questions.')) {
                Invoke-RestMethod @Splat
            }
        } catch {
            Write-Warning -Message "Failed to invoke the SubmitAnswers API because $($_.Exception.Message)"
        }
    }
}
End {}
}