<?php
/**
 * Created by JetBrains PhpStorm. M3D安装脚本
 * User: zoujiawei
 * Date: 14-3-21
 * Time: 下午9:50
 * To change this template use File | Settings | File Templates.
 */

process($argv);

function process($argv) {
    if (!isset($argv[1])) {
        displayHelp();
        exit();
    }

    switch ($argv[1]) {
        case 'install':
            install();
            break;
        case 'add':
            add($argv);
            break;
        case 'rm':
            remove($argv);
            break;
        case 'help':
        default:
            displayHelp();
            break;
    }
}

function install() {
    exec('pwd', $info);
    $curPath = $info[0];
    $parentPath = dirname($curPath);

    // 判断是否已安装
    if (!file_exists("${parentPath}/conf/config.php")) {
        shell_exec("cp -rf ${curPath}/Install/global/* ${parentPath}");
    } else {
        out('m3d已安装，重新安装请删除配置文件', 'error');
    }
}

function add($argv) {
    if (!isset($argv[2])) {
        displayHelp();
        exit();
    }
    $projectName = $argv[2];
    exec('pwd', $info);
    $curPath = $info[0];
    $curDir = basename($curPath);
    $parentPath = dirname($curPath);
    $projectPath = $parentPath.'/project/'.$projectName;
    mkdir($projectPath, 0777, true);
    shell_exec("cp -rf ${curPath}/Install/project/* ${projectPath}");

    // 修改index.php
    $indexPath = $projectPath.'/index.php';
    $contents = file_get_contents($indexPath);
    $contents = str_replace('{M3D_CORE}', $curDir, $contents);
    file_put_contents($indexPath, $contents);

    // 建立静态文件软链
    shell_exec("ln -snf ${curPath}/Ui/static ${projectPath}/static");
    shell_exec("ln -snf ${curPath}/Tool/ProLanguage/prolang.php ${projectPath}/site/site-template/wwwdata.test/webroot/prolang.php");

    // 修改lighttpd配置文件
    $lighttpdConfPath = $projectPath.'/lighttpd.conf';
    $contents = file_get_contents($lighttpdConfPath);
    $contents = str_replace(
        array('{project_name}', '{project_path}'),
        array($projectName, $projectPath),
        $contents
    );
    file_put_contents($lighttpdConfPath, $contents);

    $text = "${projectName}添加完成";
    $text .= PHP_EOL."vHost: ${projectName}.m3d.com";
    $text .= PHP_EOL."Have fun!";

    out($text, 'success');
}

function remove($argv) {
    if (!isset($argv[2])) {
        displayHelp();
        exit();
    }
    $name = $argv[2];
    exec('pwd', $info);
    $curPath = $info[0];
    $parentPath = dirname($curPath);
    $projectPath = $parentPath.'/project/'.$name;
    out("确定删除${name}项目(y/n)", 'info');
    $line = trim(fgets(STDIN));
    if ($line === 'y') {
        if (file_exists($projectPath)) {
            exec("rm -rf ${projectPath}", $info, $ret);
            if (!$ret) {
                out('删除成功', 'success');
            } else {
                out('删除失败', 'error');
            }
        } else {
            out("${name}不存在", 'error');
        }
    }
}

function displayHelp() {
    echo <<<EOF

M3D Usage
-----------------------

Options

    help             this help
    install          deploy m3d
    add name         add a project
    rm name          remove a project

EOF;
}

function out($text, $color=null, $newLine=true) {
    $styles = array(
        'success' => "\033[0;32m%s\033[0m",
        'error' => "\033[31;31m%s\033[0m",
        'info' => "\033[33;33m%s\033[0m"
    );

    $format = '%s';
    if (isset($styles[$color])) {
        $format = $styles[$color];
    }
    if ($newLine) {
        $format .= PHP_EOL;
    }

    printf($format, $text);
}
