# TP-Link TL-7DR7299 v1 自用精简固件

基于 `padavanonly/immortalwrt-mt798x-6.6` 的
`mt798x-mt799x-6.6-mtwifi` 分支，通过 GitHub Actions 编译。

## 固件信息

- 设备：TP-Link TL-7DR7299 v1
- SoC：MediaTek MT7988A（Cortex-A73）
- Wi-Fi：MediaTek MT7992 闭源 `mtwifi` 驱动
- 默认管理地址：`192.168.6.1`
- 默认用户：`root`
- 初始密码：空；首次登录后请立即设置密码

## 内置功能

- iStore 软件商店
- OpenClash（内置 arm64 Mihomo/Meta 核心）
- MediaTek TurboACC/HNAT/WED 网络加速
- 网页终端 ttyd
- USB 存储、Samba4 文件共享（ext4/exFAT/NTFS3）
- nlbwmon 带宽统计
- UPnP/NAT-PMP
- LuCI 文件管理器
- Tailscale 与同一内核编译的 `kmod-tun`
- SFTP、htop、jq 等维护工具

未加入 PassWall、Docker、EasyTier、OpenList、磁盘管理等非必要组件。

## 编译

进入仓库的 **Actions** 页面，选择
**Build TL-7DR7299 closed-source Wi-Fi firmware**，点击 **Run workflow**。
编译成功后，固件同时出现在该次任务的 Artifacts 和 Releases 中。

## 刷写提示

正常升级只使用文件名包含
`tplink_tl-7dr7299-v1-squashfs-sysupgrade.itb` 的系统固件。
不要把 `preloader.bin`、`bl31-uboot.fip` 或其他机型文件当成系统固件上传。

刷写第三方固件存在变砖风险。升级前请备份配置与关键分区，并确保设备已有可用的
TL-7DR7299 第三方 U-Boot/恢复方式。
