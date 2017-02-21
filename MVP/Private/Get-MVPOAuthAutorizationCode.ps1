Function Get-MVPOAuthAutorizationCode {
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

    Function Show-MVPOAuthWindow {
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

    Show-MVPOAuthWindow -url $u1
    
    if ($AutorizationCode) {
    
        $HashTable = @{
            Uri = 'https://login.live.com/oauth20_token.srf'
            Method = 'Post'
            ContentType = 'application/x-www-form-urlencoded'
            Body = 'client_id={0}&redirect_uri={1}&client_secret={2}&code={3}&grant_type=authorization_code' -f  $ClientID,$RedirectUri,$SubscriptionKey,$AutorizationCode
        }

        try {
            #$Response = Invoke-RestMethod @HT -ErrorAction Stop
            Invoke-RestMethod @HashTable -ErrorAction Stop
            Write-Verbose -Message 'Successfully got access token'
        } catch {
            Throw $_
        }
    } else {
        Write-Warning -Message "No authorization code set"
    }
}
End {}
}
