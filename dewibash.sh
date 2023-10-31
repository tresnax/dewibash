#!/bin/bash

# Konfigurasi
SOURCE_DIR="/opt/lampp/htdoc/"      # Direktori sumber
DEST_DIR="/var/www/html/"  # Direktori tujuan

#Config Server 1
SSH_HOST="localhost"          # Alamat host/server tujuan
SSH_USER="tresnax"            # Nama pengguna SSH di server tujuan
SSH_PASS="1234567890"      # Password Server
SSH_PORT="22"              # Port SSH (biasanya 22)

#Config Server 2
SSH_HOST2="localhost"         # Alamat host/server tujuan
SSH_USER2="tresnax"           # Nama pengguna SSH di server tujuan
SSH_PASS2="1234567890"     # Password Server
SSH_PORT2="22"             # Port SSH (biasanya 22)

# Daftar file yang akan dikecualikan
EXCLUDE_FILES=("config/database.php" ".git/" )

# Membangun string opsi pengecualian
EXCLUDE_STRING=""
for file in "${EXCLUDE_FILES[@]}"; do
    EXCLUDE_STRING="$EXCLUDE_STRING --exclude='$file'"
done

echo "-------------------------------------------"
echo " Memulai Proses Deployment"
echo "-------------------------------------------"

#Deploy Server 1
sshpass -p "$SSH_PASS" rsync -azP -e "ssh -p $SSH_PORT" $EXCLUDE_STRING "$SOURCE_DIR/" "$SSH_USER@$SSH_HOST:$DEST_DIR/"
#Deploy Server 2
sshpass -p "$SSH_PASS2" rsync -azP -e "ssh -p $SSH_PORT2" $EXCLUDE_STRING "$SOURCE_DIR/" "$SSH_USER@$SSH_HOST2:$DEST_DIR/"

# Menampilkan pesan jika proses selesai
echo "-------------------------------------------"
echo " Proses Deployment Selesai"
echo "-------------------------------------------"
