[CmdletBinding()]
PARAM($modulePath,$moduleName,$srcPath)
begin{
    # Find the Manifest file
    $ManifestFile = "$modulePath\$ModuleName.psd1"

    # Unload any module with same name
    Get-Module -Name $ModuleName -All | Remove-Module -Force -ErrorAction Ignore

    # Import Module
    $ModuleInformation = Import-Module -Name $ManifestFile -Force -ErrorAction Stop -PassThru

    # Get the functions present in the Manifest
    $ExportedFunctions = $ModuleInformation.ExportedFunctions.Values.name

    # Public functions
    $publicFiles = @(Get-ChildItem -Path $srcPath\public\*.ps1 -ErrorAction SilentlyContinue)
}
end{
    $ModuleInformation | Remove-Module -ErrorAction SilentlyContinue
}
process{
    Describe "$ModuleName Module - Testing Manifest File (.psd1)" -Tag 'build' {
        Context "Manifest"{
            It "Should contains RootModule"{
                $ModuleInformation.RootModule | Should not BeNullOrEmpty
            }
            It "Should contains Author"{
                $ModuleInformation.Author | Should not BeNullOrEmpty
            }
            It "Should contains Company Name"{
                $ModuleInformation.CompanyName | Should not BeNullOrEmpty
            }
            It "Should contains Description"{
                $ModuleInformation.Description | Should not BeNullOrEmpty
            }
            It "Should contains Copyright"{
                $ModuleInformation.Copyright | Should not BeNullOrEmpty
            }
            It "Should contains License"{
                $ModuleInformation.LicenseURI | Should not BeNullOrEmpty
            }
            It "Should contains a Project Link"{
                $ModuleInformation.ProjectURI | Should not BeNullOrEmpty
            }
            It "Should contains a Tags (For the PSGallery)"{
                $ModuleInformation.Tags.count | Should not BeNullOrEmpty
            }

            It "Should have equal number of Function Exported and the Public PS1 files found ($($ExportedFunctions.count) and $($publicFiles.count))"{
                $ExportedFunctions.count -eq $publicFiles.count |Should -Be $true}
            It "Compare the missing function"{
                if (-not($ExportedFunctions.count -eq $publicFiles.count)){
                    $Compare = Compare-Object -ReferenceObject $ExportedFunctions -DifferenceObject $publicFiles.basename
                    $Compare.inputobject -join ',' |
                    Should BeNullOrEmpty
                }
            }
        }
    }
    <#
        Generic tests
    #>
    Describe "$ModuleName Module - Functions Comment based help" -Tag 'build' {
        foreach  ($function in $ExportedFunctions) {
            # Retrieve the Help of the function
            $Help = Get-Help -Name $Function -Full

            # Parse the function using AST
            $AST = [System.Management.Automation.Language.Parser]::ParseInput((Get-Content function:$Function), [ref]$null, [ref]$null)

            Context "$Function - Help"{

                It "Synopsis"{ $help.Synopsis | Should not BeNullOrEmpty }
                It "Description"{ $help.Description | Should not BeNullOrEmpty }

                # Get the parameters declared in the Comment Based Help
                $RiskMitigationParameters = 'Whatif', 'Confirm'
                $HelpParameters = $help.parameters.parameter | Where-Object name -NotIn $RiskMitigationParameters

                # Get the parameters declared in the AST PARAM() Block
                $ASTParameters = $ast.ParamBlock.Parameters.Name.variablepath.userpath

                It "Parameter - Compare Count Help/AST" {
                    $HelpParameters.name.count -eq $ASTParameters.count | Should Be $true
                }

                # Parameter Description
                If (-not [String]::IsNullOrEmpty($ASTParameters)) # IF ASTParameters are found
                {
                    $HelpParameters | ForEach-Object {
                        It "Parameter $($_.Name) - Should contains description"{
                            $_.description | Should not BeNullOrEmpty
                        }
                    }
                }

                # Examples
                it "Example - Count should be greater than 0"{
                    $Help.examples.example.code.count | Should BeGreaterthan 0
                }

                # Examples - Remarks (small description that comes with the example)
                foreach ($Example in $Help.examples.example)
                {
                    it "Example - Remarks on $($Example.Title)"{
                        $Example.remarks | Should not BeNullOrEmpty
                    }
                }
            }
        }
    }


    <#
        Test individual functions
    #>

    <#Set-MVPConfiguration -SubscriptionKey $env:mvpapikey

    Describe 'Get-MVPProfile' {
        Context 'no parameters' {
            $returnedData = Get-MVPProfile

            It 'gets result' {
                $returnedData|Should not BeNullOrEmpty
            }
            It 'gets a single object' {
                $returnedData.getType().fullname | Should Be 'System.Management.Automation.PSCustomObject'
            }
        }
    }
    #>
}#process