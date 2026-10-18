# PAUSE Family Controls承認後の署名更新

古いProvisioning ProfileはEAS側から削除済みです。Apple Developer側のProfileやDistribution Certificateは削除していません。

下のコマンド欄の **Cloud Shellへ送るボタン** を押してください。コピペは不要です。

```sh
bash pause-refresh-profiles.sh
```

今回はEASのCredentialsメニューには入りません。直接、PAUSE本体＋3拡張の署名再構成を実行します。

途中は基本:
- Appleアカウントへログイン → Yes
- 既存Distribution Certificateを再利用 → Yes
- 新しいProvisioning Profileを作成 → Yes

Apple IDのパスワードや2段階認証コードはCloud Shell内だけに入力してください。

最後に4ターゲットすべてが ready to build になった画面をスクリーンショットしてChatGPTへ送ってください。
