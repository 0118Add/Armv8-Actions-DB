#!/bin/bash
#===============================================
# Description: DIY script part 2
# File name: diy-part2.sh
# Lisence: MIT
# By: BGG
#===============================================


# 更换5.15内核
sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=5.15/g' target/linux/armvirt/Makefile

# 更改主机名
#sed -i 's/hostname='.*'/hostname='N1'/g' package/base-files/files/bin/config_generate

# 更改版本日期
sed -i 's/R22.9.1/R22.10.1/g' package/lean/default-settings/files/zzz-default-settings

# 内核替换成 kernel 5.4.xxx
#sed -i 's/LINUX_KERNEL_HASH-5.4.203 = fc933f5b13066cfa54aacb5e86747a167bad1d8d23972e4a03ab5ee36c29798a/LINUX_KERNEL_HASH-5.4.210 = 940396878c2c183531669d87831eda60a86fbf4662904922c49151b50afc888e/g' ./include/kernel-5.4
#sed -i 's/LINUX_VERSION-5.4 = .203/LINUX_VERSION-5.4 = .210/g' ./include/kernel-5.4

# autocore
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# 替换banner
wget -O ./package/base-files/files/etc/banner https://raw.githubusercontent.com/0118Add/OpenWrt-CI/main/x86/diy/x86_lede/banner

# 修改概览里时间显示为中文数字
#sed -i 's/os.date()/os.date("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/x86/index.htm

# 设置密码为空
# sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ

git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config
sed -i 's/"Argon 主题设置"/"主题设置"/g' package/luci-app-argon-config/po/zh-cn/argon-config.po
git clone https://github.com/kiddin9/luci-theme-edge.git package/luci-theme-edge
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
git clone https://github.com/ophub/luci-app-amlogic.git package/amlogic
#git clone https://github.com/sbwml/luci-app-alist.git package/alist
#sed -i 's/Alist 文件列表/文件列表/g' package/alist/luci-app-alist/po/zh-cn/alist.po
wget https://raw.githubusercontent.com/0118Add/patch/main/n1.sh
bash n1.sh

# 调整 Alist 文件列表 到 系统 菜单
#sed -i 's/NAS/d' package/alist/luci-app-alist/luasrc/controller/*.lua
#sed -i 's/nas/system/g' package/alist/luci-app-alist/luasrc/controller/*.lua
#sed -i 's/nas/system/g' package/alist/luci-app-alist/luasrc/view/alist/*.htm

# 晶晨宝盒
sed -i "s|https.*/s9xxx-openwrt|https://github.com/0118Add/N1dabao|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/breakings/OpenWrt/opt/kernel|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|s9xxx_lede|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
