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



git clone --depth 1 https://github.com/fhefh2015/Fast-GitHub.git Fast-GitHub   ## GitHub加速工具



rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore create_acl_for_luci.err create_acl_for_luci.ok create_acl_for_luci.warn      # 删除多余的文件，比如：.git   .gitattributes  .svn    .github   .gitignore
exit 0
