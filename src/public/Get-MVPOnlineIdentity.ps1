Function Get-MVPOnlineIdentity {
<#
    .SYNOPSIS
        Invoke the GetOnlineIdentities REST API

    .DESCRIPTION
        Gets a list of your online identities in your MVP profile

    .PARAMETER Id
        It's the id of the online identity in a int32 format

    .PARAMETER NominationsId
        It's your MVP Nomination Id in a GUID format a.k.a your OnlineIdentityId

    .EXAMPLE
        Get-MVPOnlineIdentity

        It gets the list of the online identities in your MVP profile

    .EXAMPLE
        Get-MVPOnlineIdentity -Id 55977

        It gets the online identity by its id

    .EXAMPLE
        Get-MVPOnlineIdentity -NominationsId c00b9dd2-a6a0-e411-8213-9cb654953450

        It gets the list of the online identities associated to your MVP nomination id

#>
[CmdletBinding(DefaultParameterSetName='All')]
Param(

    [parameter(ParameterSetName='ById',ValueFromPipeline,ValueFromPipelineByPropertyName)]
    [Alias('PrivateSiteId')]
    [int32]$ID,

    [parameter(ParameterSetName='ByNominationID')]
    [Alias('OnlineIdentityId')]
    [Guid]$NominationsId
)
Begin {}
Process {

    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode)) {

        Write-Warning -Message 'You need to use Set-MVPConfiguration first to set the Primary Key'

    } else {

        Set-MVPConfiguration -SubscriptionKey $MVPPrimaryKey

        $Splat = @{
            Uri = 'https://mvpapi.azure-api.net/mvp/api/onlineidentities'
            Headers = @{
                'Ocp-Apim-Subscription-Key' = $global:MVPPrimaryKey
                Authorization = $Global:MVPAuthorizationCode
            }
            ErrorAction = 'Stop'
        }


        if ($ID) {
            $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities/$($ID)"
        }
        if ($NominationID) {
            $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities/$($NominationID)"
        }

        try {
            [PSCustomObject[]](Invoke-RestMethod @Splat)
        } catch {
            Write-Warning -Message "Failed to invoke the GetOnlineIdentities API because $($_.Exception.Message)"
        }
    }
}
End {}
}