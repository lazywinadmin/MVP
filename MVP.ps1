
######
# Set Connection to API
######
function Set-MVPConfiguration
{
	[CmdletBinding()]
	PARAM ($PrimaryKey,$AuthorizationCode)
	Write-Verbose -Message "Set MVP Primary Key: $PrimaryKey"
	$global:MVPPrimaryKey = $PrimaryKey
    $global:MVPAuthorizationCode = $AuthorizationCode
}


Set-MVPConfiguration -PrimaryKey '<key>' -AuthorizationCode '<Auth>'







function Get-MVPProfile
{
    [CmdletBinding()]
    PARAM(
        [System.String]$ID
    )


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/profile?"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    #ProfileID
    if ($ID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/profile/$ID"
    }


    Invoke-RestMethod @Splat

    
}

# Current user
Get-MVPProfile

# Francois-Xavier Cat
Get-MVPProfile -ID 5000475

# Emin Atac
Get-MVPProfile -ID 5000890





function Get-MVPContributionArea
{
    [CmdletBinding()]
    PARAM()


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/contributionareas"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    Invoke-RestMethod @Splat


}

Get-MVPContributionArea




function Get-MVPContribution
{
    [CmdletBinding(DefaultParameterSetName='All')]
    PARAM(
        [parameter(ParameterSetName='All')]
        [int]$Offset=1,

        [parameter(ParameterSetName='All')]
        [int]$Limit=5,

        [parameter(ParameterSetName='ID')]
        [System.String]$ID
    )


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/$Offset/$Limit"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    
    if ($ID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/contributions/$ID"
    }


    Invoke-RestMethod @Splat
    
}


Get-MVPContribution

Get-MVPContribution -ContributionID 673969


function Get-MVPProfileImage
{
    [CmdletBinding()]
    PARAM(
    )


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/profile/photo"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    Invoke-RestMethod @Splat

    
}


Get-MVPProfileImage


function Get-MVPOnlineIdentity
{
    [CmdletBinding()]
    PARAM(
        [System.String]$ID,
        $NominationID
    )


    if (-not ($global:MVPPrimaryKey -and $global:MVPAuthorizationCode))
    {
	    Write-Warning -Message "You need to use Set-MVPConfiguration first to set the Primary Key"
	    break
    }


    #Splat
    $Splat = @{
        Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities"
        Headers = @{
            "Ocp-Apim-Subscription-Key" = $global:MVPPrimaryKey
            Authorization = $Global:MVPAuthorizationCode}
    }

    
    if ($ID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities/$ID"
    }
    if ($NominationID)
    {
        $Splat.Uri = "https://mvpapi.azure-api.net/mvp/api/onlineidentities/$NominationID"
    }


    Invoke-RestMethod @Splat
    
}


Get-MVPOnlineIdentity


Get-MVPOnlineIdentity -ID 106307

Get-MVPOnlineIdentity -NominationID "??"
