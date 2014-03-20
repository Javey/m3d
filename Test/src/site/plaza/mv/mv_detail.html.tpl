{extends file="plaza/plaza.html.tpl"}
{block name="title"}MV{/block}
{block name="assign" append}
    {$navIndex = 'mv'}

    {$recommendArray= [
        "new"       => "最新发布",
        "hot"       => "最热MV"
    ]}
    {$areaArray     = [
        "ht"        => "港台",
        "ml"        => "内地",
        "jp"        => "日本",
        "kr"        => "韩国",
        "western"   => "欧美",
        "other"     => "其他"
    ]}
    {$styleArray    = [
        "pop"       => "流行",
        "rock"      => "摇滚",
        "folk"      => "民谣",
        "hiphop"    => "嘻哈",
        "electronic"=> "电子",
        "rb"        => "R&B"
    ]}
    {$featureArray  = [
        "official"  => "官方版",
        "live"      => "现场版",
        "concert"   => "演唱会",
        "subtitle"  => "字幕版",
        "cartoon"   => "动漫",
        "ost"       => "影视原声",
        "dance"     => "舞曲"
    ]}

    {$order = $tplData.param.order|default:'hot'}
    {$stylename = $tplData.param.stylename|default:'all'}
    {$area = $tplData.param.area|default:'all'}
    {$recommend = $tplData.param.recommend|default:'all'}
    {$feature = $tplData.param.feature|default:'all'}
{/block}

{block name="css" append}
    <link rel="stylesheet" type="text/css" href="/static/css/mv_detail.css"/>
{/block}

{block name='js-monkey-pageid'}ting-music-mv-detail{/block}

{block name="body_class_name"}
    channel
{/block}

{block name="content_main"}
    {include file="plaza/mv/mod_detail_sidebar.html.tpl" inline}
    {include file="plaza/mv/mod_detail_body.html.tpl" inline}
{/block}
