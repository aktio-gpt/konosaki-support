#!/usr/bin/env bash
set -Eeuo pipefail

echo
echo "============================================================"
echo " PAUSE - refresh iOS provisioning profiles"
echo "============================================================"
echo

WORKDIR="${HOME}/pause-eas-profile-refresh"
rm -rf "${WORKDIR}"
mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

cat > package.json <<'JSON'
{
  "name": "pause-eas-profile-refresh",
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
  }
}
JSON

export EAS_NO_VCS=1

echo "1/3 必要なExpoパッケージを準備します..."
npm install --silent --no-audit --no-fund expo@~54.0.0 expo-modules-autolinking >/dev/null

echo "2/3 Expoアカウントを確認します..."
if npx --yes eas-cli@latest whoami >/dev/null 2>&1; then
  echo "✓ Expoにはログイン済みです。"
else
  npx --yes eas-cli@latest login
fi

echo
echo "3/3 Provisioning Profileを更新します。"
echo
echo "このあとEASのメニューでは次の順で進めてください:"
echo "  ・production"
echo "  ・Build Credentials"
echo "  ・All: Set up all the required credentials to build your project"
echo "  ・Appleアカウントへログイン → Yes"
echo "  ・既存Distribution Certificateを再利用 → Yes"
echo "  ・Generate a new Apple Provisioning Profile? → Yes"
echo "  ・PAUSE本体 + 3拡張すべてを更新"
echo
echo "Apple IDのパスワード・2段階認証コードはCloud Shell内だけに入力してください。"
echo

npx --yes eas-cli@latest credentials --platform ios

echo
echo "============================================================"
echo " PAUSE Provisioning Profile 更新フローが終了しました。"
echo "============================================================"
