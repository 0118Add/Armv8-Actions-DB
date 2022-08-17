# 更改主机名
sed -i "s/hostname='.*'/hostname='N1'/g" package/base-files/files/bin/config_generate

# 设置密码为空
# sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ

#设置ttyd免帐号登录
sed -i 's/\/bin\/login/\/bin\/login -f root/' feeds/packages/utils/ttyd/files/ttyd.config

git clone https://github.com/gd0772/package package/gd772
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
wget https://raw.githubusercontent.com/0118Add/patch/main/n1.sh
bash n1.sh
