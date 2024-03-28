#!/usr/bin/env bash

TCP_PORT_STATUS1=$(timeout 5 bash -c "echo > /dev/tcp/1.1.1.1/53" >/dev/null 2>&1 && echo "0" || echo "1")
TCP_PORT_STATUS2=$(timeout 5 bash -c "echo > /dev/tcp/8.8.8.8/53" >/dev/null 2>&1 && echo "0" || echo "1")

if [[ "${TCP_PORT_STATUS1}" -eq "0" && "${TCP_PORT_STATUS2}" -eq "0" ]]; then
    echo -e "\nInternet is connected. Continue executing the script...\n"
else
    echo -e "\nBite my shiny metal ass! \nYou don't have Internet connection to run the script...\nConnect the Wi-Fi or Ethernet cable!\n"
    exit 1
fi