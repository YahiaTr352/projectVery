listener "tcp" {
  address       = "0.0.0.0:8200"  # استمع على جميع العناوين
  tls_cert_file = "/vault/certs/vault.crt"  # المسار داخل الحاوية
  tls_key_file  = "/vault/certs/vault.key"  # المسار داخل الحاوية
}

storage "file" {
  path = "/vault/data"  # مسار لتخزين البيانات داخل الحاوية
}

ui = true  # تفعيل واجهة المستخدم
