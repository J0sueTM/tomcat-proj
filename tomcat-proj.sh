#! /bin/bash
#
# file: tomcat-proj.sh
# author: Josué Teodoro Moreira <teodoro.josue@protonmail.ch>
# date: May 01, 2021
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

folders=("WEB-INF" "WEB-INF/classes" "web" "src")
files=("Makefile" "WEB-INF/web.xml" "web/index.html")
default_files_folder=/etc/tomcat-proj
cwd=$(pwd)

create_project()
{
    echo ""
    echo "========== [1/5] Creating folder structure =========="
    
    folder_name=${cwd}/${1}
    mkdir -v ${folder_name}
    if ! [[ -d ${folder_name} ]]
    then
        echo "Failed creating "${1}" folder :("

        exit 1
    fi
    cd ${project_folder}
    
    for inner_folder in "${folders[@]}"
    do
        mkdir -v ${folder_name}/${inner_folder}
        if ! [[ -d ${folder_name}/${inner_folder} ]]
        then
            echo "Failed creating "${folder_name}/${inner_folder}" folder :("

            exit 1
        fi
    done

    echo ""
    echo "========== [2/5] Creating file structure ============"

    for inner_file in "${files[@]}"
    do
        touch ${folder_name}/${inner_file}
        if ! [[ -f ${folder_name}/${inner_file} ]]
        then
            echo "Failed creating "${folder_name}/${inner_folder}" file :("

            exit 1
        fi
        
        echo "touch: created file '${folder_name}/${inner_file}'"
    done

    echo ""
    echo "========== [3/5] Writing default files =========="

    if ! [[ -d ${default_files_folder} ]]
    then
        echo "Default files are missing: "${default_files_folder}
        echo "Try reinstalling tomcat-proj"

        exit 1
    fi
    cp -v ${default_files_folder}/web.xml ${folder_name}/WEB-INF/web.xml
    cp -v ${default_files_folder}/index.html ${folder_name}/web/index.html

    if [[ -x "$(command -v git)" ]]
    then
        echo ""
        echo "========== [4/5] Creating local git repository =========="

        git init ${folder_name} -b main
    fi
    
    echo ""
    echo "=======================  Done ======================="
    if [[ -x "$(command -v tree)" ]]
    then
        tree ${folder_name} -a -I '.git'
    else
        ls ${folder_name}
    fi
}

case $1 in
    "create")
        case $2 in
            "project")
                create_project $3
            ;;
            *)
                echo "Unknown command "$2

                exit 1
            ;;
        esac
    ;;
    *)
        echo "Unknown command "$1

        exit 1
    ;;
esac
