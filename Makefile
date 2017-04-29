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
    Save .config into firmware as /etc/config.seed
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/config-seed/install
	$(INSTALL_DIR) $(1)/etc
	cd $(TOPDIR) && $(SCRIPT_DIR)/diffconfig.sh > $(1)/etc/config.seed && cd -
endef

$(eval $(call BuildPackage,config-seed))
