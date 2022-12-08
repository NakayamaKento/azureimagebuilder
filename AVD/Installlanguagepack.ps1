Install-Language ja-JP -CopyToSettings

#Get-InstalledLanguage

Set-SystemPreferredUILanguage ja-JP

#Set-WinUILanguageOverride
#ユーザーが使用する言語を日本語にします。
#Set-WinUserLanguageList -LanguageList ja-JP,en-US -Force

Set-WinHomeLocation -GeoId 0x7a

Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

Set-TimeZone -Id "Tokyo Standard Time"

#MS-IMEの入力方式を設定します。
#Set-WinLanguageBarOption -UseLegacySwitchMode -UseLegacyLanguageBar