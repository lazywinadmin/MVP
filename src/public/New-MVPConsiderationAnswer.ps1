Function New-MVPConsiderationAnswer {
<#
    .SYNOPSIS
        Invoke the SaveAnswers REST API

    .DESCRIPTION
        Creates a new answer for an award consideration question

    .PARAMETER Answer
        Specifies the MVP's answer to the given award consideration question

    .PARAMETER AwardQuestionId
        Specifies the ID of the question being answered.

        This can be retrieved using the Get-MVPConsiderationQuestion function.

    .EXAMPLE
    $Answer = 'This is the answer to an example question.'
    New-MVPConsiderationAnswer -AwardQuestionId 'f8dd332f-d1f9-4185-b123-16ae0b0be34f' -Answer $Answer

    This will create a new answer to an MVP award consideration question using the current session opened by Set-MVPConfiguration

    .NOTES
        https://github.com/lazywinadmin/MVP
#>
[CmdletBinding(SupportsShouldProcess=$true)]
Param(
    [Parameter(Mandatory,
               ValueFromPipelineByPropertyName=$true)]
    [String]$Answer,

    [Parameter(Mandatory,
               ValueFromPipelineByPropertyName=$true)]
    [Guid]$AwardQuestionId
)
Begin {}
Process {
    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'
    } else {
        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/awardconsideration/saveanswers'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
                ContentType = 'application/json'
                }
            Method = 'POST'
            ContentType = 'application/json'
            ErrorAction = 'Stop'
        }

        $Body = @"
{
    "AwardQuestionId": "$AwardQuestionId",
    "Answer": "$Answer"
}
"@
        try {
            if ($pscmdlet.ShouldProcess($Body, "Create a new answer")){
                Write-Verbose -Message "About to create a new answer with Body $($Body)"
                Invoke-RestMethod @Splat -Body $Body
            }
        } catch {
            Write-Warning -Message "Failed to invoke the SaveAnswers API because $($_.Exception.Message)"
        }
    }
}
End {}
}