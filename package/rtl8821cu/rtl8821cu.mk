################################################################################
#
# rtl8821cu
#
################################################################################

RTL8821CU_VERSION = 0b505f382ea67bd8bdc9288ba5dbe7f4c9de33c0
RTL8821CU_SITE = $(call github,morrownr,8821cu-20210916,$(RTL8821CU_VERSION))
RTL8821CU_LICENSE = GPL-2.0
RTL8821CU_LICENSE_FILES = LICENSE

define RTL8821CU_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CFG80211)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB_SUPPORT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USB)
endef

RTL8821CU_USER_EXTRA_CFLAGS = \
	-DCONFIG_$(call qstrip,$(BR2_ENDIAN))_ENDIAN \
	-DCONFIG_IOCTL_CFG80211 \
	-DRTW_USE_CFG80211_STA_EVENT \
	-Wno-error

RTL8821CU_MODULE_MAKE_OPTS = \
	CONFIG_PLATFORM_AUTODETECT=n \
	CONFIG_RTL8821CU=m \
	KVER=$(LINUX_VERSION_PROBED) \
	USER_EXTRA_CFLAGS="$(RTL8821CU_USER_EXTRA_CFLAGS)"

define RTL8821CU_INSTALL_MODPROBE_CONF
	$(INSTALL) -m 0644 -D $(@D)/8821cu.conf \
		$(TARGET_DIR)/etc/modprobe.d/8821cu.conf
endef
RTL8821CU_POST_INSTALL_TARGET_HOOKS += RTL8821CU_INSTALL_MODPROBE_CONF

$(eval $(kernel-module))
$(eval $(generic-package))
