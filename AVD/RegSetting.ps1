Write-Output "Start RegSetting.ps1"

Invoke-WebRequest -Uri https://raw.githubusercontent.com/NakayamaKento/azureimagebuilder/main/AVD/ja-jp-welcome.reg -OutFile C:\\ja-JP-welcome.reg

Invoke-WebRequest -Uri https://raw.githubusercontent.com/NakayamaKento/azureimagebuilder/main/AVD/ja-jp-default.reg -OutFile C:\\ja-JP-default.reg


$DefaultHKEY = "HKU\DEFAULT_USER"
$DefaultRegPath = "C:\Users\Default\NTUSER.DAT"
reg load $DefaultHKEY $DefaultRegPath
reg import "C:\ja-JP-default.reg"
reg unload $DefaultHKEY
reg import "C:\ja-JP-welcome.reg"

Write-Output "Finish RegSetting.ps1"