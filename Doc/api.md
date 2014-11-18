# API

## 网络API

m3d提供了一套restful api，用于外部交互，m3d的控制面板全部通过api进行交互渲染。

例如：[`http://music.m3d.javey.me/project/info?method=get`](http://music.m3d.javey.me/project/info?method=get)

由于有些开发机不支持`put`，`delete`等http method，所以采用了加入参数`method`来区分请求类型，所有`method !== 'get'`的请求都用 `post` method

目录`Lib/Action`下的文件为请求入口文件，每个`Action.class.php`对应一类请求，`/project/info`对应`ProjectAction.class.php`，并执行`info`方法

1. ### 获取工程信息

    Note: 取自工程配置文件`project/music/conf/config.php`

    Method: `GET`

    API: [`http://music.m3d.javey.me/project/info`](http://music.m3d.javey.me/project/info)

    Response:
    ```javascript
    {
        errorCode: 200,
        data: {
            host: "music.baidu.com", // 对应测试环境的地址，将会用改地址加上环境名称前缀，如:youhua.music.baidu.com
            name: "音乐主站"
        }
    }
    ```

1. ### 获取所有测试环境名称

    Method: `GET`

    API: [`http://music.m3d.javey.me/site/name`](http://music.m3d.javey.me/site/name)

    Response:
    ```javascript
    {
        errorCode: 200,
        data: [
            "youhua",
            "huaihuai",
            "vip",
            "mpc"
        ]
    }
    ```

1. ### 获取测试环境详细信息

    Method: `GET`

    API: [`http://music.m3d.javey.me/site/info?name=javey`](http://music.m3d.javey.me/site/info?name=javey)

    Response:
    ```javascript
    {
        errorCode: 200,
        data: {
            id: 17,
            name: "javey",
            author: "M3D",
            createTime: "2014/04/18",
            description: "javey",
            modules: [
                // 模块列表，只返回该测试环境需要的模块
                {
                    id: 3, // 模块id
                    title: "web",
                    filename: "web",
                    storename: "app/search/music/rd/web",
                    description: "主站RD模块",
                    fe: 0, // 是否是fe模块，用于判断是否展示“合图”，“编译”，“提测”按钮，'0'表示不显示
                    branch: "music_1-0-208_new_index_BRANCH"
                },
                {
                    id: 4,
                    title: "main",
                    filename: "main",
                    storename: "app/search/music/fe/main",
                    description: "主站FE模块",
                    fe: 1,
                    branch: "music_1-0-8-4_BRANCH"
                },
                {
                    id: 5,
                    title: "mobile",
                    filename: "mobile",
                    storename: "app/search/music/fe/mobile",
                    description: "webapp",
                    fe: 1,
                    branch: "trunk"
                }
            ]
        }
    }
    ```

1. ### 改变测试环境信息

    Note: 可以将上述api获取的信息，做相应的改变后，进行保存。能改变的字段有:`description`, `modules -> branch`，其它字段如果改变将会忽略或报错

    Method: `POST`

    API: [`http://music.m3d.javey.me/site/info?method=put`](http://music.m3d.javey.me/site/info?method=put)

    Post Data(Form Data)：
    ```javascript
    id:17
    name:javey
    author:M3D
    createTime:2014/04/18
    description:javey // 可以改变描述信息
    modules[0][id]:3
    modules[0][title]:web
    modules[0][filename]:web
    modules[0][storename]:app/search/music/rd/web
    modules[0][description]:主站RD模块
    modules[0][fe]:0
    modules[0][branch]:music_1-0-176_tieba_BRANCH // 改变指向的svn分支，参考：获取一个模块下所有的svn分支的接口
    modules[1][id]:4
    modules[1][title]:main
    modules[1][filename]:main
    modules[1][storename]:app/search/music/fe/main
    modules[1][description]:主站FE模块
    modules[1][fe]:1
    modules[1][branch]:music_1-0-8-4_BRANCH
    modules[1][$$hashKey]:017
    modules[2][id]:5
    modules[2][title]:mobile
    modules[2][filename]:mobile
    modules[2][storename]:app/search/music/fe/mobile
    modules[2][description]:webapp
    modules[2][fe]:1
    modules[2][branch]:trunk
    ```

    Response:
    ```javascript
    {"errorCode":200,"data":""}
    ```

1. ### 获取一个模块下所有的svn分支

    Method: `GET`

    API: [`http://music.m3d.javey.me/module/branches?id=3`](http://music.m3d.javey.me/module/branches?id=3)

    Response:
    ```javascript
    {
        errorCode: 200,
        data: [
            "VIP_qudao_BRANCH",
            "music_1-0-116_ipadrouter_BRANCH",
            "music_1-0-176_dianquan_BRANCH",
            "music_1-0-176_kingb_BRANCH",
            "trunk"
        ]
    }
    ```

1. ### 获取所有模块

    Method: `GET`

    API: [`http://music.m3d.javey.me/module`](http://music.m3d.javey.me/module)

    Response:
    ```javascript
    {
        errorCode: 200,
        data: [
            {
                id: 3,
                title: "web",
                filename: "web",
                storename: "app/search/music/rd/web",
                description: "主站RD模块",
                fe: 0
            },
            {
                id: 4,
                title: "main",
                filename: "main",
                storename: "app/search/music/fe/main",
                description: "主站FE模块",
                fe: 1
            },
            {
                id: 5,
                title: "mobile",
                filename: "mobile",
                storename: "app/search/music/fe/mobile",
                description: "webapp",
                fe: 1
            },
            {
                id: 6,
                title: "ipad-mig",
                filename: "ipad-mig",
                storename: "app/search/music/fe/ipad-mig",
                description: "ipad-webapp",
                fe: 1
            }
        ]
    }
    ```

1. ### 新增环境

    Method: `POST`

    API: `http://music.m3d.javey.me/site/name?method=post`

    Post Data(Form Data):
    ```javascript
    siteName:javey
    description:test
    modules[0][id]:3
    modules[0][title]:web
    modules[0][filename]:web
    modules[0][storename]:app/search/music/rd/web
    modules[0][description]:主站RD模块
    modules[0][fe]:0
    modules[0][branch]:trunk
    modules[1][id]:4
    modules[1][title]:main
    modules[1][filename]:main
    modules[1][storename]:app/search/music/fe/main
    modules[1][description]:主站FE模块
    modules[1][fe]:1
    modules[1][branch]:trunk
    ```

    Response:
    ```javascript
    {"errorCode":200,"data":""}
    ```

1. ### 删除环境

    Method: `POST`

    API: `http://music.m3d.javey.me/site/name?method=delete`

    Post Data(Form Data):
    ```javascript
    name:javey
    ```

    Response:
    ```javascript
    {"errorCode":200,"data":""}
    ````

1. ### 刷新环境

    Note: 刷新环境，相当于删除后重建，由于环境的软链配置并没有存入db，而是根据文件实际软链路径确定的，所以需要提供详细的重建环境数据（Post Data）。该功能可用来更新环境lighttpd配置（当template_site模板分支配置改变时，同步过去），还可以用来清除smarty缓存。

    Method: `POST`

    API: `http://music.m3d.javey.me/site/name?method=put`

    Post Data(Form Data):
    ```javascript
    id:58
    name:doc
    author:M3D
    createTime:2014/11/11
    description:test
    modules[0][id]:3
    modules[0][title]:web
    modules[0][filename]:web
    modules[0][storename]:app/search/music/rd/web
    modules[0][description]:主站RD模块
    modules[0][fe]:0
    modules[0][branch]:trunk
    modules[1][id]:4
    modules[1][title]:main
    modules[1][filename]:main
    modules[1][storename]:app/search/music/fe/main
    modules[1][description]:主站FE模块
    modules[1][fe]:1
    modules[1][branch]:trunk
    ```

1. ### 添加模块

    Method: `POST`

    API: `http://music.m3d.javey.me/module?method=put`

    Post Data(Form Data):
    ```javascript
    name:app/search/music/fe/webapp-lebo // 对应[scm](http://scm.baidu.com/index/index.action)平台中的模块路径
    title:webapp-lebo
    description:乐播webapp
    fe:true // 是否是fe模块，用于决定是否显示“编译”等按钮
    ```

    Response:
    ```javascript
    {"errorCode":200,"data":""}
    ```

1. ### 删除模块

    Method: `POST`

    API: `http://music.m3d.javey.me/module?method=delete`

    Post Data(Form Data):
    ```javascript
    id:7 // 要删除的模块id
    ```

    Response:
    ```javascript
    {"errorCode":200,"data":""}
    ```

1. ### CheckOut代码到开发机

    Note: m3d不会自动与svn服务器进行同步代码，所有在svn中新建的分支必须co到开发机才能使用，一般新增模块后需要co trunk到开发机

    Method: `POST`

    API: `http://music.m3d.javey.me/module/branches?method=post`

    Post Data(Form Data):
    ```javascript
    url:https://svn.baidu.com/app/search/music/trunk/fe/webapp-lebo/ // svn地址
    name:app/search/music/fe/webapp-lebo // 对应的模块路径，相应scm平台模板路径
    ```

    Response:

    输出是文本流，用于terminal中展示命令执行的详细信息

1. ### 添加用户名

    Note: 用户名管理，仅用于提测收发邮件

    Method: `POST`

    API: `http://music.m3d.javey.me/user?method=post`

    Post Data(Form Data):
    ```javascript
    name:邹家伟
    email:邹家伟@baidu.com
    type:to // to代表收件人，一般为QA，from代表发件人，一般为FE
    ```

    Response:
    ```javascript
    {"errorCode":200,"data":""}
    ```

1. ### 删除用户名

    Method: `POST`

    API: `http://music.m3d.javey.me/user?method=delete`

    Post Data(Form Data):
    ```javascript
    name:邹家伟
    type:to
    ```

    Response:
    ```javascript
    {"errorCode":200,"data":""}
    ```

1. ### 合图

    Method: `GET`

    API: [`http://music.m3d.javey.me/imerge/auto?site=youhua&module=main`](http://music.m3d.javey.me/imerge/auto?site=youhua&module=main)

    Description: `site`为环境名称，`module`为模块名称

    Response:

    输出是文本流，用于terminal中展示命令执行的详细信息

2. ### 编译

    Method: `GET`

    API: [`http://music.m3d.javey.me/process?site=youhua&module=main&isIncre=true`](http://music.m3d.javey.me/process?site=youhua&module=main&isIncre=true)

    Description: `site`为环境名称，`module`为模块名称，`isIncre = true || false`，是否进行增量编译

    Response:

    输出是文本流，用于terminal中展示命令执行的详细信息

1. ### 提测

    Method: `POST`

    API: `http://music.m3d.javey.me/module/test?method=post`

    Post Data(Form Data):
    ```javascript
    to:zoujiawei@baidu.com,
    from:zoujiawei@baidu.com,
    // 模块信息，一般需要提供rd模块和fe模块
    modules[rd][id]:3
    modules[rd][title]:web
    modules[rd][filename]:web
    modules[rd][storename]:app/search/music/rd/web
    modules[rd][description]:主站RD模块
    modules[rd][branch]:trunk
    modules[fe][id]:4
    modules[fe][title]:main
    modules[fe][filename]:main
    modules[fe][storename]:app/search/music/fe/main
    modules[fe][description]:主站FE模块
    modules[fe][branch]:trunk
    subject:test // 主题
    description:test // 描述信息
    ```
    Response:
    ```javascript
    {"errorCode":200,"data":""}
    ```

## 系统API

### 全局函数

1. #### require_cache

    require_once优化版

    * __param__: `$filename {String}` 文件路径
    * __return__: `{Boolean}`

    ```php
    require_cache('path/to/php.php');
    ```

2. #### require_array

    批量




