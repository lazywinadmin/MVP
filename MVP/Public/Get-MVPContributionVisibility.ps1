function Get-MVPContributionVisibility
{
<#
Missing one for the MVP Community
#>
[CmdletBinding()]
PARAM(
    [ValidateSet('EveryOne','Microsoft')]
    $Visibility
    )

    switch ($Visibility){
        'EveryOne' {
            $Props = @{
                Id = '299600000'
                Description = 'Everyone'
                LocalizeKey = 'PublicVisibilityText'
            }
        }
        'Microsoft' {
            $Props = @{
                Id = '100000000'
                Description = 'Microsoft'
                LocalizeKey = 'MicrosoftVisibilityText'
            }
        }
    }

    [pscustomobject]$Props
}