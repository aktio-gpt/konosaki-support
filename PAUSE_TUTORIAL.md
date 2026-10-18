# PAUSE iOS署名セットアップ

## 1. セットアップ開始

下のコマンド欄の右側にある **Cloud Shellへ送るボタン** を押してください。
手入力・コピペは不要です。

```sh
bash pause-signing-setup.sh
```

コマンドがターミナルに入ったら、実行してください。

## 2. Apple署名の質問

Apple関連の質問が出たら、基本は次の方針です。

- Appleアカウントへログイン: Yes
- 既存のDistribution Certificateを再利用: Yes
- Provisioning Profileを生成/更新: Yes
- PAUSE本体と3つの拡張をすべて設定

Apple IDのパスワードや2段階認証コードはCloud Shell内だけに入力してください。ChatGPTには送らないでください。

## 3. 完了

最後に「PAUSE署名設定が終了しました」と表示されたら、その画面をスクリーンショットしてChatGPTへ送ってください。
