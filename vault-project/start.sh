#!/bin/bash

export VAULT_ADDR="https://127.0.0.1:8200"
export VAULT_SKIP_VERIFY=true

vault server -config=/vault/config/vault.hcl &
sleep 5

# شغّل سكريبت التهيئة بعد التشغيل
/vault/init.sh
