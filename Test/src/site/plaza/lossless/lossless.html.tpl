{extends file="plaza/plaza.html.tpl"}
{block name="title"}无损专区{/block}
{block name="assign" append}
    {$navIndex = ''}

    {$areaArray     = [
        "all"       => "全部",
        "cn"        => "华语",
        "jpkr"      => "日韩",
        "western"   => "欧美"
    ]}
    {$styleArray    = [
        "all"       => "全部",
        "pop"       => "流行",
        "rock"      => "摇滚",
        "blues"     => "布鲁斯",
        "hiphop"    => "嘻哈",
        "folk"      => "民谣",
        "electronic"=> "电子",
        "jazz"      => "爵士",
        "classic"   => "古典",
        "world"     => "世界音乐"
    ]}
    {$artistArray   = [
        "all"       => "全部",
        "1157"      => "汪峰",
        "2507"      => "张学友",
        "45561"     => "王菲",
        "1490"      => "凤凰传奇",
        "1077"      => "陈奕迅",
        "1100"      => "beyond",
        "1224"      => "刘德华",
        "1094"      => "任贤齐"
    ]}

    {$order = $tplData.param.order|default:'hot'}
    {$stylename = $tplData.param.stylename|default:'all'}
    {$area = $tplData.param.area|default:'all'}
    {$artist = $tplData.param.artist_id|default:'all'}
    {$view = $tplData.param.view|default:'album'}

    {$urlType = "{if $artist !== 'all'}{$artist}{else}{$area}_{$stylename}{/if}"}
{/block}

{block name="css" append}
    <link rel="stylesheet" type="text/css" href="/static/css/lossless_plaza.css"/>
{/block}
{block name="js" append}
    <script type="text/javascript" src="/static/js/lossless_plaza.js"></script>
{/block}

{block name='js-monkey-pageid'}ting-music-lossless-index{/block}

{block name="body_class_name"}channel{/block}

{block name="content_main"}
    {include file="plaza/lossless/mod_top.html.tpl" inline}
    <div class="content-wrapper">
        {include file="plaza/lossless/mod_sidebar.html.tpl" inline}
        {include file="plaza/lossless/mod_body.html.tpl" inline}
    </div>
{/block}