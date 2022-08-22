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
sed -i "s/hostname='.*'/hostname='N1'/g" package/base-files/files/bin/config_generate

# 内核替换成 kernel 5.4.xxx
#sed -i 's/LINUX_KERNEL_HASH-5.4.203 = fc933f5b13066cfa54aacb5e86747a167bad1d8d23972e4a03ab5ee36c29798a/LINUX_KERNEL_HASH-5.4.210 = 940396878c2c183531669d87831eda60a86fbf4662904922c49151b50afc888e/g' ./include/kernel-5.4
#sed -i 's/LINUX_VERSION-5.4 = .203/LINUX_VERSION-5.4 = .210/g' ./include/kernel-5.4

# 设置密码为空
# sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ

git clone https://github.com/gd0772/package package/gd772
git clone https://github.com/kiddin9/luci-theme-edge.git package/luci-theme-edge
git clone https://github.com/sirpdboy/luci-theme-opentopd.git package/luci-theme-opentopd
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-argonne package/luci-theme-argonne
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
git clone https://github.com/ophub/luci-app-amlogic.git package/amlogic
wget https://raw.githubusercontent.com/0118Add/patch/main/n1.sh
bash n1.sh

#luci-app-amlogic 晶晨宝盒
sed -i "s|https.*/s9xxx-openwrt|https://github.com/0118Add/N1dabao|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|opt/kernel|https://github.com/breakings/OpenWrt/opt/kernel|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|ARMv8|s9xxx_lede|g" package/amlogic/luci-app-amlogic/root/etc/config/amlogic
