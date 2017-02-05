
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


# https://blogs.technet.microsoft.com/heyscriptingguy/2013/07/01/use-powershell-3-0-to-get-more-out-of-windows-live/
# see also Authorization code grant flow https://msdn.microsoft.com/en-us/library/hh243647.aspx

Function Get-OAuthAutorizationCode {
[CmdletBinding()]
Param(
    [Parameter(Mandatory)]
    [String]$ClientID,

    [Parameter(Mandatory)]
    $SubscriptionKey
)
Begin {

    $scope = 'wl.emails%20wl.basic%20wl.offline_access%20wl.signin'
    $RedirectUri  = 'https://login.live.com/oauth20_desktop.srf'
    $AuthorizeUri = 'https://login.live.com/oauth20_authorize.srf'
    $u1 = '{0}?client_id={1}&redirect_uri={2}&response_type=code&scope={3}' -f $AuthorizeUri,$ClientID,$RedirectUri,$scope

    Function Show-OAuthWindow {
    [CmdletBinding()]
    Param(
        [Uri]$url
    )
    Begin {
        # from https://raw.githubusercontent.com/1RedOne/PSWordPress/master/Private/Show-oAuthWindow.ps1
    }
    Process {
        try {
            Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop
            $form = New-Object -TypeName System.Windows.Forms.Form -Property @{Width=440;Height=640}
            $web  = New-Object -TypeName System.Windows.Forms.WebBrowser -Property @{Width=420;Height=600;Url=$url}
            # define $uri in the immediate parent scope: 1
            $DocComp  = {
                $global:uri = $web.Url.AbsoluteUri
                if ($global:uri -match 'error=[^&]*|code=[^&]*') {
                    $form.Close()
                }
            }
            $web.ScriptErrorsSuppressed = $true
            $web.Add_DocumentCompleted($DocComp)
            $form.Controls.Add($web)
            $form.Add_Shown({$form.Activate()})
            $null = $form.ShowDialog()
            # set a the autorization code globally
            $global:AutorizationCode = ([regex]'^\?code=(?<code>.+)&lc=\d{1,10}$').Matches(([uri]$uri).query).Groups | Select -Last 1 -Expand value
            Write-Verbose -Message "Successfully got authorization code $($AutorizationCode)"
        } catch {
            Throw $_
        }
    }
    End {}
    }

}
Process {

    Show-OAuthWindow -url $u1
    
    if ($AutorizationCode) {
    
        $HT = @{
            Uri = 'https://login.live.com/oauth20_token.srf'
            Method = 'Post'
            ContentType = 'application/x-www-form-urlencoded'
            Body = 'client_id={0}&redirect_uri={1}&client_secret={2}&code={3}&grant_type=authorization_code' -f  $ClientID,$RedirectUri,$SubscriptionKey,$AutorizationCode
        }

        try {
            $Response = Invoke-RestMethod @HT -ErrorAction Stop

            Write-Verbose -Message 'Successfully got access token'

            Set-MVPConfiguration -PrimaryKey $SubscriptionKey -AuthorizationCode ('{0} {1}' -f $Response.token_type,$Response.access_token)

        } catch {
            Throw $_
        }
    } else {
        Write-Warning -Message "No authorization code set"
    }
}
End {}
}




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
