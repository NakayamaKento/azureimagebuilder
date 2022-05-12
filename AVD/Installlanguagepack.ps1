#Windows 11のlanguagePackを「C:\lang.iso」としてダウンロードします。
Invoke-WebRequest -Uri https://software-download.microsoft.com/download/sg/22000.1.210604-1628.co_release_amd64fre_CLIENT_LOF_PACKAGES_OEM.iso -OutFile C:\lang.iso

#「C:\lang.iso」をマウントします。
$mountResult = Mount-DiskImage C:\lang.iso -PassThru

#マウントしたISOのドライブレターを取得します。
$driveLetter = ($mountResult | Get-Volume).DriveLetter


########################################################
## Add Languages to running Windows Image for Capture##
########################################################
##Disable Language Pack Cleanup##
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\MUI\" -TaskName "LPRemove"
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\LanguageComponentsInstaller" -TaskName "Uninstallation"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Control Panel\International" /v "BlockCleanupOfUnusedPreinstalledLangPacks" /t REG_DWORD /d 1 /f

##Set Language Pack Content Stores##
$LIPContent = $driveLetter + ":\LanguagesAndOptionalFeatures\"

Write-Output $LIPContent

##Set Path of CSV File##
$CSVFile = "Windows-10-1809-FOD-to-LP-Mapping-Table.csv"
$filePath = (Get-Location).Path + "/$CSVFile"
Invoke-WebRequest -Uri https://raw.githubusercontent.com/NakayamaKento/azureimagebuilder/main/AVD/Windows-10-1809-FOD-to-LP-Mapping-Table.csv -OutFile $filePath

##Import Necesarry CSV File##
$FODList = Import-Csv -Path $filePath -Delimiter ";"


##Set Language (Target)##
$targetLanguage = "ja-jp"

$sourceLanguage = (($FODList | Where-Object {$_.'Target Lang' -eq $targetLanguage}) | Where-Object {$_.'Source Lang' -ne $targetLanguage} | Select-Object -Property 'Source Lang' -Unique).'Source Lang'
if(!($sourceLanguage)){
    $sourceLanguage = $targetLanguage
}

$langGroup = (($FODList | Where-Object {$_.'Target Lang' -eq $targetLanguage}) | Where-Object {$_.'Lang Group:' -ne ""} | Select-Object -Property 'Lang Group:' -Unique).'Lang Group:'


##List of additional features to be installed##
$additionalFODList = @(
    "$LIPContent\Microsoft-Windows-NetFx3-OnDemand-Package~31bf3856ad364e35~amd64~~.cab", 
    "$LIPContent\Microsoft-Windows-MSPaint-FoD-Package~31bf3856ad364e35~amd64~$sourceLanguage~.cab",
    "$LIPContent\Microsoft-Windows-SnippingTool-FoD-Package~31bf3856ad364e35~amd64~$sourceLanguage~.cab"
    #"$LIPContent\Microsoft-Windows-Lip-Language_x64_$sourceLanguage.cab" ##only if applicable## #Do not need for ja-jp#
)

$additionalCapabilityList = @(
 "Language.Basic~~~$sourceLanguage~0.0.1.0",
 "Language.Handwriting~~~$sourceLanguage~0.0.1.0",
 "Language.OCR~~~$sourceLanguage~0.0.1.0",
 "Language.Speech~~~$sourceLanguage~0.0.1.0",
 "Language.TextToSpeech~~~$sourceLanguage~0.0.1.0"
 )

##Install all FODs or fonts from the CSV file###
Dism /Online /Add-Package /PackagePath:$LIPContent\Microsoft-Windows-Client-Language-Pack_x64_$sourceLanguage.cab
Dism /Online /Add-Package /PackagePath:$LIPContent\Microsoft-Windows-Lip-Language-Pack_x64_$sourceLanguage.cab
foreach($capability in $additionalCapabilityList){
    Dism /Online /Add-Capability /CapabilityName:$capability /Source:$LIPContent
}


foreach($feature in $additionalFODList){
    Dism /Online /Add-Package /PackagePath:$feature
}


if($langGroup){
    Dism /Online /Add-Capability /CapabilityName:Language.Fonts.$langGroup~~~und-$langGroup~0.0.1.0 
}


##Add installed language to language list##
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("$targetlanguage")
Set-WinUserLanguageList $LanguageList -force
