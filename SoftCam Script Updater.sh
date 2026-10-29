#!/bin/bash

# ==========================================
# Major SoftCam.Key Updater
# Developed by: John Kamel & Robin John
# ==========================================

GITHUB_URL="https://raw.githubusercontent.com/major79879/MajorKey/refs/heads/main/SoftCam.Key"
TEMP_PATH="/tmp/SoftCam.Key"
BASE_DIR="/etc/tuxbox/config"

# طباعة شعار MAJOR بـ ASCII Art
echo "====================================================================="
echo "  __  __   _      _  ____  ____  "
echo " |  \/  | / \    | |/ __ \|  _ \ "
echo " | |\/| |/ _ \_  | | |  | | |_) |"
echo " | |  | / ___ \ |_| |  | |  _ < "
echo " |_|  |_/_/   \_\___|\____/|_| \_\\"
echo "                                  "
echo "        SOFTCAM.KEY UPDATER"
echo "        Developed by: John Kamel & Robin John"
echo "====================================================================="

echo "[*] Fetching latest SoftCam.Key from GitHub..."
wget -q --no-check-certificate "$GITHUB_URL" -O "$TEMP_PATH"

if [ $? -eq 0 ] && [ -s "$TEMP_PATH" ]; then
    echo "[+] Download successful."
    echo "[*] Updating SoftCam.Key in paths under $BASE_DIR..."

    # تحديث الملف في المسار الرئيسي إذا كان المجلد موجوداً
    if [ -d "$BASE_DIR" ]; then
        cp -f "$TEMP_PATH" "$BASE_DIR/SoftCam.Key"
        chmod 644 "$BASE_DIR/SoftCam.Key"
        echo "   [✔] Updated: $BASE_DIR/SoftCam.Key"
    fi

    # البحث عن المجلدات الفرعية داخل config (مثل ncam, oscam وغيرها) ونسخ الملف إليها تلقائياً
    for SUBDIR in "$BASE_DIR"/*/; do
        if [ -d "$SUBDIR" ]; then
            cp -f "$TEMP_PATH" "${SUBDIR}SoftCam.Key"
            chmod 644 "${SUBDIR}SoftCam.Key"
            echo "   [✔] Updated: ${SUBDIR}SoftCam.Key"
        fi
    done

    # تنظيف الملف المؤقت
    rm -f "$TEMP_PATH"

    echo "---------------------------------------------------------------------"
    echo "[✔] SoftCam.Key update completed successfully!"
    echo "====================================================================="
    echo "    Enjoy watching! - By John Kamel & Robin John"
    echo "====================================================================="
else
    echo "---------------------------------------------------------------------"
    echo "[-] Error: Failed to download SoftCam.Key."
    echo "[-] Please check your internet connection or repository URL."
    echo "====================================================================="
    rm -f "$TEMP_PATH"
    exit 1
fi