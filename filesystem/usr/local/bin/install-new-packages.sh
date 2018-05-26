#!/usr/bin/env bash

adb connect 192.168.100.151

installTerrariumTv() {
    downloadUriParts="$(curl -fsSL https://www.apkmirror.com/apk/terrarium-tv/ | pup 'h5.appRowTitle[title^="Terrarium TV"] json{}' | jq -r '.[0].title' | sed -e 's/[\. ]/-/g' | tr '[:upper:]' '[:lower:]')"
    downloadContainerUrl="https://www.apkmirror.com/apk/terrarium-tv/terrarium-tv/$downloadUriParts-release/$downloadUriParts-android-apk-download/download/"
    downloadId="$(curl -I -L "$downloadContainerUrl" 2>&1 | awk '/^Link: <\/\?p/' | sed -E -e 's/^[^=]+=([0-9]+)[^$]+$/\1/')"
    downloadUrl="https://www.apkmirror.com/wp-content/themes/APKMirror/download.php?id=$downloadId"
    curl -fsSL "$downloadUrl" -o /tmp/com.nitroxenon.terrarium.apk
    adb install /tmp/com.nitroxenon.terrarium.apk
}

installButtonMapper() {
  echo "todo ... flar2.homebutton"
}

installVlc() {
  echo "todo ... org.videolan.vlc"
}
