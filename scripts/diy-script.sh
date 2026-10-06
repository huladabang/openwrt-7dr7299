#!/bin/bash
set -euo pipefail

# iStore's official feed. It is added before feeds are updated.
grep -q '^src-git istore ' feeds.conf.default || \
  echo 'src-git istore https://github.com/linkease/istore.git;main' >> feeds.conf.default

# Keep the stock LAN address used by this source tree.
sed -i 's/192\.168\.[0-9]*\.[0-9]*/192.168.6.1/g' package/base-files/files/bin/config_generate

# First boot has no preset public password. LuCI asks the owner to set one.
sed -i -E 's|^root:[^:]*:|root::|' package/base-files/files/etc/shadow
