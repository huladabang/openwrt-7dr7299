include $(TOPDIR)/rules.mk

PKG_NAME:=openlist-quark-lite
PKG_VERSION:=4.2.6
PKG_RELEASE:=1

PKG_SOURCE:=openlist-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/OpenListTeam/OpenList/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=028694b14ba7368429774f33c1b7eb584b2bf6235fb7d72df371e528a5c6b04c
PKG_BUILD_DIR:=$(BUILD_DIR)/OpenList-$(PKG_VERSION)

PKG_LICENSE:=AGPL-3.0
PKG_LICENSE_FILE:=LICENSE
PKG_MAINTAINER:=huladabang
PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0
PKG_BUILD_FLAGS:=no-mips16

define Download/openlist-lite-frontend
  FILE:=openlist-frontend-dist-lite-v$(PKG_VERSION).tar.gz
  URL:=https://github.com/OpenListTeam/OpenList-Frontend/releases/download/v$(PKG_VERSION)/
  HASH:=26368756cdbe4de9972118d8abbb5a7e0b913bb1e5685e64a89a6f07bafccab1
endef

GO_PKG:=github.com/OpenListTeam/OpenList
GO_PKG_LDFLAGS:= \
	-X '$(GO_PKG)/v4/internal/conf.Version=v$(PKG_VERSION)-quark-lite' \
	-X '$(GO_PKG)/v4/internal/conf.WebVersion=v$(PKG_VERSION)-lite' \
	-X '$(GO_PKG)/v4/internal/conf.GitAuthor=OpenList Team and Quark Lite contributors' \
	-X '$(GO_PKG)/v4/internal/conf.GitCommit=quark-lite-r$(PKG_RELEASE)'

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/openlist-quark-lite
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=OpenList with only the Quark storage driver
  URL:=https://github.com/OpenListTeam/OpenList
  DEPENDS:=$(GO_ARCH_DEPENDS) +ca-bundle
  PROVIDES:=openlist
  CONFLICTS:=openlist
endef

define Package/openlist-quark-lite/description
  Space-saving OpenList build retaining the ordinary Quark cloud drive driver,
  the official lite web interface and WebDAV service.
endef

define Package/openlist-quark-lite/conffiles
/etc/config/quark-lite
/etc/openlist-quark-lite
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	printf '%s\n' \
		'package drivers' \
		'' \
		'import _ "github.com/OpenListTeam/OpenList/v4/drivers/quark_uc"' \
		'' \
		'func All() {}' \
		> $(PKG_BUILD_DIR)/drivers/all.go
	rm -rf $(PKG_BUILD_DIR)/public/dist
	mkdir -p $(PKG_BUILD_DIR)/public/dist
	$(TAR) -C $(PKG_BUILD_DIR)/public/dist -xzf $(DL_DIR)/openlist-frontend-dist-lite-v$(PKG_VERSION).tar.gz
endef

define Package/openlist-quark-lite/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/OpenList $(1)/usr/bin/openlist-quark-lite
	if [ -x /usr/bin/upx ]; then /usr/bin/upx --lzma --best $(1)/usr/bin/openlist-quark-lite; fi
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/init.d $(1)/etc/openlist-quark-lite
	$(INSTALL_CONF) ./files/quark-lite.config $(1)/etc/config/quark-lite
	$(INSTALL_BIN) ./files/quark-lite.init $(1)/etc/init.d/quark-lite
endef

$(eval $(call Download,openlist-lite-frontend))
$(eval $(call BuildPackage,openlist-quark-lite))
