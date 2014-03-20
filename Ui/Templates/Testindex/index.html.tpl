<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>M3D开发联调平台</title>
    <link rel="stylesheet" href="/static/css/base1.css">
    <script type="text/javascript" src="/static/js/lib/jquery.js"></script>
    <script type="text/javascript" src="/static/js/lib/angular.js"></script>
    {*<script type="text/javascript" src="/static/js/base.js"></script>*}
</head>
<body>
<nav class="fun-panel">
    <div class="item glyphicon glyphicon-cog" title="test"></div>
    <div class="item glyphicon glyphicon-star"></div>
    <div class="item glyphicon glyphicon-cloud-download"></div>
    <div class="item"></div>
</nav>
<aside class="sidebar">
    <div class="search-wrap">
        <input type="text"/>
        <span class="btn btn-a">提交</span>
    </div>
    <nav class="sites">
        {foreach $tplData.all_sites as $name => $list}
            <div class="item {if $list@first}selected{/if}">{$name|escape}</div>
        {/foreach}
    </nav>
</aside>
<article class="site-container">
    <div class="head">
        <h1 class="name">youhua</h1>
        <div class="info">Javey - 2013/12/06</div>
    </div>
    <div class="body">
        <ul class="modules">
            {foreach $tplData.all_modules as $key => $value}
                {*<div class="select">*}
                    {*<a class="hyperlink" href="/{$name|escape}/src/rd-main" target="_blank">{$value.title}:</a>*}
                    {*{html_options name=$key options=$value.branch selected=$list.$key}*}
                {*</div>*}
                <li class="item">
                    <span class="title">{$value.title}</span>
                    <span class="branch">trunk</span>
                    <span class="ctrl">
                        <span class="btn compile">编译</span>
                        <span class="btn merge">合图</span>
                        <span class="btn test">提测</span>
                    </span>
                </li>
            {/foreach}
        </ul>
    </div>
</article>
</body>
</html>
