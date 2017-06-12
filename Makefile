include $(TOPDIR)/rules.mk

PKG_NAME:=config-seed
PKG_RELEASE:=1
PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/config-seed
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=config-seed -- Save .config into firmware
endef

define Package/config-seed/description
    Save lede .config into firmware as /etc/lede-config, linux kernel config as /etc/linux-config.xz.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/config-seed/install
	rm -f $(PKG_BUILD_DIR)/.built*
	$(INSTALL_DIR) $(1)/etc
	cd $(TOPDIR) && $(SCRIPT_DIR)/diffconfig.sh > $(1)/etc/lede-config && cd -
	cd $(BUILD_DIR)/linux-*/linux-4.*/ && tar -Jcf $(1)/etc/linux-config.xz .config && cd -
endef

$(eval $(call BuildPackage,config-seed))
