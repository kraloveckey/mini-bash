#!/usr/bin/env bash

#set -o errexit
set -o pipefail
set -o nounset

# Download functions and commands.
wgetcmd () { 
    echo -e "\nDownloading ${new} to ${output}"
    if [ -f ${output} ]; then
        rm -r ${output}
    fi
    wget -q --show-progress -c "${new}" -O "${output}" -o /dev/null
}

# Function to only get filesize.
getsize () { 
    abc=$(wget --spider ${new} 2>&1)
    y=$(echo $abc | awk -F"Length:" '{ print $2 }' | awk -F"[" '{ print $1 }')
    ss=$(ls -l -B ${output} | awk -F" " '{ print $5 }')
    sh=$(ls -lh ${output} | awk -F" " '{ print $5 }')
    printf "File: ${new} has size: $y while on disk it is ${output} - ${ss} (${sh}) \n"
}

empty () {
    echo "The file ${output} is empty. Please download it first." # This function does nothing
}

checkfile () {
    [ -s ${output} ] && getsize || empty
}

# Download functions.
clonezilla-url () {
    mirror="https://sourceforge.net/projects/clonezilla/files/latest/download"
    new="${mirror}"
    output="clonezilla-latest.iso"
    wgetcmd
    checkfile ${output}
}

comodo-rescue-url () {
    mirror="https://help.comodo.com/topic-170-1-493-5214-Downloading-Comodo-Rescue-Disk.html"
    x=$(curl -s ${mirror} | grep -m1 ".iso<" | awk -F"\"" '{ print $2 }')
    new="${x}"
    output="comodo-rescue-latest.iso"
    wgetcmd
    checkfile ${output}
}

dban-url () {
    mirror="https://sourceforge.net/projects/dban/files/latest/download"
    new="${mirror}"
    output="dban-latest.iso"
    wgetcmd
    checkfile ${output}
}

eset-sysrescue-url () {
    mirror="https://download.eset.com/com/eset/tools/recovery/rescue_cd/latest/eset_sysrescue_live.iso"
    new="${mirror}"
    output="eset-sysrescue-latest.iso"
    wgetcmd
    checkfile ${output}
}

hbcd-pe-url () {
    mirror="https://www.hirensbootcd.org/files/HBCD_PE_x64.iso"
    new="${mirror}"
    output="hbcd-pe-latest.iso"
    wgetcmd
    checkfile ${output}
}

gparted-url () {
    mirror="https://sourceforge.net/projects/gparted/files/latest/download"
    new="${mirror}"
    output="gparted-latest.iso"
    wgetcmd
    checkfile ${output}
}

grml64-url () {
    mirror="https://daily.grml.org/grml64-full_testing/latest/"
    x=$(curl -s ${mirror} | grep -m1 ".iso<" | awk -F"\"" '{ print $2 }')
    new="${mirror}${x}"
    output="grml64-full-latest.iso"
    wgetcmd
    checkfile ${output}
}

kali-url () {
    mirror="https://cdimage.kali.org/current/"
    x=$(curl -s ${mirror} | grep "live-amd64.iso" | grep -m1 amd64.iso | awk -F"\"" '{ print $4 }')
    new="${mirror}${x}"
    output="kali-linux-latest.iso"
    wgetcmd
    checkfile ${output}
}

krd-url () {
    mirror="https://rescuedisk.s.kaspersky-labs.com/updatable/2018/"
    x=$(curl -s ${mirror} | grep -m1 ".iso" | awk -F"\"" '{ print $2 }')
    new="${mirror}${x}"
    output="kaspersky-rescue-latest.iso"
    wgetcmd
    checkfile ${output}
}

parrot-security-url () {
    mirror="https://deb.parrot.sh/direct/parrot/iso/current/"
    x=$(curl -s ${mirror} | grep "security" | grep -m1 amd64.iso | awk -F"\"" '{ print $2 }')
    new="${mirror}${x}"
    output="parrot-security-latest.iso"
    wgetcmd
    checkfile ${output}
}

securityonion-url () {
    mirror="https://github.com/Security-Onion-Solutions/securityonion/blob/2.4/main/DOWNLOAD_AND_VERIFY_ISO.md?plain=1"
    x=$(curl -s ${mirror} | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | grep -m1 "https://download.securityonion.net/file/securityonion")
    new="${x}"
    output="securityonion-latest.iso"
    wgetcmd
    checkfile ${output}
}

system-rescuecd-url () {
    mirror="https://sourceforge.net/projects/systemrescuecd/files/latest/download"
    new="${mirror}"
    output="system-rescuecd-latest.iso"
    wgetcmd
    checkfile ${output}
}

ubcd-url () {
    mirror="http://mirror.koddos.net/ubcd/"
    x=$(curl -s ${mirror} | grep -m1 ".iso<" | awk -F"\"" '{ print $8 }')
    new="${mirror}${x}"
    output="ubcd-latest.iso"
    wgetcmd
    checkfile ${output}
}

ubuntu-desktop-url () {
    mirror="https://releases.ubuntu.com/22.04/"
    x=$(curl -s ${mirror} | grep -m1 desktop-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
    new="${mirror}/${x}"
    output="ubuntu-desktop-22.04.iso"
    wgetcmd
    checkfile ${output}
}

ubuntu-server-url () {
    mirror="https://releases.ubuntu.com/jammy/"
    x=$(curl -s ${mirror} | grep -m1 server-amd64.iso | awk -F\" '{ print $2 }' | awk -F\" '{ print $1 }')
    new="${mirror}/${x}"
    output="ubuntu-server-22.04.iso"
    wgetcmd
    checkfile ${output}
}

windows10-url () {
    mirror="https://massgrave.dev/windows_10_links.html"
    x=$(curl -s ${mirror} | grep -m1 "en-us_windows_10_consumer_editions" | awk -F"\"" '{ print $2 }')
    new="${x}"
    output="en-us_windows_10_consumer_editions-latest.iso"
    wgetcmd
    checkfile ${output}
}

windows11-url () {
    mirror="https://massgrave.dev/windows_11_links.html"
    x=$(curl -s ${mirror} | grep -m1 "en-us_windows_11_consumer_editions" | awk -F"\"" '{ print $2 }')
    new="${x}"
    output="en-us_windows_11_consumer_editions-latest.iso"
    wgetcmd
    checkfile ${output}
}

# Main
clonezilla-url
comodo-rescue-url
dban-url
#eset-sysrescue-url
hbcd-pe-url
gparted-url
grml64-url
kali-url
krd-url
#parrot-security-url
#securityonion-url
system-rescuecd-url
ubcd-url
ubuntu-desktop-url
ubuntu-server-url
windows10-url
windows11-url

echo -e "\nResult:"
ls -lha *.iso

exit 0