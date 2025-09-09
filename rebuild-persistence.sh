#!/bin/bash
# Script untuk bikin ulang persistence dengan inode besar di Kali Linux Live USB

PART="/dev/sdb2"   # ganti kalau persistence partisinya bukan sdb2
INODES=2000000     # jumlah inode (2 juta)

echo "=============================================="
echo "⚠️  WARNING: Semua data di $PART akan terhapus!"
echo "Tekan ENTER untuk lanjut, CTRL+C untuk batal"
echo "=============================================="
read

# 1. Unmount kalau sedang ter-mount
echo "[*] Unmounting $PART..."
sudo umount $PART 2>/dev/null

# 2. Format ulang partisi ext4 dengan inode banyak
echo "[*] Formatting $PART dengan $INODES inode..."
sudo mkfs.ext4 -L persistence -N $INODES $PART

# 3. Mount sementara
echo "[*] Mounting $PART ke /mnt..."
sudo mount $PART /mnt

# 4. Buat file persistence.conf
echo "[*] Membuat persistence.conf..."
echo "/ union" | sudo tee /mnt/persistence.conf

# 5. Unmount
echo "[*] Unmounting /mnt..."
sudo umount /mnt

echo "=============================================="
echo "✅ Persistence $PART berhasil dibuat ulang!"
echo "   Label   : persistence"
echo "   Inode   : $INODES"
echo "Sekarang reboot & pilih mode Persistence."
echo "=============================================="
