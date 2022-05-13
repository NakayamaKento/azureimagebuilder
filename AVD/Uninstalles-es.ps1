##Cleanup to prepare sysprep##
Get-AppxPackage -AllUsers Microsoft.LanguageExperiencePack* | Remove-AppxPackage -AllUsers
#Remove-AppxPackage -Package Microsoft.OneDriveSync_22000.8.13.0_neutral__8wekyb3d8bbwe

$LangList = Get-WinUserLanguageList
$MarkedLang = $LangList | where LanguageTag -eq "en-US"
$LangList.Remove($MarkedLang)
Set-WinUserLanguageList $LangList –Force

Write-Output "xxxxx 14th xxxxx"