#!/system/bin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/69-gapps.sh
#
. /postinstall/tmp/backuptool.functions

list_files() {
cat <<EOF
app/FaceLock/FaceLock.apk
app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleExtShared/GoogleExtShared.apk
app/GoogleTTS/GoogleTTS.apk
app/MarkupGoogle/MarkupGoogle.apk
app/SoundPickerPrebuilt/SoundPickerPrebuilt.apk
etc/default-permissions/default-permissions.xml
etc/default-permissions/opengapps-permissions.xml
etc/g.prop
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/privapp-permissions-google.xml
etc/permissions/split-permissions-google.xml
etc/preferred-apps/google.xml
etc/sysconfig/dialer_experience.xml
etc/sysconfig/google-hiddenapi-package-whitelist.xml
etc/sysconfig/google.xml
etc/sysconfig/google_build.xml
etc/sysconfig/google_exclusives_enable.xml
framework/com.google.android.dialer.support.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
lib/libfilterpack_facedetect.so
lib/libfrsdk.so
lib/libsketchology_native.so
lib64/libfacenet.so
lib64/libfilterpack_facedetect.so
lib64/libfrsdk.so
lib64/libjni_latinimegoogle.so
lib64/libsketchology_native.so
priv-app/CarrierSetup/CarrierSetup.apk
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GmsCoreSetupPrebuilt/GmsCoreSetupPrebuilt.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleExtServices/GoogleExtServices.apk
priv-app/GoogleFeedback/GoogleFeedback.apk
priv-app/GoogleOneTimeInitializer/GoogleOneTimeInitializer.apk
priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
priv-app/GoogleRestore/GoogleRestore.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Phonesky/Phonesky.apk
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/SetupWizard/SetupWizard.apk
priv-app/Turbo/Turbo.apk
priv-app/Velvet/Velvet.apk
priv-app/WellbeingPrebuilt/WellbeingPrebuilt.apk
usr/srec/en-US/APP_NAME.fst
usr/srec/en-US/APP_NAME.syms
usr/srec/en-US/CLG.prewalk.fst
usr/srec/en-US/CONTACT_NAME.fst
usr/srec/en-US/CONTACT_NAME.syms
usr/srec/en-US/SONG_NAME.fst
usr/srec/en-US/SONG_NAME.syms
usr/srec/en-US/am_phonemes.syms
usr/srec/en-US/app_bias.fst
usr/srec/en-US/c_fst
usr/srec/en-US/commands.abnf
usr/srec/en-US/compile_grammar.config
usr/srec/en-US/config.pumpkin
usr/srec/en-US/confirmation_bias.fst
usr/srec/en-US/contacts.abnf
usr/srec/en-US/contacts_bias.fst
usr/srec/en-US/contacts_disambig.fst
usr/srec/en-US/dict
usr/srec/en-US/dictation.config
usr/srec/en-US/dnn
usr/srec/en-US/embedded_class_denorm.mfar
usr/srec/en-US/embedded_normalizer.mfar
usr/srec/en-US/endpointer_dictation.config
usr/srec/en-US/endpointer_model
usr/srec/en-US/endpointer_model.mmap
usr/srec/en-US/endpointer_voicesearch.config
usr/srec/en-US/ep_portable_mean_stddev
usr/srec/en-US/ep_portable_model.uint8.mmap
usr/srec/en-US/g2p.data
usr/srec/en-US/g2p_fst
usr/srec/en-US/g2p_graphemes.syms
usr/srec/en-US/g2p_phonemes.syms
usr/srec/en-US/grammar.config
usr/srec/en-US/hmm_symbols
usr/srec/en-US/hmmlist
usr/srec/en-US/input_mean_std_dev
usr/srec/en-US/lexicon.U.fst
usr/srec/en-US/lstm_model.uint8.data
usr/srec/en-US/magic_mic.config
usr/srec/en-US/media_bias.fst
usr/srec/en-US/metadata
usr/srec/en-US/monastery_config.pumpkin
usr/srec/en-US/norm_fst
usr/srec/en-US/offensive_word_normalizer.mfar
usr/srec/en-US/offline_action_data.pb
usr/srec/en-US/phonelist
usr/srec/en-US/portable_lstm
usr/srec/en-US/portable_meanstddev
usr/srec/en-US/pumpkin.mmap
usr/srec/en-US/read_items_bias.fst
usr/srec/en-US/rescoring.fst.compact
usr/srec/en-US/semantics.pumpkin
usr/srec/en-US/skip_items_bias.fst
usr/srec/en-US/time_bias.fst
usr/srec/en-US/transform.mfar
usr/srec/en-US/voice_actions.config
usr/srec/en-US/voice_actions_compiler.config
usr/srec/en-US/word_confidence_classifier
usr/srec/en-US/wordlist.syms
EOF
}

list_google() {
cat <<EOF
app/GoogleExtShared/GoogleExtShared.apk
priv-app/GoogleExtServices/GoogleExtServices.apk
priv-app/GooglePackageInstaller/GooglePackageInstaller.apk
EOF
}
list_aosp() {
cat <<EOF
/postinstall/system/priv-app/ExtServices
/postinstall/system/app/ExtShared
/postinstall/system/priv-app/PackageInstaller
EOF
}

