#!/bin/bash
##############################
# 引入branch的Lighttpd配置
##############################
BRANCH_DIR="/home/bae/branch";

#与报错日志记录文件的目录相关的变量
#var.rundir = "/home/bae/lighttpd"
#下面这个是用来分割日志用的
#var.cronolog_path = var.rundir + "/bin/cronolog"
#
#错误日志配置：整句话的意思是将输出流交给cronlog来做日志的分割
#server.errorlog = "|" + var.cronolog_path + " -S " + var.rundir + "/log/tinglog/error " + var.rundir + "/log/tinglog/error.%Y%m%d"
#server.errorlog = var.rundir + "/log/tinglog/error.%Y%m%d"

#关于expires的提单操作
#加上expires模块
#server.modules = (
#"mod_expire",
#)
#然后在host中加入需要expires的目录：
#$HTTP["host"] == "ting.baidu.com" {
#	expire.url = (
#		"/static/" => "access 1 years",
#		"/app/static/" => "access 1 years",
#		"/s/" => "access 1 years",
#	)
#}

#$HTTP["host"] =~ "(.*?)\.tingimg\.baidu\.com" {
#        server.document-root = "/home/bae/wwwdata/webroot"
#        server.error-handler-404 = "/index.php/404"
#		 
#		 expire.url = (
#			"/static/" => "access 1 years",
#			"/app/static/" => "access 1 years",
#			"/s/" => "access 1 years",
#		)
#}	


cat "${BRANCH_DIR}/branch.conf";

for dir in ${BRANCH_DIR}/*; do
	branch_conf="$dir/branch.conf";
	if  [ -d "$dir" ] && [ -f "$branch_conf" ]; then
		if [ -s "$branch_conf" ]; then
			cat "$branch_conf";	
		else
			base_name=$(basename "$dir");
			cat << EOF
#${base_name}
\$HTTP["host"] == "${base_name}.ting.baidu.com" {
	server.name = "${base_name}.ting.baidu.com"
	server.document-root = "$dir/webroot"
	server.error-handler-404 = "/index.php/404"
    accesslog.filename = "|" + var.cronolog_path + " " + var.rundir + "/log/tinglog/access.%Y%m%d%H"
	server.errorlog = "|" + var.cronolog_path + " -S " + var.rundir + "/log/tinglog/error " + var.rundir + "/log/tinglog/error.%Y%m%d"
    
	
	url.rewrite-once = (
		"^\/+(static|cms|common|site|player|radio|help)\/.*$" => "\$0",
		"^\/+app\/+(static|template)(\/.*)?$" => "\$0",
		"(.*)\.lrc" => "\$0",
		"(.*)\.txt" => "\$0",
		"(.*)" => "/index.php\$1"
	)

        \$HTTP["url"] =~ "^/data/" {
            \$HTTP["url"] =~ "\.(lrc|txt)$" {
                proxy-core.balancer = "static"
                proxy-core.protocol = "http"
                proxy-core.backends = ( "qukufile.qianqian.com:80" )
                proxy-core.rewrite-request = (
                    "Host" => ( ".*" => "qukufile.qianqian.com" ),
                )
                proxy-core.max-pool-size = 100
                proxy-core.debug = 0
                proxy-core.disable-time = 0
                proxy-core.connect-timeout = 5
                proxy-core.max-retry = 3
            }
        }

        \$HTTP["url"] =~ "^/index.php/su" {
            proxy-core.balancer = "static"
            proxy-core.allow-x-sendfile = "enable"
            proxy-core.max-pool-size = 256
            proxy-core.protocol = "http"
            proxy-core.backends = ( "tc-apptest-video05.tc.baidu.com:8109" )
            proxy-core.rewrite-request = (
                "Host" => ( ".*" => "tc-apptest-video05.tc.baidu.com" ),
                "_uri" => ( "^/(.*)" => "/\$1" ),
            )
        }

}
\$HTTP["host"] == "build.${base_name}.ting.baidu.com" {
	server.name = "build.${base_name}.ting.baidu.com"
	server.document-root = "$dir/webroot.build"
	server.error-handler-404 = "/index.php/404"
	url.rewrite-once = (
		"^\/+(static|cms|player|radio|help)\/.*$" => "/\$0",
		"^\/+app\/+(static)(\/.*)?$" => "\$0",
		"(.*)" => "/index.php\$1"
	)
	expire.url = (
		"/static/"=>"access 1 years",
		"/app/static/"=>"access 1 years",
	) 
}
\$HTTP["host"] == "release.${base_name}.ting.baidu.com" {
	server.name = "release.${base_name}.ting.baidu.com"
	server.document-root = "$dir/webroot.release"
	server.error-handler-404 = "/index.php/404"
	url.rewrite-once = (
		"^\/+(static|cms|player|radio|help)\/.*$" => "/\$0",
		"^\/+app\/+(static)(\/.*)?$" => "\$0",
		"(.*)" => "/index.php\$1"
	)
	expire.url = (
		"/static/"=>"access 1 years",
		"/app/static/"=>"access 1 years",
	) 
}
EOF
		fi;
	fi;
done;
