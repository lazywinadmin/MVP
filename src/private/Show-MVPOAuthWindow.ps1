Function Show-MVPOAuthWindow {
<#
.SYNOPSIS
    Function to show the Microsoft Authentication window
.NOTES
    https://github.com/lazywinadmin/MVP

    #Credit to https://raw.githubusercontent.com/1RedOne/PSWordPress/master/Private/Show-oAuthWindow.ps1
#>
    [CmdletBinding()]
    Param(
        [Uri]$url
    )
    Process {

        $Scriptname = (Get-Variable -name MyInvocation -Scope 0 -ValueOnly).MyCommand

        try {
            Write-Verbose -Message "[$ScriptName] Load assembly System.Windows.Forms"
            Add-Type -AssemblyName System.Windows.Forms -ErrorAction Stop

            Write-Verbose -Message "[$ScriptName] Create Form"
            $form = New-Object -TypeName System.Windows.Forms.Form -Property @{Width=440;Height=640}

            Write-Verbose -Message "[$ScriptName] Create Web browser"
            $web  = New-Object -TypeName System.Windows.Forms.WebBrowser -Property @{Width=420;Height=600;Url=$url}
            # define $uri in the immediate parent scope: 1
            Write-Verbose -Message "[$ScriptName] Define DocumentCompleted scriptblock"
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

            Write-Verbose -Message "[$ScriptName] Show Dialog"
            $null = $form.ShowDialog()
            # set a the autorization code globally
            $global:AutorizationCode = ([regex]'^\?code=(?<code>.+)&lc=\d{1,10}$').Matches(([uri]$uri).query).Groups |
                Select-Object -Last 1 -ExpandProperty value
            if ($global:AutorizationCode) {
                Write-Verbose -Message "[$ScriptName] Successfully got authorization code $($AutorizationCode)"
            } else {
                Write-Error -Message "[$ScriptName] Authorization code not catched"
            }
        } catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
}