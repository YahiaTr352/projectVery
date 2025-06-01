# استخدم صورة رسمية من Ubuntu
FROM ubuntu:22.04

# تثبيت المتطلبات الأساسية
RUN apt-get update && apt-get install -y \
  wget \
  unzip \
  curl \
  gnupg \
  vim

# تثبيت Vault من HashiCorp
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(. /etc/os-release && echo "$VERSION_CODENAME") main" | \
    tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y vault

# إنشاء المجلدات المطلوبة للتخزين والشهادات
RUN mkdir -p /vault/config /vault/certs /vault/data

# نسخ ملفات المشروع داخل الحاوية
COPY vault-project/vault.hcl /vault/config/vault.hcl
COPY vault-project/vault.crt /vault/certs/vault.crt
COPY vault-project/vault.key /vault/certs/vault.key
COPY vault-project/start.sh /vault/start.sh

# إعطاء صلاحيات تنفيذ لـ start.sh
RUN chmod +x /vault/start.sh

# تعيين مسار العمل داخل الحاوية
WORKDIR /vault

# فتح البورت 8200 المستخدم من Vault
EXPOSE 8200

# أمر بدء التشغيل
CMD ["./start.sh"]
