# config.mk
#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := msmnile
TARGET_BOOTLOADER_BOARD_NAME := msmnile

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

BOARD_SECCOMP_POLICY := device/qcom/$(TARGET_BOARD_PLATFORM)/seccomp

TARGET_NO_BOOTLOADER := false
TARGET_USES_UEFI := true
TARGET_NO_KERNEL := false
BOARD_PRESIL_BUILD := true
-include $(QCPATH)/common/msmnile/BoardConfigVendor.mk

# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := false
BOARD_USES_WIPOWER := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/qcom/common

USE_OPENGL_RENDERER := true
BOARD_USE_LEGACY_UI := true

# Defines for enabling A/B builds
AB_OTA_UPDATER := true
# Full A/B partition update set
# AB_OTA_PARTITIONS := xbl rpm tz hyp pmic modem abl boot keymaster cmnlib cmnlib64 system bluetooth

# Minimum partition set for automation to test recovery generation code
# Packages generated by using just the below flag cannot be used for updating a device. You must pass
# in the full set mentioned above as part of your make commandline
AB_OTA_PARTITIONS ?= boot system
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true

#Enable compilation of oem-extensions to recovery
#These need to be explicitly 
ifneq ($(AB_OTA_UPDATER),true)
    TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_msm
endif

#Enable split vendor image
ENABLE_VENDOR_IMAGE := true
ifeq ($(ENABLE_VENDOR_IMAGE), true)
TARGET_RECOVERY_FSTAB := device/qcom/msmnile/recovery_vendor_variant.fstab
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
else
TARGET_RECOVERY_FSTAB := device/qcom/msmnile/recovery.fstab
endif
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x04000000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_DTBOIMG_PARTITION_SIZE := 0x0800000
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

BOARD_VENDOR_KERNEL_MODULES := \
    $(KERNEL_MODULES_OUT)/audio_apr.ko \
    $(KERNEL_MODULES_OUT)/audio_wglink.ko \
    $(KERNEL_MODULES_OUT)/audio_q6_pdr.ko \
    $(KERNEL_MODULES_OUT)/audio_q6_notifier.ko \
    $(KERNEL_MODULES_OUT)/audio_adsp_loader.ko \
    $(KERNEL_MODULES_OUT)/audio_q6.ko \
    $(KERNEL_MODULES_OUT)/audio_usf.ko \
    $(KERNEL_MODULES_OUT)/audio_pinctrl_wcd.ko \
    $(KERNEL_MODULES_OUT)/audio_swr.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd_core.ko \
    $(KERNEL_MODULES_OUT)/audio_swr_ctrl.ko \
    $(KERNEL_MODULES_OUT)/audio_wsa881x.ko \
    $(KERNEL_MODULES_OUT)/audio_platform.ko \
    $(KERNEL_MODULES_OUT)/audio_hdmi.ko \
    $(KERNEL_MODULES_OUT)/audio_stub.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd9xxx.ko \
    $(KERNEL_MODULES_OUT)/audio_mbhc.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd934x.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd9360.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd_spi.ko \
    $(KERNEL_MODULES_OUT)/audio_native.ko \
    $(KERNEL_MODULES_OUT)/audio_machine_msmnile.ko \
    $(KERNEL_MODULES_OUT)/wil6210.ko \
    $(KERNEL_MODULES_OUT)/msm_11ad_proxy.ko
#    $(KERNEL_MODULES_OUT)/qca_cld3_wlan.ko \
#    $(KERNEL_MODULES_OUT)/rdbg.ko

TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_QCOM_BSP := false
TARGET_USES_DRM_PP := true
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xa90000 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=a600000.dwc3

BOARD_EGL_CFG := device/qcom/$(TARGET_BOARD_PLATFORM)/egl.cfg

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
TARGET_USES_UNCOMPRESSED_KERNEL := false

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096

BOARD_USES_GENERIC_AUDIO := true
BOARD_QTI_CAMERA_32BIT_ONLY := true
TARGET_NO_RPC := true

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_INIT_VENDOR_LIB := libinit_msm

NUM_FRAMEBUFFER_SURFACE_BUFFERS := 2
TARGET_KERNEL_APPEND_DTB := true
TARGET_COMPILE_WITH_MSM_KERNEL := true

#Enable PD locater/notifier
TARGET_PD_SERVICE_ENABLED := true

#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true

# Enable dex pre-opt to speed up initial boot
ifeq ($(HOST_OS),linux)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
      ifneq ($(TARGET_BUILD_VARIANT),user)
        # Retain classes.dex in APK's for non-user builds
        DEX_PREOPT_DEFAULT := nostripping
      endif
    endif
endif

TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true
TARGET_USES_QCOM_DISPLAY_BSP := true
TARGET_USES_COLOR_METADATA := true

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

#Add non-hlos files to ota packages
ADD_RADIO_FILES := true

#Generate DTBO image
BOARD_KERNEL_SEPARATED_DTBO := true

#Disable LM
TARGET_USES_LM := false