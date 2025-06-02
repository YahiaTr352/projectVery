#!/bin/bash

# تحديد عنوان Vault الخارجي (مهم يطابق api_addr بالـ vault.hcl)
export VAULT_ADDR="https://projectvery.onrender.com"
export VAULT_SKIP_VERIFY=true

# شغّل سيرفر Vault بالخلفية
vault server -config=/vault/config/vault.hcl &

# انتظر حتى يصير السيرفر جاهز
sleep 5

# كرر التحقق حتى يصير السيرفر فعلاً شغّال
RETRIES=10
until vault status > /dev/null 2>&1 || [ $RETRIES -eq 0 ]; do
  echo "🔄 في انتظار Vault ليشتغل..."
  sleep 2
  ((RETRIES--))
done

# شغّل init فقط إذا كان السيرفر جاهز
if vault status > /dev/null 2>&1; then
  echo "✅ Vault جاهز، تشغيل init.sh..."
  /vault/init.sh
else
  echo "❌ فشل تشغيل Vault. init.sh لن يُنفّذ."
  exit 1
fi
