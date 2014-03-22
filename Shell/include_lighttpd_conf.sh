#!/bin/bash
##############################
# 引入vHost的Lighttpd配置
##############################

#filepath=$(cd "$(dirname "$0")"; pwd);
file_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
project_path="$(dirname $(dirname "$file_path"))/project";
echo $project_path;
exit;


for dir in ${project_path}/*; do
	conf="${dir}/lighttpd.conf";
	if  [ -d "$dir" ] && [ -f "$conf" ] && [ -s "$conf" ]; then
        cat "$conf";
	fi;
done;
