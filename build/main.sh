#!/bin/bash
function git_sparse_clone() {                                                 ## 只下载指定的目录，并移动到根目录；
branch="$1" rurl="$2" localdir="$3" && shift 3                                ## 变量：branch=分支   rurl=链接    localdir=本地根目录
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
# git clone -b 1 --depth 1 --filter=blob:none --sparse 2 3
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd ..
rm -rf $localdir
}



function git_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
# find package/ -follow -name $pkg -not -path "package/openwrt-packages/*" | xargs -rt rm -rf
    localdir=./                            # 变量= 保存的文件路径
    git clone --depth=1 --single-branch $1
    [ -d "$localdir" ] || mkdir -p "$localdir"   # 判断当前是否有 download 目录，如果不存在 则新创建 download 目录；= (-d 判断目录是否存在)  (mkdir -p 判断结果：如果目录不存在，则新创建 download 目录)
    mv $2 "$localdir"                            # 移动下载的文件 至 download 目录内；
    rm -rf $repo
}
##命令用法： git_package https://github.com/coolsnowwolf/luci luci/applications/luci-app-ddns   # git_package 加仓库链接  加仓库的文件路径



function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./                                       ## 移动分支内所有文件到 当前目录；  -n 不覆盖已存在的文件
rm -rf $1
}


git clone --depth 1 https://github.com/destan19/OpenAppFilter.git OpenAppFilter && mv -n OpenAppFilter/{luci-app-oaf,oaf,open-app-filter} ./; rm -rf OpenAppFilter   # 下载OpenAppFilter 应用访问过滤
mkdir -p OpenAppFilter && mv {luci-app-oaf,oaf,open-app-filter} OpenAppFilter   # 移动OpenAppFilter文件

git clone --depth 1 https://github.com/Hyy2001X/AutoBuild-Packages && mv -n AutoBuild-Packages/luci-app-adguardhome ./; rm -rf AutoBuild-Packages   # Adguardhome AD去广告


git clone --depth 1 https://github.com/sbwml/luci-app-alist.git luci-alist && mv -n luci-alist/*alist ./ ; rm -rf luci-alist					    # Alist阿雅网盘（注意：编译前需安装依赖：sudo apt install libfuse-dev）
mv alist luci-app-alist                                                         # 移动alist文件

git clone --depth=1 https://github.com/f8q8/luci-app-autoreboot luci-app-autoreboot     # 自动重启


git clone --depth 1 https://github.com/kiddin9/openwrt-packages && mv -n openwrt-packages/{luci-app-bypass,lua-maxminddb,lua-neturl} ./ ; rm -rf openwrt-packages     # 保留：luci-app-bypass + 插件依赖包
mv {lua-maxminddb,lua-neturl} luci-app-bypass                                    # lua-maxminddb,lua-neturl 移动依赖包

git clone --depth 1 https://github.com/gngpp/luci-app-design-config.git                                # 黑暗主题设置






git clone --depth 1 https://github.com/vernesong/OpenClash.git && mv -n OpenClash/luci-app-openclash ./; rm -rf OpenClash                       # OenClash小猫咪


git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1  # passwall1（主插件！！）
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2          # passwall2（主插件！！）
git clone --depth 1 -b main https://github.com/xiaorouji/openwrt-passwall-packages luci-app-passwall-wall                                 			    # passwall     插件依赖包

git clone --depth 1 https://github.com/fw876/helloworld luci-app-ssr-plus																		# luci-app-ssr-plus


git clone -b main https://github.com/linkease/istore luci-app-store                                                                             # luci-app-store 开源软件中心（指定下载main分支）



git clone --depth 1 -b master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git                                           # 解锁网易云音乐

git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot.git                                                                            # luci-app-pushbot       全能推送插件




git clone --depth 1 https://github.com/lisaac/luci-app-dockerman.git dockerman && mv -n dockerman/applications/* ./; rm -rf dockerman               # Docker容器管理
git clone --depth 1 https://github.com/lisaac/luci-app-diskman.git                                                                                  # Diskman 磁盘分区管理

git clone --depth 1 https://github.com/sirpdboy/luci-app-poweroffdevice.git                                                                         # 设备关机


git clone --depth=1 https://github.com/kiddin9/luci-app-wizard luci-app-wizard          # 快捷设置




# 主题源码
git clone --depth=1 https://github.com/openwrt-develop/luci-theme-atmaterial.git                       # atmaterials 主题（不推荐）

git clone --depth 1 https://github.com/gngpp/luci-theme-design.git					                   # 黑暗主题，   针对移动端优化


git clone --depth 1 https://github.com/thinktip/luci-theme-neobird.git                                 # neobird主题，针对移动端优化
git clone --depth=1 -b openwrt-18.06 https://github.com/rosywrt/luci-theme-rosy                        # rosy玫瑰红主题


rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore create_acl_for_luci.err create_acl_for_luci.ok create_acl_for_luci.warn      # 删除多余的文件，比如：.git   .gitattributes  .svn    .github   .gitignore
exit 0
