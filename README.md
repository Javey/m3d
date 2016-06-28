# M3D开发联调平台

## 简介

一个帮助web开发者，管理开发环境（非搭建开发环境），并优化FE代码的平台

## 环境要求

1.  php >= 5.2
2.  lighttpd

建议环境

1.  svn >= 1.7
2.  pngquant
3.  uglifyjs

## 基础安装

*已下假定当前目录为用户home下*

1.  新建目录，clone m3d代码

    `mkdir m3d && cd m3d && git clone https://github.com/Javey/m3d.git core`

2.  进入m3d源码目录core，执行

    `php m3d.php install`

3.  新增一个项目（project）管理平台，如：music

    `php m3d.php add music`

4.  修改lighttpd.conf，加入

    `include_shell ~/m3d/shell/include-lighttpd-conf.sh`

5.  重启lighttpd，配置host，将music.m3d.com指向开发机ip，即可访问

## 平台配置

*   全局配置文件`conf/config.php`

1.  `RESTART` => lighttpd重启命令
2.  `SVN` => svn路径，用于checkout&commit代码
3.  `PNG8_COMPRESSOR` => FE代码，图片优化命令，如：`pngquant`
4.  `JS_COMPRESSOR` => FE代码，js压缩命令，如：`uglifyjs`

*   项目（project）配置文件`project/music(PROJECT_NAME)/conf/config.php`

1.  `host` => 当前项目域名
2.  `name` => 当前项目名称

*   webserver配置

    `project/music(PROJECT_NAME)/site/site-template`下配置当前项目的server环境

    `site-template`为模板环境，之后新建的所有环境都将以此为基准，只是改变src源码内容

    目录结构：

1.  `wwwdata.test`:测试环境目录，该目录下的代码没有经过编译
2.  `wwwdata.build`:编译环境目录，该木下的代码是经过编译处理的
3.  `src`:用于搭建当前环境的所有源码，用于wwwdata.test环境部署
4.  `build`：编译后的的源码，用于wwwdata.build环境部署
5.  `lighttpd.conf`:当前环境的lighttpd配置，该配置会被安装时加入的`include-lighttpd-conf.sh`自动读取
