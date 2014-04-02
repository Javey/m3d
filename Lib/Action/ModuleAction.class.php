<?php
/**
 * Created by JetBrains PhpStorm. 模块操作接口
 * User: zoujiawei
 * Date: 13-12-18
 * Time: 下午3:08
 * To change this template use File | Settings | File Templates.
 */

class ModuleAction extends Action {
    public function index() {
        switch ($this->method) {
            case 'get':
                $this->getAllModules();
                break;
            case 'put':
                $this->addModule();
                break;
            case 'delete':
                $this->deleteModule();
                break;
        }
    }

    public function branches() {
        switch ($this->method) {
            case 'get':
                $this->getAllBranches();
                break;
            case 'post':
                $this->updateBranch();
                break;
        }
    }

    /**
     * 提测
     */
    public function test() {
        $mailTo = $_POST['to'];
        $subject = '【M3D提测通知】 '.$_POST['subject'];
        $subject = "=?UTF-8?B?".base64_encode($subject)."?=";
        $mailFrom = $_POST['from'];
        $description = str_replace("\n", '<br />',$_POST['description']);
        $modules = '<ul style="font-weight: normal;">';
        foreach ($_POST['modules'] as $module) {
            $modules .= '<li><h4>' . $module['title'] . ' - <i>' . $module['description'] . '</i></h4>';
            $modules .= '<p><span>模块:</span>' . $module['storename']. '</p><p><span>分支:</span>' . $module['branch'] . '</p></li>';
        }
        $modules .= '</ul>';
        $message = "
            <html>
            <body style='font-family: 'Microsoft YaHei';'>
                <ul>
                    <li>
                        <h3>描述</h3>
                        <p>" . $description . "</p>
                    </li>
                    <li>
                        <h3>分支<h3> "
                        . $modules .
                    "</li>
                </ul>
            </body>
            </html>
        ";

        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=utf-8" . "\r\n";
        $headers .= "Cc: $mailFrom\r\n";

        if (mail($mailTo, $subject, $message, $headers)) {
            show_json();
        } else {
            show_error();
        };
    }

    /**
     * 得到所有module信息
     * @return mixed
     */
    private function getAllModules() {
        $model = new ModuleModel();
        show_json($model->getAllModules());
    }

    /**
     * 根据moduleId获取该module的所有svn分支
     */
    private function getAllBranches() {
        $id = $_GET['id'];
        $model = new ModuleModel();
        $info = $model->getInfoById($id);
        $info = $info[0];
        $ret = array();

        $path = C('SRC_PATH').'/'.$info->storename;
        if (is_dir($path)) {
            foreach(scandir($path) as $branch) {
                if ($branch[0] !== '.') {
                    $ret[] = $branch;
                }
            }
        }

        show_json($ret);
    }

    /**
     * co代码
     */
    private function updateBranch() {
//        header('Content-Type: text/event-stream');
        header('Content-Type: text/octet-stream');
        header('Cache-Control: no-cache');

        $url = $_POST['url'];
        $name = $_POST['name'];
        $path = C('SRC_PATH').'/'.$name;

        if (!file_exists($path)) {
            show_error($name.'模块不存在', true);
        }
        $cmd = 'cd '.$path.' && '.C('SVN').' co '.$url;
        // 如果url和name basename相同，则为trunk分支，co到trunk目录中
        if (basename($url) === basename($name)) {
            $cmd = $cmd.' trunk';
        }
        $ret = shell_exec_ensure($cmd, true, false);
        if ($ret['status']) {
            show_error('命令执行失败:'.$cmd);
        } else {
            $model = new ModuleModel();
            $info = $model->getInfoByStorename($name);
            if (!empty($info)) {
                $info = $info[0];
            }
            show_json($info);
        }
    }

    /**
     * 新增模块
     */
    private function addModule() {
        $data = array(
            'name' => $_POST['name'],
            'title' => $_POST['title'],
            'description' => $_POST['description'],
            'fe' => $_POST['fe'] === 'true' ? 1 : 0
        );
        $model = new ModuleModel();
        $model->addModule($data);
        show_json();
    }

    private function deleteModule() {
        $model = new ModuleModel();
        $model->deleteModule($_POST['id']);
        show_json();
    }
}