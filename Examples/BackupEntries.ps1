# Backup Contribution
Get-MVPContribution -Verbose -all | ConvertTo-Json |
Out-File -FilePath BackupMVP_$(Get-Date -format 'yyyyMMdd_HHmmss').txt

# Retrieve the type of contribution
Get-MVPContributionType

# Retrieve the ContributionTechnology
(Get-MVPContributionArea).contributionarea.name
# simple backup
Get-MVPContribution -limit 1000 |
ConvertTo-Json |
Out-File -FilePath BackupMVP_$(Get-Date -format 'yyyyMMdd_HHmmss').json

# per year
Get-MVPContribution -limit 1000 |
select-object -Property *,@{L='Year';E={$_.startdate.substring(0,4)}} |
Group-Object -Property year |
Foreach-object -Process {
    # Grab the current year
    $Year = $_.name

    # Get the contribution of the current year
    $ContributionsOfYear = $_.Group

    # Save to file
    $ContributionsOfYear |
    ConvertTo-Json |
    Out-File -FilePath BackupMVP_Year$Year-$(Get-Date -format 'yyyyMMdd_HHmmss').json
}