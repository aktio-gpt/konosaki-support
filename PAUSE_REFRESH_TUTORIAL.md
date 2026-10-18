# PAUSE Family Controls承認後の署名更新

AppleのFamily Controls (Distribution) 承認後は、古いProvisioning Profileを作り直す必要があります。

下のコマンド欄の **Cloud Shellへ送るボタン** を押してください。コピペは不要です。

```sh
bash pause-refresh-profiles.sh
```

その後のEASメニューは次の順です。

1. production
2. Build Credentials
3. All: Set up all the required credentials to build your project
4. Appleアカウントへログイン → Yes
5. 既存Distribution Certificateを再利用 → Yes
6. Generate a new Apple Provisioning Profile? → Yes
7. PAUSE本体 + 3拡張すべて更新

Apple IDのパスワードや2段階認証コードはCloud Shell内だけに入力してください。

完了画面をスクリーンショットしてChatGPTへ送ってください。
