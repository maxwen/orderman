#!/bin/bash
set -e
adb root
sleep 3
adb wait-for-device
sleep 1
rm -rf ~/ziptempdir 2> /dev/null
mkdir -p ~/ziptempdir
unzip $1 -d ~/ziptempdir 2> /dev/null
cd ~/ziptempdir
adb shell setenforce 0
adb shell rm -rf /sdcard/tmp/ 2> /dev/null
adb shell mkdir /sdcard/tmp/
adb push payload.bin  /sdcard/tmp/
headers=`cat payload_properties.txt`
cd - 2> /dev/null
rm -rf ~/ziptempdir
if adb shell "update_engine_client --help" | grep perf_mode; then
    adb shell "update_engine_client --perf_mode"
fi
adb shell "update_engine_client --update --follow --payload='file:///sdcard/tmp/payload.bin' --headers=\"$headers\""
# usage: flashrom lineage-15.1-20180208-UNOFFICIAL-mata.zip`

