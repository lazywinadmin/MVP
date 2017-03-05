Function Get-MVPContribution {
<#
    .SYNOPSIS
        Invoke the GetContributions REST API to retrieve your contributions 

    .DESCRIPTION
        Gets yours contributions without parameter or by specifying the id of a contribution

    .PARAMETER Offset
        Page skip integer as int32

    .PARAMETER Limit
        Page take integer as int32

    .PARAMETER ID
        It's the id of a contribution

    .EXAMPLE
        Get-MVPContribution
        
        It gets your most recent contributions from range 1 to 5 

    .EXAMPLE
        Get-MVPContribution -ID 631670

        It gets your contribution id 631670

#>
[CmdletBinding(DefaultParameterSetName='All')]
Param(
    [parameter(ParameterSetName='All')]
    [int32]$Offset=1,

    [parameter(ParameterSetName='All')]
    [int32]$Limit=5,

    [parameter(ParameterSetName='ID',ValueFromPipeline,ValueFromPipelineByPropertyName)]
    [Alias('ContributionId')]
    [int32]$ID
)
Begin {}
Process {

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {

	    Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'

    } else {

        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        $Splat = @{
            Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/$($Offset)/$($Limit)"
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey ;
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }

        if ($ID) {
            $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/$($ID)"
        }
        try {
            if ($ID) {
                Invoke-RestMethod @Splat
                Write-Verbose -Message "Displaying contribution id $($ID)"
                # error 500:(Internal Server Error) when ID is not found
            } else {
                $contributions = (Invoke-RestMethod @Splat)
                $contributions.contributions
                Write-Verbose -Message "Displaying contributions range from $($Offset) to $($($Offset)+$($Limit)) of total $($contributions.TotalContributions) contributions"
            }
        } catch {
            Write-Warning -Message "Failed to invoke the Get-MVPContribution API because $($_.Exception.Message)"
        }
    }   
}
End {}
}
