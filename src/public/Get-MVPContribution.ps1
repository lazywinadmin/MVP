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

.NOTES
    https://github.com/lazywinadmin/MVP
#>
[CmdletBinding(DefaultParameterSetName='All')]
Param(
    [parameter(ParameterSetName='All')]
    [int32]$Offset=0,

    [parameter(ParameterSetName='All')]
    [int32]$Limit=5,

    [parameter(ParameterSetName='ID',ValueFromPipeline,ValueFromPipelineByPropertyName)]
    [Alias('ContributionId')]
    [int32]$ID
)
Process {

    $Scriptname = (Get-Variable -name MyInvocation -Scope 0 -ValueOnly).MyCommand

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {
        Write-Warning -Message "[$Scriptname] You need to use Set-MVPConfiguration first to set the Primary Key"
        break
    }

    Try {
        Write-Verbose -message "[$Scriptname] Set Configuration"
        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        Write-Verbose -message "[$Scriptname] Build Splatting"
        $Splat = @{
            Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/$($Offset)/$($Limit)"
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey ;
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }

        if ($PSBoundParameters['ID']) {
            Write-Verbose -message "[$Scriptname] ID Specified"
            $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/$($ID)"
            Write-Verbose -message "[$Scriptname] URI = $($Splat.Uri)"
        Write-Verbose -message "[$Scriptname] Querying Rest api..."
            Invoke-RestMethod @Splat
        }
        else{
            Write-Verbose -Message "[$Scriptname] Displaying contributions range from $($Offset) to $($($Offset)+$($Limit))"
            Write-Verbose -message "[$Scriptname] URI = $($Splat.Uri)"
            Write-Verbose -message "[$Scriptname] Querying Rest api..."
            (Invoke-RestMethod @Splat).Contributions
        }
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}
}
