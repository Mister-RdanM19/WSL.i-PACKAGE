# WSL Installer Package (WIP)

**WSL Installer Package (WIP)** adalah skrip otomasi berbasis Bash yang dirancang khusus untuk mempercepat proses setup lingkungan pengembangan (development) dan pengujian keamanan (pentesting) pada Windows Subsystem for Linux (WSL).
<IMG SRC="https://raw.githubusercontent.com/Mister-RdanM19/WSL.i-PACKAGE/refs/heads/main/wip.png">
## Fitur Utama

Skrip ini menyediakan menu interaktif untuk menginstal berbagai kebutuhan tool secara efisien:

* **System Maintenance**: Update repository (termasuk Kali Keyring), upgrade sistem, dan pembersihan cache RAM.
* **Development Suites**: Instalasi lengkap untuk Python (2 & 3), PHP (dengan Composer), Node.js (dengan NPM), serta Golang.
* **Version Control**: Instalasi Git disertai konfigurasi otomatis user/email.
* **Pentesting Tools**: Akses cepat untuk menginstal SQLMap, Metasploit, Nikto, Hydra, Sherlock, Wireshark, dan Burp Suite.
* **System Utilities**: Neofetch, tool kompresi/ekstraksi, serta fungsi optimasi layanan WSL.

## Persyaratan Sistem

* Sistem Operasi: WSL / WSL2 (Ubuntu/Debian/Kali Linux direkomendasikan).
* Akses: Harus dijalankan dengan hak akses Root (sudo).
* Koneksi Internet aktif.

## Cara Penggunaan

1. **Persiapan File**
   Pastikan file `wip.sh` sudah ada di direktori Anda.

2. **Berikan Izin Eksekusi**
   Buka terminal WSL dan jalankan perintah:
   ```bash
   chmod +x wip.sh
   sudo bash wip.sh
