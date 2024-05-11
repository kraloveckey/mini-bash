#!/bin/sh

SRC="./rs-gen"
DST="/usr/local/bin/rs-gen"

if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root."
    exit
fi

if [ ! -f "$SRC" ]; then
    echo "Missing main program file ($SRC)."
    exit
fi

if [ -L "$DST" ]; then
    cat <<EOF
A symbolic link to ${SRC} already exists.
In order to proceed, please run as root the following command
    rm -f "$DST"
then relaunch this installation script.
EOF
    exit
fi

ln -s "$(realpath ${SRC})" "$DST"
if [ -L "$DST" ]; then
    cat <<EOF
Successfully installed.
Use 'rs-gen' to run the program
EOF
fi
