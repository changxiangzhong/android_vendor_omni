# Additional apps
PRODUCT_PACKAGES += \
    MonthCalendarWidget \
    OmniSwitch \
    OmniJaws \
    OmniStyle \
    MatLog \
    OmniChange \
    OmniOverlayStub \
    omni-overlays \
    OpenDelta \
    ThemePicker \
    Turbo \
    SystemWebView \
    WallpaperCropper2

#PRODUCT_PACKAGES += \
    GoldfishParts \

ifneq ($(PRODUCT_EXCLUDE_EXTRA_PACKAGES),true)
PRODUCT_PACKAGES += \
    ChromeModernPublic \
    ExactCalculator \
    MusicFX \
    Phonograph
else
PRODUCT_PACKAGES += \
    OmniStoreInstaller
endif

# Additional tools
PRODUCT_PACKAGES += \
    bash \
    htop \
    vim

# Telephony extension
PRODUCT_PACKAGES += telephony-ext
PRODUCT_BOOT_JARS += telephony-ext

PRODUCT_PACKAGES += \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti_telephony_hidl_wrapper.xml \
    qti-telephony-utils \
    qti_telephony_utils.xml

# for fun
#PRODUCT_PACKAGES += \
    EggGame

$(call inherit-product-if-exists, external/google-fonts/lato/fonts.mk)
$(call inherit-product-if-exists, vendor/omni/prebuilt/fonts/fonts.mk)
