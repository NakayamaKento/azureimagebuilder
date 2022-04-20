##Cleanup to prepare sysprep##
#Remove-AppxPackage -Package Microsoft.LanguageExperiencePackes-ES_22000.8.13.0_neutral__8wekyb3d8bbwe

#Remove-AppxPackage -Package Microsoft.OneDriveSync_22000.8.13.0_neutral__8wekyb3d8bbwe

$LangList = Get-WinUserLanguageList
$MarkedLang = $LangList | where LanguageTag -eq "en-US"
$LangList.Remove($MarkedLang)
Set-WinUserLanguageList $LangList –Force