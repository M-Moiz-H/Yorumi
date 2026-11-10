#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
# Yorumi — Generate & encode release keystore for GitHub Secrets
# Run once locally, then paste the output into GitHub Secrets.
#
# Usage:
#   chmod +x gen_keystore.sh
#   ./gen_keystore.sh
#
# It will create yorumi-release.keystore and print the base64
# value to paste into the KEYSTORE secret.
# ─────────────────────────────────────────────────────────────

set -e

KEYSTORE="yorumi-release.keystore"
ALIAS="yorumi"
STORE_PASS="$(openssl rand -base64 18 | tr -d '=/+' | head -c 20)"
KEY_PASS="$(openssl rand -base64 18 | tr -d '=/+' | head -c 20)"

echo ""
echo "Generating Yorumi release keystore..."
echo ""

keytool -genkey -v \
  -keystore "$KEYSTORE" \
  -alias "$ALIAS" \
  -keyalg RSA \
  -keysize 4096 \
  -validity 10000 \
  -storepass "$STORE_PASS" \
  -keypass "$KEY_PASS" \
  -dname "CN=Yorumi, OU=App, O=Yorumi, L=Unknown, S=Unknown, C=US"

echo ""
echo "═══════════════════════════════════════════════════════════"
echo " COPY THESE INTO GITHUB SECRETS (Settings → Secrets → Actions)"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Secret name: KEYSTORE"
echo "Secret value (base64 of keystore file):"
base64 -w 0 "$KEYSTORE"
echo ""
echo ""
echo "Secret name: KEY_ALIAS"
echo "Secret value: $ALIAS"
echo ""
echo "Secret name: KEYSTORE_PASSWORD"
echo "Secret value: $STORE_PASS"
echo ""
echo "Secret name: KEY_PASSWORD"
echo "Secret value: $KEY_PASS"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo " Keystore file: $KEYSTORE — BACK THIS UP. If you lose it,"
echo " you cannot update the app on existing installs."
echo "═══════════════════════════════════════════════════════════"
echo ""
