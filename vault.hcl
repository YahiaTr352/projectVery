listener "tcp" {
  address       = "0.0.0.0:8200"  # استمع على جميع العناوين
  tls_cert_file = "/vault/certs/vault.crt"  # مسار جديد داخل بيئة السحابة
  tls_key_file  = "/vault/certs/vault.key"  # مسار جديد داخل بيئة السحابة
}

storage "file" {
  path = "/vault/data"  # مسار لتخزين البيانات داخل بيئة السحابة
}

ui = true  # تفعيل واجهة المستخدم
