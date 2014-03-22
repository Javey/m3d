<?php
/**
 * Created by JetBrains PhpStorm. M3D安装脚本
 * User: zoujiawei
 * Date: 14-3-21
 * Time: 下午9:50
 * To change this template use File | Settings | File Templates.
 */

if (!isset($argv[1])) {
    exit("请传入工程名\n");
}

$projectName = $argv[1];
//$curPath = dirname(__FILE__);
exec('pwd', $info);
$curPath = $info[0];

$curDir = basename($curPath);
$parentPath = dirname($curPath);
$projectPath = $parentPath.'/project/'.$projectName;

//if (file_exists($projectPath)) {
//    exit("该工程已存在\n");
//}

// 如果是第一次安装，则需要初始化系统
if (!file_exists("${parentPath}/conf/config.php")) {
    shell_exec("cp -rf ${curPath}/Install/global/* ${parentPath}");
}

mkdir($projectPath, 0777, true);
shell_exec("cp -rf ${curPath}/Install/project/* ${projectPath}");

// 修改index.php
$indexPath = $projectPath.'/index.php';
$contents = file_get_contents($indexPath);
$contents = str_replace('{M3D_CORE}', $curDir, $contents);
file_put_contents($indexPath, $contents);

// 建立静态文件软链
shell_exec("ln -snf ${curPath}/Ui/static ${projectPath}/static");

// 修改lighttpd配置文件
$lighttpdConfPath = $projectPath.'/lighttpd.conf';
$contents = file_get_contents($lighttpdConfPath);
$contents = str_replace(
    array('{project_name}', '{project_path}'),
    array($projectName, $projectPath),
    $contents
);
file_put_contents($lighttpdConfPath, $contents);

echo "安装完成\nvHost:${projectName}.m3d.com\nHave fun！\n";
