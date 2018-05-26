#!/usr/bin/env bash

mkdir -p /workdir/backup-packages

# todo this needs to be an environment variable
adb connect 192.168.100.151

# todo separate this out into a separate file that can be reused
packages=(
  # Japanese Keyboard
  com.google.android.inputmethod.japanese

  # Sony recommendations row in launcher + row with list of available inputs (HDMI1, HDMI2 etc.)
  com.sony.dtv.sonyshelf

  # Sony select video
  com.sony.dtv.sonyselect

  # Netflix manager, this shows Netflix in the "Discover" menu, Netflix button on remote
  com.sony.dtv.netflixmanager

  # all kinds of recommendations
  com.sony.dtv.bravialifehack # Something todo with the recommendations row
  # com.sony.dtv.recommendationservice # main recommendation service
  # com.sony.dtv.networkrecommendation # Sony network recommendation
  # com.sony.dtv.woprecommendation
  com.sony.dtv.irbrecommendation # set-top box control setup
  com.sony.dtv.watchtvrecommendation # shows a recommendation to watch tv

  # Sony Samba
  tv.samba.ssm

  # Bluetooth Low Energy advertise service ( Maybe don't remove this)
  com.sony.dtv.bleadvertiseservice

  # Hotel crap
  com.sony.dtv.b2b.hotellanguage
  com.sony.dtv.b2b.hotelmenu
  # com.sony.dtv.b2b.hotelmode # can't remove this, breaks the settings menu

  # Sony Photo Sharing Plus
  com.sony.dtv.photosharingplus

  # Google Play Games
  com.google.android.play.games

  # Preinstalled Racing game
  com.gameloft.android.HEP.GloftANHP

  # Internet browser
  com.opera.sdk.example
  com.sony.dtv.browser.ceb
  com.sony.dtv.browser.webappruntime
  com.sony.dtv.browser.webappservice
  com.sony.dtv.browser.webappinstaller

  # Stuff for google calendar
  com.google.android.syncadapters.calendar
  com.android.providers.calendar
  # Responsible for syncing contacts calendar etc.
  com.google.android.partnersetup

  # Stuff for google contacts
  com.android.providers.contacts
  com.google.android.syncadapters.contacts

  # Playstation video
  com.sony.snei.video.hhvu

  # Sony account manager
  com.sony.snei.np.android.account

  # Sony demo mode
  com.sony.dtv.demomode

  # Sony PSV (Playstation something..)
  com.sony.dtv.tvx.search.s501.psv

  # Printer spooler from google
  com.android.printspooler

  # google movies app
  com.google.android.videos

  # Sony keyboard
  com.sony.dtv.ime.chww

  # Google Talk Back thingy (Can be enabled in settings)
  com.google.android.marvin.talkback

  # Google user dictionary
  com.android.providers.userdictionary

  # bug report and feedback services
  com.google.android.tv.bugreportsender
  com.google.android.feedback
  com.sony.dtv.customersupport

  # play music
  com.google.android.music

  # Forgot what this was, will update later
  com.sony.dtv.search.s101.tvprograms.vt

  # Stuff for satelite TV, if you use satelite tv then don't remove this
  com.sony.dtv.tvx.search.s101.tvprograms.prefsat
  com.sony.dtv.tvx.search.s101.tvprograms.gensat

  # Support for the inputs menu, etc.
  com.sony.dtv.tvx.search.s101.tvprograms.cam

  # sony media apps
  com.sony.dtv.osat.music
  com.sony.dtv.osat.video
  com.sony.dtv.osat.album

  # other/unknown
  com.sony.dtv.interactivetvutil.ppbridge
  com.sony.dtv.interactivetvutil
  com.sony.dtv.interactivetvutil.output
  com.sony.dtv.interactivetvplatform

  # Control TV with Alexa
  com.sony.dtv.smarthomesettings

  # Discover button
  com.sony.dtv.discovery
)

delPkg() {
  pkg="$1"

  pkgPath="$(adb shell pm path "$pkg" | cut -d: -f2)"
  pkgName="$(basename "$pkgPath")"

  echo "Deleting $pkg"
  set -x
  adb shell pm uninstall -k --user 0 "$pkg"
  adb uninstall "$pkg"
  set +x

  adb shell am force-stop "$pkg"
}


# adb shell cp "$pkgPath" "/sdcard/$pkg.apk"
# adb pull "/sdcard/$pkg.apk" "/workdir/backup-packages/$pkg.apk"
# adb shell rm -f "/sdcard/$pkg.apk"

for pkg in ${packages[@]}; do
  # delPkgWithBackup "$pkg"
  delPkg "$pkg"
done
