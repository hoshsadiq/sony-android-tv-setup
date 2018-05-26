#!/usr/bin/env bash

adb shell settings put system remote_start On

# 0 = auto brightness agjust
# 1 = demo
# 2 = dark
# 3 = simple response
# 4 = off
adb shell settings put system LedSettings 1

adb shell settings put global bluetooth_on 0
adb shell settings put global wifi_on 0
adb shell settings put global device_name "Living Room TV"

adb shell settings put global adb_enabled 0
adb shell settings put global development_settings_enabled 0
