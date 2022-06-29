##Cleanup to prepare sysprep##
<<<<<<< HEAD
#Write-Output "Start Uninstall-es.ps1"
#Get-AppxPackage -AllUsers Microsoft.LanguageExperiencePack* | Remove-AppxPackage -AllUsers
#Remove-AppxPackage -Package Microsoft.OneDriveSync_22000.8.13.0_neutral__8wekyb3d8bbwe
=======
Remove-AppxPackage -Package Microsoft.LanguageExperiencePackes-ES_22000.8.13.0_neutral__8wekyb3d8bbwe

Remove-AppxPackage -Package Microsoft.OneDriveSync_22000.8.13.0_neutral__8wekyb3d8bbwe
>>>>>>> pre-main

$LangList = Get-WinUserLanguageList
$MarkedLang = $LangList | where LanguageTag -eq "en-US"
$LangList.Remove($MarkedLang)
Set-WinUserLanguageList $LangList –Force

Write-Output "Stop Uninstall-es.ps1"