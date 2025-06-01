#!/bin/bash

export VAULT_ADDR="https://projectvery.onrender.com"
export VAULT_SKIP_VERIFY=true

vault server -config=/vault/config/vault.hcl &
sleep 5

# شغّل سكريبت التهيئة بعد التشغيل
/vault/init.sh
