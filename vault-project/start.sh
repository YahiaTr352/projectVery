#!/bin/bash

# إعداد المتغيرات البيئية
export VAULT_ADDR="https://127.0.0.1:8200"  # بدل 0.0.0.0 استعمل localhost
export VAULT_SKIP_VERIFY=true

# تشغيل Vault باستخدام ملف التكوين الصحيح
vault server -config=/vault/config/vault.hcl &

# الانتظار حتى يبدأ Vault
sleep 5

# إلغاء القفل باستخدام المتغير البيئي
vault operator unseal "$VAULT_UNSEAL_KEY"

# تسجيل الدخول باستخدام التوكن البيئي
vault login "$VAULT_TOKEN"
