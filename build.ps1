#---------------------------------# 
# Header                          # 
#---------------------------------# 
Write-Output -InputObject 'Running AppVeyor build script'
Write-Output -InputObject "ModuleName    : $env:ModuleName"
Write-Output -InputObject "Build version : $env:APPVEYOR_BUILD_VERSION"
Write-Output -InputObject "Author        : $env:APPVEYOR_REPO_COMMIT_AUTHOR"
Write-Output -InputObject "Branch        : $env:APPVEYOR_REPO_BRANCH"
write-output -InputObject "Build Folder  : $env:APPVEYOR_BUILD_FOLDER"
write-output -InputObject "Project Name  : $env:APPVEYOR_PROJECT_NAME"


Get-ChildItem env:/appv*

#---------------------------------# 
# Main                            # 
#---------------------------------# 
Install-Module -Name Pester
Import-Module -Name Pester

write-output "BUILD_FOLDER: $($env:APPVEYOR_BUILD_FOLDER)"
write-output "PROJECT_NAME: $($env:APPVEYOR_PROJECT_NAME)"

$ModuleClonePath = Join-Path -Path $env:APPVEYOR_BUILD_FOLDER -ChildPath $env:APPVEYOR_PROJECT_NAME
Write-Output "MODULE CLONE PATH: $($ModuleClonePath)"

$moduleName = "$($env:APPVEYOR_PROJECT_NAME)"
Get-Module $moduleName

#Pester Tests
write-verbose "invoking pester"
$Results = Invoke-Pester -Path "$($env:APPVEYOR_BUILD_FOLDER)\Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru

#Uploading Testresults to Appveyor
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path -Path .\TestsResults.xml))

if ($Results.FailedCount -gt 0 -or $Results.PassedCount -eq 0) { 
    throw "$($Results.FailedCount) tests failed - $($Results.PassedCount) successfully passed"
}