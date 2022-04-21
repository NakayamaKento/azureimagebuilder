#ユーザーが使用する言語を日本語にします。
Set-WinUserLanguageList -LanguageList ja-JP,en-US -Force

#入力する言語を日本語で上書きします。
Set-WinDefaultInputMethodOverride -InputTip "0411:00000411"

#MS-IMEの入力方式を設定します。
Set-WinLanguageBarOption -UseLegacySwitchMode -UseLegacyLanguageBar

#サーバーを再起動します。
#Restart-Computer

