#!/bin/bash

# إعداد المتغيرات البيئية
export VAULT_ADDR="https://0.0.0.0:8200"  # عنوان Vault الجديد بدل localhost
export VAULT_SKIP_VERIFY=true  # إذا كنت مش معتمد على شهادات موثوقة

# تشغيل Vault باستخدام ملف التكوين
vault server -config=/vault-project/vault.hcl &  # تأكد من مسار الملف صحيح في بيئة السحابة

# الانتظار حتى يبدأ Vault
sleep 5  # خلي Vault يشتغل شوي قبل ما تواصل

# إلغاء القفل باستخدام المتغير البيئي
vault operator unseal $VAULT_UNSEAL_KEY  # خلي المفتاح بيئي عشان ما تفضح التوكن

# تسجيل الدخول باستخدام التوكن البيئي
vault login $VAULT_TOKEN  # خلي التوكن بيئي عشان تحفظ الأمان