case "$1" in
  backup)
    if test -f priv-app/GooglePackageInstaller/GooglePackageInstaller.apk ;then
        GOOGLE=1
        list_google | while read FILE DUMMY; do
            backup_file $S/$FILE
        done
    fi
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
    if [ "$GOOGLE" -eq "1" ]; then
    list_google | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
    fi
  ;;
  pre-backup)
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    if [ "$GOOGLE" -eq "1" ]; then
        list_aosp | while read FILE DUMMY; do
        rm -rf $FILE
       done
    fi
    # Remove/postinstall Stock/AOSP apps (from GApps Installer)
    rm -rf /postinstall/system/app/Provision
    rm -rf /postinstall/system/priv-app/Provision

    # Remove/postinstall 'other' apps (per installer.data)
    rm -rf /postinstall/system/app/BookmarkProvider
    rm -rf /postinstall/system/app/BooksStub
    rm -rf /postinstall/system/app/CalendarGoogle
    rm -rf /postinstall/system/app/CloudPrint
    rm -rf /postinstall/system/app/DeskClockGoogle
    rm -rf /postinstall/system/app/EditorsDocsStub
    rm -rf /postinstall/system/app/EditorsSheetsStub
    rm -rf /postinstall/system/app/EditorsSlidesStub
    rm -rf /postinstall/system/app/Gmail
    rm -rf /postinstall/system/app/Gmail2
    rm -rf /postinstall/system/app/GoogleCalendar
    rm -rf /postinstall/system/app/GoogleCloudPrint
    rm -rf /postinstall/system/app/GoogleHangouts
    rm -rf /postinstall/system/app/GoogleKeep
    rm -rf /postinstall/system/app/GoogleLatinIme
    rm -rf /postinstall/system/app/Keep
    rm -rf /postinstall/system/app/NewsstandStub
    rm -rf /postinstall/system/app/PartnerBookmarksProvider
    rm -rf /postinstall/system/app/PrebuiltBugleStub
    rm -rf /postinstall/system/app/PrebuiltKeepStub
    rm -rf /postinstall/system/app/QuickSearchBox
    rm -rf /postinstall/system/app/Vending
    rm -rf /postinstall/system/priv-app/GmsCore
    rm -rf /postinstall/system/priv-app/GmsCore_update
    rm -rf /postinstall/system/priv-app/GoogleHangouts
    rm -rf /postinstall/system/priv-app/GoogleNow
    rm -rf /postinstall/system/priv-app/GoogleSearch
    rm -rf /postinstall/system/priv-app/OneTimeInitializer
    rm -rf /postinstall/system/priv-app/QuickSearchBox
    rm -rf /postinstall/system/priv-app/Velvet_update
    rm -rf /postinstall/system/priv-app/Vending

    # Remove/postinstall 'priv-app' apps from 'app' (per installer.data)
    rm -rf /postinstall/system/app/CanvasPackageInstaller
    rm -rf /postinstall/system/app/ConfigUpdater
    rm -rf /postinstall/system/app/GoogleBackupTransport
    rm -rf /postinstall/system/app/GoogleFeedback
    rm -rf /postinstall/system/app/GoogleLoginService
    rm -rf /postinstall/system/app/GoogleOneTimeInitializer
    rm -rf /postinstall/system/app/GooglePartnerSetup
    rm -rf /postinstall/system/app/GoogleServicesFramework
    rm -rf /postinstall/system/app/OneTimeInitializer
    rm -rf /postinstall/system/app/Phonesky
    rm -rf /postinstall/system/app/PrebuiltGmsCore
    rm -rf /postinstall/system/app/SetupWizard
    rm -rf /postinstall/system/app/Velvet

    # Remove/postinstall 'required' apps (per installer.data)
    rm -rf /postinstall/system/app/LatinIME/lib//libjni_keyboarddecoder.so
    rm -rf /postinstall/system/app/LatinIME/lib//libjni_latinimegoogle.so
    rm -rf /postinstall/system/lib/libjni_keyboarddecoder.so
    rm -rf /postinstall/system/lib/libjni_latinimegoogle.so
    rm -rf /postinstall/system/lib64/libjni_keyboarddecoder.so
    rm -rf /postinstall/system/lib64/libjni_latinimegoogle.so

    # Remove 'user requested' apps (from gapps-config)
    # Stub
  ;;
  post-restore)
    if [ -d "/postinstall" ]; then
      P="/postinstall/system"
    else
      P="/system"
    fi

    # Recreate required symlinks (from GApps Installer)
    install -d "$P/app/MarkupGoogle/lib/arm64"
    ln -sfn "$P/lib64/libsketchology_native.so" "$P/app/MarkupGoogle/lib/arm64/libsketchology_native.so"
    install -d "$P/app/FaceLock/lib/arm64"
    ln -sfn "$P/lib64/libfacenet.so" "$P/app/FaceLock/lib/arm64/libfacenet.so"
    install -d "$P/app/LatinIME/lib64/arm64"
    ln -sfn "$P/lib64/libjni_latinimegoogle.so" "$P/app/LatinIME/lib64/arm64/libjni_latinimegoogle.so"
    ln -sfn "$P/lib64/libjni_keyboarddecoder.so" "$P/app/LatinIME/lib64/arm64/libjni_keyboarddecoder.so"

    # Apply build.prop changes (from GApps Installer)
    sed -i "s/ro.error.receiver.system.apps=.*/ro.error.receiver.system.apps=com.google.android.gms/g" /system/system/build.prop

    # Re-pre-ODEX APKs (from GApps Installer)

    # Remove any empty folders we may have created during the removal process
    for i in /system/app /system/priv-app /system/usr/srec; do
      if [ -d $i ]; then
        find $i -type d -exec rmdir -p '{}' \+ 2>/dev/null;
      fi
    done;
    for i in $(list_files); do
      chown root:root "$P/$i"
      chmod 644 "$P/$i"
      chmod 755 "$(dirname "$P/$i")"
        if [ "$API" -ge "26" ]; then # Android 8.0+ uses 0600 for its permission on build.prop
          chmod 600 /system/build.prop
        fi
    done

  ;;
esac
