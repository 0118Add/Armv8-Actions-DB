#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.10/g' package/base-files/files/bin/config_generate

#使用源码自带ShadowSocksR Plus+出国软件
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
git clone https://github.com/fw876/helloworld.git package/helloworld

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings

# 替换内核
sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/g' target/linux/armvirt/Makefile

# 修改系统文件
curl -fsSL https://raw.githubusercontent.com/0118Add/patch/main/myn1_index.htm > ./package/lean/autocore/files/arm/index.htm

# 修改autocore
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# 替换banner
wget -O ./package/base-files/files/etc/banner https://raw.githubusercontent.com/0118Add/OpenWrt-CI/main/x86/diy/x86_lede/banner

# 添加旁路由防火墙
echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user


# 添加额外软件包
#rm -rf feeds/luci/collections/luci-lib-docker
#rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/packages/lang/golang
svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang
#rm -rf feeds/luci/applications/luci-app-netdata
#rm -rf feeds/luci/applications/luci-app-aliyundrive-webdav
#rm -rf feeds/packages/multimedia/aliyundrive-webdav
#rm -rf /feeds/packages/net/samba4
#svn co https://github.com/sirpdboy/diy/trunk/samba4 feeds/packages/net/samba4
#git clone https://github.com/lisaac/luci-lib-docker.git package/luci-lib-docker
#git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
#svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netdata package/luci-app-netdata

git clone https://github.com/kiddin9/openwrt-bypass.git package/bypass
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/passwall
#git clone https://github.com/0118Add/luci-theme-neobird.git package/luci-theme-neobird
git clone https://github.com/sbwml/luci-app-alist.git package/alist
#git clone https://github.com/messense/aliyundrive-webdav.git package/aliyundrive-webdav
#git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
#git clone https://github.com/sirpdboy/luci-app-advanced.git package/luci-app-advanced
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
#svn co https://github.com/vernesong/OpenClash/branches/dev/luci-app-openclash package/luci-app-openclash
git clone https://github.com/ophub/luci-app-amlogic.git package/amlogic
#svn co https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom/trunk/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
sed -i 's/解除网易云音乐播放限制/解除网易音乐播放限制/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
#sed -i 's/Docker CE 容器/Docker 容器/g' feeds/luci/applications/luci-app-docker/po/zh-cn/docker.po
#sed -i 's/V2ray 服务器/V2ray服务/g' feeds/luci/applications/luci-app-v2ray-server/po/zh-cn/v2ray_server.po
#sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' package/aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav/po/zh-cn/aliyundrive-webdav.po
#sed -i 's/WireGuard 状态/WiGd状态/g' feeds/luci/applications/luci-app-wireguard/po/zh-cn/wireguard.po
#sed -i 's/Turbo ACC 网络加速/网络加速/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

#luci-app-amlogic 晶晨宝盒
sed -i "s|https.*/s9xxx-openwrt|https://github.com/0118Add/N1dabao|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/breakings/OpenWrt/opt/kernel|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|s9xxx_lede|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic

# TIME b "调整 Dockerman 到 服务 菜单"
#sed -i 's/"admin",/"admin","services",/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/controller/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/model/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/view/dockerman/*.htm
#sed -i 's/"admin/"admin\/services/g' package/luci-app-dockerman/applications/luci-app-dockerman/luasrc/view/dockerman/cbi/*.htm

# TIME b "调整 Zerotier 到 服务 菜单"
#sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/controller/*.lua
#sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/model/cbi/zerotier/*.lua
#sed -i 's/vpn/services/g' ./feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/*.htm

# TIME b "调整 V2ray服务 到 VPN 菜单"
#sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/model/cbi/v2ray_server/*.lua
#sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-v2ray-server/luasrc/view/v2ray_server/*.htm

# TIME b "调整 bypass 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/model/cbi/bypass/*.lua
#sed -i 's/services/vpn/g' package/bypass/luci-app-bypass/luasrc/view/bypass/*.htm

# TIME b "调整 Pass Wall 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/api/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/client/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/model/cbi/passwall/server/*.lua
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/app_update/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/global/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/haproxy/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/log/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/node_list/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/rule/*.htm
#sed -i 's/services/vpn/g' package/passwall/luci-app-passwall/luasrc/view/passwall/server/*.htm

# TIME b "调整 Hello World 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/model/cbi/vssr/*.lua
#sed -i 's/services/vpn/g' package/luci-app-vssr/luasrc/view/vssr/*.htm

# TIME b "调整 Open Clash 到 GFW 菜单"
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/controller/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/model/cbi/openclash/*.lua
#sed -i 's/services/vpn/g' package/luci-app-openclash/luasrc/view/openclash/*.htm

#赋予koolddns权限
#chmod 0755 package/luci-app-koolddns/root/etc/init.d/koolddns
#chmod 0755 package/luci-app-koolddns/root/usr/share/koolddns/aliddns

#rm -f package/kernel/mac80211/patches/brcm/999-backport-to-linux-5.18.patch

./scripts/feeds update -a
./scripts/feeds install -a
