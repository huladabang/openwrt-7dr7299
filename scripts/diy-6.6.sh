#!/bin/bash
set -euo pipefail

# OpenClash LuCI package.
rm -rf package/luci-app-openclash
git clone --depth=1 https://github.com/vernesong/OpenClash.git /tmp/OpenClash
cp -a /tmp/OpenClash/luci-app-openclash package/luci-app-openclash

# Embed the arm64 Mihomo/Meta core, so OpenClash works immediately after flashing.
mkdir -p package/luci-app-openclash/root/etc/openclash/core
curl --fail --location --retry 3 \
  https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz \
  -o /tmp/openclash-core.tar.gz
tar -xzf /tmp/openclash-core.tar.gz -C /tmp
install -m 0755 /tmp/clash package/luci-app-openclash/root/etc/openclash/core/clash_meta

# LuCI's current lightweight file manager. Copy only this application.
rm -rf package/luci-app-filemanager /tmp/luci-upstream
git clone --depth=1 https://github.com/openwrt/luci.git /tmp/luci-upstream
cp -a /tmp/luci-upstream/applications/luci-app-filemanager package/luci-app-filemanager

# Device-specific UI polish used by known-good TL-7DR7299 builds.
sed -i '/"mediatek"\/\*|"mvebu"\/\*)/i "mediatek/filogic_a73")\n\tcpu_freq="1.8GHz" ;;' \
  package/emortal/autocore/files/generic/cpuinfo
