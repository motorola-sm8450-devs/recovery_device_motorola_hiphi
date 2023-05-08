#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2022 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#

FDEVICE="hiphi"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w \"$FDEVICE\")
	if [ -n "$chkdev" ]; then 
		FOX_BUILD_DEVICE="$FDEVICE"
	else
		chkdev=$(set | grep BASH_ARGV | grep -w \"$FDEVICE\")
		[ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
	echo "** WARNING **: Always set FOX_BUILD_DEVICE to the device codename before starting to build for any device!"
	fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	# Building
	export LC_ALL="C"
 	export ALLOW_MISSING_DEPENDENCIES=true
	export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1

	# General settings
	export FOX_VERSION=1-12
	export OF_MAINTAINER="7Soldier"
	export TARGET_DEVICE_ALT="hiphi,hiphic,hiphid,XT2201-1,XT2201-2,XT2201-3,XT2201-4,XT2201-6"
	export FOX_TARGET_DEVICES="hiphi,hiphic,hiphid,XT2201-1,XT2201-2,XT2201-3,XT2201-4,XT2201-6"
	export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
	export FOX_VANILLA_BUILD=1
	export OF_DISABLE_OTA_MENU=1
	export OF_USE_LZ4_COMPRESSION=1
	export OF_USE_GREEN_LED=0
        export OF_QUICK_BACKUP_LIST="/boot;/data;"
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export FOX_ENABLE_APP_MANAGER=1

	# Binaries
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export OF_ENABLE_LPTOOLS=1

	# Screen settings
	export OF_SCREEN_H=2400
	export OF_STATUS_H=100
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
	export OF_CLOCK_POS=1
	export OF_HIDE_NOTCH=1

	# Let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
		export | grep "FOX" >> $FOX_BUILD_LOG_FILE
		export | grep "OF_" >> $FOX_BUILD_LOG_FILE
		export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
		export | grep "TW_" >> $FOX_BUILD_LOG_FILE
	fi
fi
