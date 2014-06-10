#!/bin/bash
##############################
# 引入vHost的Lighttpd配置
##############################

file_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
project_path="$(dirname "$file_path")/project";

for dir in ${project_path}/*; do
    # 每个project的lighttpd配置
	conf="${dir}/lighttpd.conf";
	if  [ -d "$dir" ] && [ -f "$conf" ] && [ -s "$conf" ]; then
        cat "$conf";
        echo -e "\n";
        for env in ${dir}/site/*; do
            # 每个project下测试环境配置
            conf="${env}/lighttpd.conf";
            if [ -d "$env" ] && [ -f "$conf" ] && [ -s "$conf" ]; then
                cat "$conf";
                echo -e "\n";
            fi
        done;
	fi;
done;
