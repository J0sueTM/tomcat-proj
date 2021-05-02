#! /bin/bash
#
# file: install.sh
# author: Josué Teodoro Moreira <teodoro.josue@protonmail.ch>
# date: May 02, 2021
#
# Copyright (C) Josué Teodoro Moreira
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# Expects to be launched from the same folder where tomcat-proj was installed
cwd=$(pwd)
etc_folder=/etc/tomcat-proj

echo "Installing binary"
sudo cp ${cwd}/tomcat-proj.sh /bin/tomcat-proj
sudo chmod +x /bin/tomcat-proj

echo "Installing files"
sudo mkdir -p ${etc_folder}
sudo cp -r etc/* ${etc_folder}

echo "Done"
