#!/bin/bash

architecture="$(uname -m)"

echo "architecture: ${architecture}"

dartSdkPath="https://storage.googleapis.com/dart-archive/channels/stable/release/2.14.3/sdk/dartsdk-linux-"	# Sdk url: https://dart.dev/tools/sdk/archive

case ${architecture} in
	( "arm" | "armv7l" )
		wget "${dartSdkPath}arm-release.zip"	# For arm 32-bit
   	;; 
   	( "arm64" | "aarch64" )
		wget "${dartSdkPath}arm64-release.zip"	# For arm 64-bit
    ;; 
    ( "x64" | "x86_64" | "amd64" )
    	wget "${dartSdkPath}x64-release.zip"	# For linux intel 64-bit
    ;;
    ( "ia32" | "x86" | "i386"  )
    	wget "${dartSdkPath}ia32-release.zip"	# For linux intel 32-bit
    ;;
esac

