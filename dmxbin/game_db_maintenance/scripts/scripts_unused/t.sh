#!/bin/bash

#
# t.sh
#
# Developed by Tingkun <tingkun@playcrab.com>
# Copyright (c) 2011 Playcrab Corp.
# Licensed under terms of GNU General Public License.
# All rights reserved.
#
# Changelog:
# 2011-12-22 - created
#


SCRIPT_LIB=/home/hotel/wuxia/db_deploy/scripts/
. mcconf.sh
sl_openlog  'test' 3 0  $SCRIPT_LIB/t.sh
loginfo nothing

dump_ttserver_data 51000
