# 介绍

## 乐播web包括3个模块：

1. lebo-proxy

    SCM: `app/search/music/fe/lebo-proxy`

    Note: 为了与api解耦，基于[odp](http://man.baidu.com/inf/odp/tutorial/)做了一层中间件，主要做前端路由和取数据拼装模板

2. lebo-pcweb

    SCM: `app/search/music/fe/lebo-pcweb`

    Note: pcweb前端

3. webapp-lebo

    SCM: `app/search/music/fe/webapp-lebo`

    Note: webapp前端

## 请求流程

一个请求到来先到`lebo-proxy`，该模块会判断UA，如果是webapp则将请求跳转到首页，并将url转为hash地址

例: http://lebo.baidu.com/album/12345 -> http://lebo.baidu.com/#album/12345

```flow
start=>start: Start
isHome=>condition: Is home page or Not?
isWebapp=>condition: Is webapp or Not?
isCached=>condition: Does hit smarty cache or Not?
changeUrl=>operation: Change url to hash, and location to home page
readCache=>operation: Read smraty cache
api=>operation: Request api
display=>operation: Assign data and display template
end=>end

start->isWebapp
isWebapp(yes)->isHome
isHome(yes)->display->end
isHome(no)->changeUrl->isWebapp
isWebapp(no)->isCached
isCached(yes)->readCache->end
isCached(no)->api->display->end
```

## 开发

* ### 开发机

    IP: `10.81.24.176`

    User: `work`

    SSH: `ssh work@10.81.24.176`

    Passwd: `MhxzKhlwork`

    Odp: `~/odp`

    M3d: `~/m3d` [m3d dashboard](http://new.lebo.m3d.baidu.com:8088/)

    Port: `8088`

* ### pcweb开发

    1. lebo-pcweb

        采用nobone-sync同步的方式进行开发，同步路径为：`/home/web/m3d/project/lebo/site/new/src/lebo-pcweb/src`。

        开发完成后，提交代码到svn，进入m3d流程

    2. lebo-proxy

        [nobone-sync](https://github.com/ysmood/nobone-sync)同步路径为：`/home/web/m3d/project/lebo/site/new/src/lebo-proxy`。上线无需m3d处理

* ### webapp开发

    webapp为本地开发方式，代码co到本地后，需要`npm install`安装依赖，由于采用了`sass`，还需要安装`compass`(可以考虑采用`stylus`)，解决所有依赖后，执行：

    ``` javascript
    gulp connect
    ```

    开启本地服务器，进行开发。`livereload`功能会在你每次保存后，自动刷新浏览器

    开发完成后，提交代码到svn，进入m3d流程。


## 上线

icms上线频道为`mini`，上线模块全部为：`ID: 159` `newlebo.baidu.com`，上线流程同其他产品线，目前没有预览机，务必做好充分自测，发现问题请及时回滚。

# 代码

1. ## lebo-pcweb

    * ### 结构

        * `build`: 存放m3d编译后文件
        * `config`: 存放scm编译所需的配置文件
        * `m3d`: m3d编译缓存文件
        * `src`: 业务源码
            * `_m3d`: m3d配置
                * `imerge`: 合图配置，该目录下的文件不能被修改
                * `m3d.php`: m3d配置文件
            * `static`: 静态文件
            * `template`: smarty模板
        * `build.sh`: scm编译打包脚本
        * `m3d.php`: m3d编译配置文件，`require('src/_m3d/m3d.php);`

        js加载方式，除了每个页面都可能用到的js(`base.js`)库外，其他都通过require按需加载。

        * `js/core`: 自定义库
        * `js/lib`: 第三方库
        * `js/page`: 每个页面单独依赖的js
        * `js/widget`: 对应smarty组件所需的js

    * ### 个别文件特殊说明：

        * `js/core/common.js`: 全局包含。主要实现统计、头部登录、搜索建议（sug）功能。
        任何需要发送`click`点击统计的地方，可以在标签上加上类似`data-log="{pos: 'header'}"`这样的属性实现
        * `js/core/player.js`: 播放器的实现，对`muplayer`进行了封装，加入广告和跳过干扰音的逻辑
        * `js/core/utils.js`: 全局包含。一些帮助函数
        * `js/lib/localStorage.js`: 全局包含。封装了`localStorage`，支持ie，如果需要用到本地存储。
        尽量少用`cookie`，因为`cookie`每次`request`都会带上，会增大请求包的大小，而且有容量限制。

    * ### 取图

        乐播api图片数据非常混乱，但模板中经常需要根据实际情况选取最合适的`尺寸/比列`的图片，故实现了几个`smarty`插件

        1. `template/plugins/modifier.square_pic.php`: 根据`宽度/高度`获取正方向的图片，__适用于api1.0__
        2. `template/plugins/modifier.new_square_pic.php`: 同上，__适用于api2.0__
        3. `template/plugins/modifier.ratio_width_pic.php`: 根据宽度(`width`)和宽高比(`ratio`)获取最适合的图片，__适用于api1.0，api2.0需要改下字段名__

    * ### 关于对`muplayer`的封装

        文件`js/core/player.js`中，加入了广告和跳过干扰音的业务逻辑，现在的策略是（后续有变，歌曲选链和广告选链将分离）：
        歌曲选链返回`广告音频`、`广告锚点`、及`干扰音位置和时长`。播放时，会一直监听`timeupdate`事件，
        当遇到`锚点`所标识的时刻，则会暂停音频内核，启动广告内核播放广告，当遇到`干扰音`时，音频内核将根据干扰音时常跳过该段音频

        实现细节：

        * 初始化两个内核，音频内核`player`&广告内核`adPlayer`
        * `player`的`fetch`方法会将歌曲信息，干扰音`disturb_list`，广告锚点`anchor_list`，广告音频列表`ad_list`保存起来
        * `adPlayer`的`fetch`方法是从第2步保存的数据中获取广告音频地址
        * 监听`timeupdate`事件，然后执行判断，是否遇到了锚点，是否遇到了干扰音，然后执行相关动作。
        需注意，因为事件派发有300ms左右间隔，所以加入了精度控制`accuracy`，并不能绝对地确定音频播放位置
        * 为了使原始音频和广告看起来就像一个音频，加入了事件代理，所有`adPlayer`派发的时间都代理到`player`上
        ```js
        // 事件代理
        adPlayer.engine.on('engine:statechange', function(state) {
            var newState = state.newState;
            if (newState === 'buffering' || newState === 'playing' || newState === 'pause') {
                player.engine.trigger('engine:statechange', state);
            }
        });
        ```
        为了对外暴露一致的接口，`player`的`play` `pause` `stop`等事件，也要在当前`adPlayer`激活时，做相应处理，外部无需关系当前是操作`player`还是`adPlayer`

    * ### 其他一些需要注意的业务逻辑

        1. url控制专辑详情页播放
            * 自动播放：http://lebo.baidu.com/album/3070662?autoplay=true，自动播放第一首歌
            * 指定播放歌曲id：http://lebo.baidu.com/album/3070662?song_id=3077666 ，或者，直接访问歌曲页http://lebo.baidu.com/song/3077666 ，自动播放`songid === 3077666`的歌曲
            * 指定某首歌在列表中高亮，但不自动播放：http://lebo.baidu.com/album/3070662?song_id=3077666&autoplay=false
        2. 专辑详情页在遇到小说类节目（还有些人工指定的节目）时，默认正序展示

    * ### `core/utils.js`

        1. 该文件定义了一些全局函数，命名空间`$.utils`，包括：
            * 请求lebo-proxy中的api: `api`
            * 请求lebo api提供的接口: `leboApi/newLeboApi`
            * 发送统计信息到lebo api: `leboApiLog`
            * 反序列化参数，$.param的反函数: `unParam`
            * 发送统计: `sendLog`
            * 前端获取方图，类似smarty中的取图插件: `squarePic`
        2. 定义了全局配置：`$.conf`
        3. 缓存全局经常用到的dom: `$.dom`
        4. 浏览器类型检测


2. ## lebo-proxy

    * ### 前置要求

        这部分需要一定的`php`基础，及了解`odp`的使用，参考地址:

        * [odp首页](http://man.baidu.com/inf/odp/)
        * [odp自带的ap框架手册](http://odp.bae.baidu.com/ap_manual/)

    * ### 目录

        * `app`: 业务源码
            * `lebo/actions`: 每个请求对应的处理文件
                * `lebo/actions/api`: 与api相关的，该处理都会放回`json`数据
            * `controllers`: 控制器，只做一件事，将特定的请求对应到相应的`action`文件
            * `library`: 一些封装的类和工具
            * `models`: 数据相关，通过api请求数据
            * `Bootstrap.php`: 入口文件，这个文件需要频繁改动的地方是`_initRoute`方法，配置路由规则，
            参考[AP_正则路由](http://odp.bae.baidu.com/ap_manual/ap.routes.static.html#ap.routes.regex)
        * `conf`: odp环境配置

    * ### 几点说明：

        1. `class`命名规范：文件路径作为`class`命名，大写首字母，加上`_`，参考现有写法
        2. 关于路由`router`需要注意的是，每个路由都会执行`Bootstrap.php`中定义的路由规则，当没匹配上时就会走
        [默认路由](http://odp.bae.baidu.com/ap_manual/ap.routes.static.html)，这就是`/api/userinfo`没有定义路由规则，却能够匹配上的原因
        3. 页面相关的`action`继承`Lebo_Action`，api相关的`action`继承`Lebo_ApiAction`。* 当然这不是硬性规定，可以根据需要做任何变动 *
        4. `Lebo_LeboApiRequest`下定义了发送请求的方法，都是静态方法，通过`odp`自带的`ral`库进行通信。

         __线下开发时，经常需要更换api地址，这时需要登录开发机（方法上面已说明）修改`/home/web/odp/conf/ral/services/lebo.conf`文件中对应的ip地址，
        不要修改svn checkout下来的源码中的该文件，源码中是给线上用的，开发机上没有使用它。
        具体切换那个`Tag`下的ip地址，可以查看`/home/web/odp/conf/ral/ral-common.conf`中（大约在第7行）所指的是哪个`Tag`__

3. ## lebo-webapp

    目录结构同`lebo-pcweb`

    webapp为纯前端渲染，框架为：`backbone`，使用了`coffee`+`sass`，开发时需要实时编译，预览效果的方法见上（开发说明）

    * ### 关于页面渲染流程

        1. `core/cfg`: 入口文件，其中定义了`deps`属性，所以会加载`app/init`，另外还定义了一些配置信息
        2. `app/init`: 加载`app/app`， 并调用`initialize`方法初始化
        3. `app/app`: 加载路由配置`app/router`，`initialize`绑定路由事件
        4. `app/router`: 当路由变化，调用`App.initModule`初始化页面，该方法会加载对应的`module`和`css`文件，并执行`module`的`initialize`方法
        5. `app/module/*`: 该目录下为每个路由对应的`module`，`module`的初始化会加载相应的`view`
        6. `app/view/*`: 每个`module`对应的`view`，`view`的初始化会加载对应的`template`
        7. `app/template/*`: 每个`view`对应的模板，支持整个页面所需的文件都加载完成，然后就是一堆数据请求和拼模板渲染dom的工程

    * ### 特别需要注意的一个坑

        iphone和部分android上的浏览器如：chrome，会碰到音频资源不能自动播放的问题，该问题产生的原因是audio没有激活，满足下列条件之一时，audio会不能激活：

        1. 首次设置audio的src是通过异步方法进行设置的，例如通过ajax回调
        2. 首次设置audio的src是通过同步设置的，但是不是用户手动触发的，即可能在页面一开始就设置，而不是用户手动执行某个操作后设置

        为了解决这一问题，代码中有些hack如下，见`app/view/song.coffee`：
        ```js
        opt: (e) =>
            $this = $(e.currentTarget)
            player = App.player

            if ($this.hasClass('loading'))
                return
            if ($this.hasClass('pause'))
                player.pause()
            else
                if player.getState() == 'prebuffer'
                    # hack
                    player.setUrl(App.player.engine.engines[0].audio.src)
                    adPlayer.setUrl(App.player.engine.engines[0].audio.src)
                player.play()
        ```

    * ### `core/utils.coffee`

        定义了一些工具函数，类似lebo-proxy中的`core/utils.js`定义

    * ### `app/header.coffee`

        定义了页面头部相关的方法，由于之前和百度新闻有过合作，所以存在判断是否来自百度新闻`baidunews`的逻辑

    * ### `app/app.coffee`

        定义了一些工具函数，这个文件的作用有点类似`core/utils.coffee`，但是更偏向整体架构相关的功能和业务逻辑

        * 布局相关：`userLayout`
        * 初始化`miniPlayer`: `initMiniPlayer`
        * 获取播放器: `getPlayer`
        * 切换页面：`changePage`
        * 加载更多：`loadMore`
        * 广告banner: `initBannerAd`
        * 其他特定模块初始化

# 参考资料

* [odp首页](http://man.baidu.com/inf/odp/)
* [odp自带的ap框架手册](http://odp.bae.baidu.com/ap_manual/)
* [requireJs](http://www.requirejs.org/)
* [backbone](http://backbonejs.org/)
* [underscore/lodash](http://underscorejs.org/)
* [coffee](http://coffeescript.org/) [coffee中文](http://coffee-script.org/)
* [sass](http://www.sass-lang.com/)
* [muplayer](https://github.com/Baidu-Music-FE/muplayer)
* [fe-weekly](https://github.com/Baidu-Music-FE/fe-weekly)
* [jQuery的deferred对象详解](http://www.ruanyifeng.com/blog/2011/08/a_detailed_explanation_of_jquery_deferred_object.html)
* [gulp](https://github.com/gulpjs/gulp)
* [百度分享](http://share.baidu.com/)
* [passport公司内部登录组件](http://dev.passport.baidu.com/home/index)