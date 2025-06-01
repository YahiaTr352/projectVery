#!/bin/bash

export VAULT_ADDR="https://projectvery.onrender.com"
export VAULT_SKIP_VERIFY=true

# افحص إذا Vault مهيّأ
if vault status | grep -q 'Initialized.*false'; then
  echo "==> Initializing Vault..."
  vault operator init -key-shares=1 -key-threshold=1 -format=json > /vault/init.json

  UNSEAL_KEY=$(jq -r '.unseal_keys_b64[0]' /vault/init.json)
  ROOT_TOKEN=$(jq -r '.root_token' /vault/init.json)

  echo "==> Unsealing Vault..."
  vault operator unseal "$UNSEAL_KEY"

  echo "==> Logging in..."
  vault login "$ROOT_TOKEN"

  # احفظهم كمتغيرات بيئية إذا بدك
  echo "export VAULT_UNSEAL_KEY=$UNSEAL_KEY" > /vault/vault.env
  echo "export VAULT_TOKEN=$ROOT_TOKEN" >> /vault/vault.env
else
  echo "==> Vault already initialized."
fi
