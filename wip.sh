#!/bin/bash

# =================================================================
# Nama Project : WSL Installer Package ( WIP ) By Mr.Rm19
# Creator      : Mr.Rm19
# Deskripsi    : All-in-One Installer untuk WSL Developer & Pentest
# =================================================================

# --- Warna ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' 

# --- Cek Root ---
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: Script ini harus dijalankan dengan sudo!${NC}"
   exit 1
fi

# --- Fungsi Utilitas ---
is_installed() {
    command -v "$1" >/dev/null 2>&1
}

check_disk() {
    local required_gb=$1
    local available_kb=$(df / | awk 'NR==2 {print $4}')
    local available_gb=$((available_kb / 1024 / 1024))
    if [ "$available_gb" -lt "$required_gb" ]; then
        echo -e "${RED}Gagal: Ruang disk tidak cukup! (Butuh ${required_gb}GB)${NC}"
        return 1
    fi
    return 0
}

# Animasi loading persentase real-time
loading_percent() {
    local prefix=$1
    for i in {0..100..10}; do
        printf "\r${YELLOW}${prefix}... [%-10s] %d%%${NC}" "$(printf '█%.0s' $(seq 1 $((i/10))))" "$i"
        sleep 0.1
    done
    echo -e " ${GREEN}Selesai!${NC}"
}

check_internet() {
    if ! ping -q -c 1 -W 1 google.com >/dev/null; then
        echo -e "${RED}Gagal: Tidak ada koneksi internet.${NC}"
        exit 1
    fi
}

show_header() {
    clear
    echo -e "${CYAN}=====================================================${NC}"
    echo -e "${RED}      WSL Installer Package ( WIP ) By Mr.Rm19       ${NC}"
    echo -e "${CYAN}=====================================================${NC}"
}

# --- Menu Utama ---
while true; do
    show_header
    echo -e "${YELLOW}1.${NC} Update & Upgrade System (Inc. Kali Keyring)"
    echo -e "${YELLOW}2.${NC} Install Python Suite (2, 3, & Venv)"
    echo -e "${YELLOW}3.${NC} Install PHP Suite & Composer"
    echo -e "${YELLOW}4.${NC} Install Node.js & NPM"
    echo -e "${YELLOW}5.${NC} Install Git & Auto-Config"
    echo -e "${YELLOW}6.${NC} System Tool (Neofetch, RAM Clean, Info)"
    echo -e "${YELLOW}7.${NC} Custom Package Installer (Install Apapun)"
    echo -e "${YELLOW}8.${NC} Compress/Extract Tool"
    echo -e "${YELLOW}9.${NC} Uninstall Package (With Confirmation)"
    echo -e "${PURPLE}--- PENTEST & DEV TOOLS ---${NC}"
    echo -e "${CYAN}11.${NC} SQLMap | ${CYAN}12.${NC} Metasploit | ${CYAN}13.${NC} Nikto"
    echo -e "${CYAN}14.${NC} Hydra  | ${CYAN}15.${NC} Sherlock   | ${CYAN}16.${NC} Golang"
    echo -e "${CYAN}17.${NC} Info Domain (Whois/Dig) | ${CYAN}18.${NC} Wireshark & Burp"
    echo -e "${YELLOW}19.${NC} Optimasi WSL (Clean & Service Stop)"
    echo -e "${YELLOW}20.${NC} About Me"
    echo -e "${RED}0.${NC} Keluar"
    echo -ne "\n${CYAN}Pilih menu: ${NC}"
    read choice

    case $choice in
        1)
            check_internet
            wget -q https://archive.kali.org/archive-keyring.gpg -O /usr/share/keyrings/kali-archive-keyring.gpg
            apt update && apt upgrade -y
            loading_percent "Updating System"
            ;;
        2)
            check_disk 1 && apt install python2 python3 python3-pip python3-venv -y
            loading_percent "Python Setup"
            ;;
        3)
            check_disk 1 && apt install php php-cli php-common unzip -y
            curl -sS https://getcomposer.org/installer | php
            mv composer.phar /usr/local/bin/composer
            loading_percent "PHP Setup"
            ;;
        4)
            apt install nodejs npm -y
            loading_percent "Node.js Setup"
            ;;
        5)
            echo -ne "Nama Git: "; read gname; echo -ne "Email Git: "; read gmail
            apt install git -y
            git config --global user.name "$gname"
            git config --global user.email "$gmail"
            echo -e "${GREEN}Git dikonfigurasi.${NC}"; sleep 1
            ;;
        6)
            is_installed neofetch || apt install neofetch -y
            neofetch
            echo -e "${YELLOW}Cleaning RAM Cache...${NC}"
            sync; echo 3 > /proc/sys/vm/drop_caches
            echo -ne "${CYAN}Enter untuk kembali...${NC}"; read
            ;;
        7)
            echo -ne "Nama paket: "; read pkg
            apt install $pkg -y
            ;;
        8)
            echo -e "1. Zip Folder\n2. Extract File"
            read -p "Pilih: " c_opt
            [[ $c_opt == "1" ]] && apt install zip -y
            ;;
        9)
            echo -ne "Paket yang dihapus: "; read unpkg
            echo -ne "Yakin hapus $unpkg? (y/n): "; read conf
            [[ $conf == [yY] ]] && apt remove --purge $unpkg -y && apt autoremove -y
            ;;
        11)
            if ! is_installed sqlmap; then
                check_disk 1 && git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap
                ln -sf /opt/sqlmap/sqlmap.py /usr/local/bin/sqlmap
            fi
            echo -e "${GREEN}SQLMap siap!${NC}"; sleep 1
            ;;
        12)
            check_disk 2 && apt install metasploit-framework -y
            ;;
        13)
            apt install nikto -y
            ;;
        14)
            apt install hydra -y
            ;;
        15)
            apt install python3-pip -y && pip3 install sherlock
            ;;
        16)
            apt install golang -y
            ;;
        17)
            apt install whois dnsutils -y
            ;;
        18)
            apt install wireshark burpsuite -y
            ;;
        19)
            echo -e "${YELLOW}Optimasi berjalan...${NC}"
            service --status-all | grep '+' | awk '{print $4}' | xargs -I{} service {} stop
            apt autoremove -y && apt clean
            echo -e "${GREEN}Lakukan 'wsl --shutdown' di CMD Windows untuk hasil maksimal.${NC}"
            sleep 2
            ;;
        20)
            echo -e "${PURPLE}--- About Me ---${NC}"
            echo -e "Creator : Mr.Rm19"
            echo -e "Email   : ramdan19id@gmail.com"
            echo -ne "${CYAN}Tekan Enter...${NC}"; read
            ;;
        0) exit 0 ;;
        *) echo -e "${RED}Pilihan salah!${NC}"; sleep 1 ;;
    esac
done