#!/usr/bin/env bash
set -Eeuo pipefail

echo
echo "============================================================"
echo " PAUSE - EAS iOS signing setup"
echo "============================================================"
echo

WORKDIR="${HOME}/pause-eas-signing-setup"
rm -rf "${WORKDIR}"
mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

cat > package.json <<'JSON'
{
  "name": "pause-eas-signing-setup",
  "private": true,
  "version": "0.1.0"
}
JSON

cat > app.json <<'JSON'
{
  "expo": {
    "name": "PAUSE",
    "slug": "pause",
    "owner": "aktio",
    "version": "0.1.0",
    "ios": {
      "bundleIdentifier": "com.aktio.pause",
      "supportsTablet": false,
      "entitlements": {
        "com.apple.developer.family-controls": true,
        "com.apple.security.application-groups": [
          "group.com.aktio.pause"
        ]
      }
    },
    "extra": {
      "eas": {
        "projectId": "d885ed63-8d06-4f96-91f9-c19112287836",
        "build": {
          "experimental": {
            "ios": {
              "appExtensions": [
                {
                  "targetName": "PAUSEShieldAction",
                  "bundleIdentifier": "com.aktio.pause.shieldaction",
                  "entitlements": {
                    "com.apple.developer.family-controls": true,
                    "com.apple.security.application-groups": [
                      "group.com.aktio.pause"
                    ]
                  }
                },
                {
                  "targetName": "PAUSEShieldConfiguration",
                  "bundleIdentifier": "com.aktio.pause.shieldconfiguration",
                  "entitlements": {
                    "com.apple.developer.family-controls": true,
                    "com.apple.security.application-groups": [
                      "group.com.aktio.pause"
                    ]
                  }
                },
                {
                  "targetName": "PAUSEDeviceActivityMonitor",
                  "bundleIdentifier": "com.aktio.pause.deviceactivitymonitor",
                  "entitlements": {
                    "com.apple.developer.family-controls": true,
                    "com.apple.security.application-groups": [
                      "group.com.aktio.pause"
                    ]
                  }
                }
              ]
            }
          }
        }
      }
    }
  }
}
JSON

cat > eas.json <<'JSON'
{
  "cli": {
    "version": ">= 21.0.0"
  },
  "build": {
    "production": {
      "distribution": "store",
      "credentialsSource": "remote",
      "ios": {}
    }
  },
  "submit": {
    "production": {
      "ios": {
        "ascAppId": "6823875116"
      }
    }
  }
}
JSON

export EAS_NO_VCS=1

echo "1/4 必要なExpoパッケージを準備します..."
npm install --silent --no-audit --no-fund expo@~54.0.0 expo-modules-autolinking >/dev/null

echo "2/4 Expoアカウントを確認します..."
if npx --yes eas-cli@latest whoami >/dev/null 2>&1; then
  echo "✓ Expoにはログイン済みです。"
else
  echo
  echo "Expoログインが必要です。画面の案内に従ってログインしてください。"
  echo
  npx --yes eas-cli@latest login
fi

echo
echo "3/4 PAUSEプロジェクトと4ターゲットを確認します..."
npx --yes eas-cli@latest config --platform ios --profile production --non-interactive --json >/tmp/pause-eas-config.json
echo "✓ PAUSE本体 + 3拡張の設定を読み込みました。"

echo
echo "4/4 Apple署名情報を設定します。"
echo
echo "基本方針:"
echo "  ・Appleアカウントへログイン → Yes"
echo "  ・既存のDistribution Certificateを再利用 → Yes"
echo "  ・Provisioning Profileを生成/更新 → Yes"
echo "  ・4つのターゲットすべてを設定"
echo
echo "Apple IDのパスワードや2段階認証コードは、このCloud Shellだけに入力してください。"
echo "ChatGPTには送らないでください。"
echo

npx --yes eas-cli@latest credentials:configure-build --platform ios --profile production

echo
echo "============================================================"
echo " PAUSE署名設定が終了しました。"
echo "============================================================"
echo
echo "この画面の最後をスクショしてChatGPTに送ってください。"
