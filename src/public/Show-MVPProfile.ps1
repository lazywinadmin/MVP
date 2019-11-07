function Show-MVPProfile {
    <#
        .SYNOPSIS
            Displays the MVP Profile for $ID

        .DESCRIPTION
            Opens the profile of the ID(s) provided, or your profile if no ID is specified, in the default browser.

        .PARAMETER ID
            It's an MVP ID

        .EXAMPLE
            Show-MVPProfile

            It shows your MVP Profile

        .EXAMPLE
            Show-MVPProfile -ID 5000475, 5000890

            It shows the profiles for Francois-Xavier Cat and Emin Atac

        .EXAMPLE
            Get-MVPProfile -ID 4025267 | Show-MVPProfile

            It shows the profile for Joel Bennett
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Alias('MvpId')]
        [ValidateNotNullOrEmpty()]
        [string[]]$ID = (Get-MVPProfile).MvpId
    )
    process {
        foreach ($MVP in $ID.Where{$_}) {
            Start-Process -FilePath "https://mvp.microsoft.com/en-us/PublicProfile/$MVP"
        }
    }
}