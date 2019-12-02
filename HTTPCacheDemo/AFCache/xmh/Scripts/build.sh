#!/bin/sh
# Your configuration information

# 使用的工具 
# jq 安装命令brew install jq
# sed 系统自带
# xcodebuild 安装过Xcode都有。 检查是否安装过 xcode-select --help
# curl 系统自带

target_name="xmh.xcworkspace" # 有效值 ****.xcodeproj / ****.xcworkspace (cocoapods项目)
project_name="xmh" # 工程名
work_type="workspace" # 有效值 project / workspace (cocoapods项目)
api_token="xxxxxx" # fir token


sctipt_path=$(cd `dirname $0`; pwd)
echo sctipt_path=${sctipt_path}
work_path=${sctipt_path}/..
rm -rf ${work_path}/build

#cd ../
#pod install --no-repo-update
#cd ${sctipt_path}

out_sub_path=`date "+%Y-%m-%d-%H-%M-%S"`
out_base_path="../打包文件"
out_path=${work_path}/${out_base_path}/${out_sub_path}
mkdir -p ${out_path}


if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
source $HOME/.rvm/scripts/rvm
rvm use system
fi

xcodebuild -$work_type ${work_path}/$target_name -scheme $project_name -configuration Debug -sdk iphoneos clean
xcodebuild archive -$work_type ${work_path}/$target_name -scheme $project_name -configuration Debug -archivePath ${out_path}/$project_name.xcarchive

xcodebuild -exportArchive -archivePath ${out_path}/$project_name.xcarchive -exportPath ${out_path} -exportOptionsPlist ${sctipt_path}/debug_config.plist

echo ${out_path}/$project_name.ipa

if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
source ~/.rvm/scripts/rvm
rvm use default
fi

# fir p ${out_path}/$project_name.ipa -T $api_token -c 发布debug版本
# 上传到蒲公英
res=$(curl -F "file=@${out_path}/$project_name.ipa" -F "uKey=1" -F "_api_key=1" https://upload.pgyer.com/apiv1/app/upload)
# 删除返回数据的空格。否则jq 无法解析
text2=$(echo $res | sed 's/[[:space:]]//g')
# 将json格式化显示
echo ${text2} | jq .

exit 0













