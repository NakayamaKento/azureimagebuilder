# Azure Vitual Desktop の日本語化イメージを作成します

作成後のイメージの細かい検証まで実施していないため、カスタムする内容の参考程度とお考え下さい

ファイルの説明
-
- AIBscript.ps1
    - Image Builder テンプレートを事項するためのすべてのリソースをデプロイします
- Installlanguagepack.ps1
    - 日本語化するための PowerShell スクリプトです。Image Builder が参照します
- Uninstalles-es.ps1
    - 英語の言語パックをアンインストールするスクリプトです。現時点では Image Builder が参照していないです
- aibRoleImageCreation.json
    - image builder を実行するためのカスタムロールです。AIBscript.ps1 で参照します
- localize.json
    - image builder の本体です。ここに記載のある内容に沿って、イメージの作成が行われます


AIBscript.ps1 の実行内容
-
- 必要なリソースプロバイダー、PowerShell モジュールの確認
- リソースグループの作成
- マネージド ID の作成
- カスタムロールの作成 (作成完了後、利用できるまで時間がかかるため待機時間を設けています)
- マネージド ID にカスタムロールを割り当て
- Azure Compute Gallery の作成
- image builder テンプレートの作成
