Install-Language ja-JP

#Get-InstalledLanguage

Set-SystemPreferredUILanguage ja-JP


#Set-WinUILanguageOverride

Set-WinHomeLocation -GeoId 0x7a

Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

Set-TimeZone -Id "Tokyo Standard Time"

