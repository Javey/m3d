{extends file="plaza/plaza.html.tpl"}
{block name="title"}MV{/block}
{block name="assign" append}
    {$navIndex = 'mv'}
{/block}

{block name="css" append}
    <link rel="stylesheet" type="text/css" href="/static/css/mv_plaza.css"/>
{/block}
{block name="js" append}
    <script type="text/javascript" src="/static/js/mv_plaza.js"></script>
{/block}

{block name='js-monkey-pageid'}ting-music-mv-index{/block}

{block name="content_main"}
    {include file="plaza/mv/mod_top.html.tpl" inline}
    <div class="mv-module-wrapper">
        {include file="plaza/mv/mod_body.html.tpl" inline}
    </div>
{/block}