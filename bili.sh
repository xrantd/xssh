#!/usr/bin/env bash
echo -e "\n-------set up dot net env-------"

DOWNLOAD_X64=https://f.uome.cn/dotnet-sdk-6.0.201-linux-musl-x64.tar.gz
DOWNLOAD_ARM32=https://f.uome.cn/dotnet-sdk-6.0.201-linux-musl-x64.tar.gz
DOWNLOAD_ARM64=https://f.uome.cn/dotnet-sdk-6.0.201-linux-musl-x64.tar.gz

get_download_url_by_machine_architecture() {
    if command -v uname > /dev/null; then
        CPUName=$(uname -m)
        case $CPUName in
        armv*l)
            echo $DOWNLOAD_ARM32
            return 0
            ;;
        aarch64|arm64)
            echo $DOWNLOAD_ARM64
            return 0
            ;;
        esac
    fi
    # Always default to 'x64'
    echo $DOWNLOAD_X64
    return 0
}

DOWNLOAD_URL="$(get_download_url_by_machine_architecture)"
DOTNET_FILE=dotnet-sdk.tar.gz

apk add bash icu-libs krb5-libs libgcc libintl libssl1.1 libstdc++ zlib

wget -O $DOTNET_FILE $DOWNLOAD_URL
DOTNET_ROOT=/home/dotnet
mkdir -p "$DOTNET_ROOT" && tar zxf "$DOTNET_FILE" -C "$DOTNET_ROOT"

export PATH=$PATH:$DOTNET_ROOT
ln -s /home/dotnet/dotnet /usr/local/bin

dotnet --version

echo -e "\n-------set up dot net env finish-------"