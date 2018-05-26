#!/usr/bin/env bash

# additional devices can be found here if they're not already in the device.properties file below
# todo need to automatically replace the timezone to Europe/London

device_name=BRAVIA_ATV2
properties="$(curl -fsSL "https://raw.githubusercontent.com/yeriomin/play-store-api/master/src/main/resources/device-BRAVIA_ATV2.properties")"

echo "" >> /usr/lib/python3.6/site-packages/gpapi/device.properties
echo "[$device_name]" >> /usr/lib/python3.6/site-packages/gpapi/device.properties
echo "$properties" >> /usr/lib/python3.6/site-packages/gpapi/device.properties
