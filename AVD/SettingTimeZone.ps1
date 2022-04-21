Write-Output "xxxxx 10th xxxxx"

#UIの言語を日本語で上書きします。
Set-WinUILanguageOverride -Language ja-JP

#時刻/日付の形式をWindowsの言語と同じにします。
Set-WinCultureFromLanguageListOptOut -OptOut $False

#ロケーションを日本にします。
Set-WinHomeLocation -GeoId 0x7A

#システムロケールを日本にします。
Set-WinSystemLocale -SystemLocale ja-JP

#タイムゾーンを東京にします。
Set-TimeZone -Id "Tokyo Standard Time"

#サーバーを再起動します。
#Restart-Computer

Write-Output "xxxxx 11th xxxxx"

Invoke-WebRequest -Uri https://raw.githubusercontent.com/sny0421/windows-server-2019-japanese/master/registry/ja-JP-welcome.reg -OutFile C:\\ja-JP-welcome.reg


Invoke-WebRequest -Uri https://raw.githubusercontent.com/sny0421/windows-server-2019-japanese/master/registry/ja-JP-default.reg -OutFile C:\\ja-JP-default.reg


Write-Output "xxxxx 12th xxxxx"


$DefaultHKEY = "HKU\DEFAULT_USER"
$DefaultRegPath = "C:\Users\Default\NTUSER.DAT"
reg load $DefaultHKEY $DefaultRegPath
reg import "C:\ja-JP-default.reg"
reg unload $DefaultHKEY
reg import "C:\ja-JP-welcome.reg"

Write-Output "xxxxx 13th xxxxx"