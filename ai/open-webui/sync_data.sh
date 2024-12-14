#!/bin/bash

# 检查必要的环境变量
if [ -z "$WEBDAV_URL" ] || [ -z "$WEBDAV_USERNAME" ] || [ -z "$WEBDAV_PASSWORD" ]; then
    echo "缺少必要的环境变量 WEBDAV_URL、WEBDAV_USERNAME 或 WEBDAV_PASSWORD"
    exit 1
fi

mkdir -p ./data

# 从 WebDAV 下载webui.db文件
echo "正在从 WebDAV 下载数据库文件..."
curl -L --fail --user "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" "$WEBDAV_URL/webui.db" -o "./data/webui.db" || {
    echo "下载失败，脚本退出"
    exit 1
}
echo "下载成功"

# 定义同步函数
sync_data() {
    # 首次等待同步间隔
    SYNC_INTERVAL=${SYNC_INTERVAL:-7200}  # 默认间隔时间为 7200 秒
    echo "初始下载完成，等待 ${SYNC_INTERVAL} 秒后开始同步..."
    sleep $SYNC_INTERVAL

    while true; do
        echo "正在开始同步"
        
        # 检查数据库文件是否存在
        if [ -f "./data/webui.db" ]; then
            # 生成当前时间的文件名
            FILENAME="webui_$(date +'%m_%d_%H%M').db"
            
            echo "同步到 WebDAV..."

            # 先覆盖Webdav目录下默认的webui.db文件（方便下次拉取的时候就是最新版本）
            curl -L -T "./data/webui.db" --user "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" "$WEBDAV_URL/$FILENAME" && {
                echo "WebDAV 上传成功: $FILENAME"
                
                # 再上传以日期命名的数据库文件
                curl -L -T "./data/webui.db" --user "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" "$WEBDAV_URL/webui.db" && {
                    echo "WebDAV 更新主文件成功"
                } || {
                    echo "WebDAV 更新主文件失败"
                }
            } || {
                echo "WebDAV 上传失败，等待重试..."
                sleep 10
                curl -L -T "./data/webui.db" --user "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" "$WEBDAV_URL/$FILENAME" || {
                    echo "重试失败，放弃上传。"
                }
            }
        else
            echo "未找到 webui.db 文件，跳过同步"
        fi

        # 等待下一次同步间隔
        echo "当前时间 $(date '+%Y-%m-%d %H:%M:%S')"
        echo "等待 ${SYNC_INTERVAL} 秒后进行下一次同步..."
        sleep $SYNC_INTERVAL
    done
}

# 后台启动同步进程
sync_data &