# MVP
PowerShell Module to interact with the Microsoft MVP API

https://mvpapi.portal.azure-api.net/

https://aka.ms/mvp-api-video


# AUTH
 * Ocp-Apim-Subscription-Key : Subscription key which provides access to this API. Found in your Profile.
 * Authorization : OAuth 2.0 access token obtained from MSFT Live OAuth. Supported grant types: Authorization code.

# ISSUES
 * Not able to retrieve the Authentication Hash from MSFT Live OAuth using PowerShell. (for now you can retrieve your hash using the 'TRY IT' on https://mvpapi.portal.azure-api.net/

# TODO
[ ] Get-MVPContribution (All and by ID)
[ ] Get-MVPContributionArea
[ ] Get-MVPContributionType
[ ] Get-MVPOnlineIdentity (All, By ID, By NomindationID)
[ ] Get-MVPProfile (Current and by ID)
[ ] Get-MVPProfileImage
[ ] New-MVPContribution (POST)
[ ] New-MVPOnlineIdentity (POST)
[ ] Remove-MVPContribution (DELETE)
[ ] Remove-MVPOnlineIdentity (DELETE)
[ ] Set-MVPContribution (PUT) (to edit an existing one)
[ ] Set-MVPOnlineIdentity (PUT)

