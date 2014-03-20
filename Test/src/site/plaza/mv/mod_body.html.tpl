{include file="widget/author_list/author_list.html.tpl" inline}
{include file="widget/mv_cover/mv_cover.html.tpl" inline}
{include file="widget/mv_list/mv_list.html.tpl" inline}

{function name="_mv_list" data=null title='' class='' focus='' href='#' first=false color='' count=5}
    <div class="module mv-{$class}" monkey="mv-{$class}" alog-alias="mv-{$class}">
        <div class="head clearfix">
            <h2 style="border-bottom-color: {$color}"><a name="{$class}"></a>{$title}</h2>
            <a href="{$href}" class="more" title="更多">更多</a>
        </div>
          {mv_list list=$data showPlayIcon=false showNumber=true focus=$focus target=false className='body' count=$count perLine=false}
    </div>
{/function}

{include file="plaza/mv/configure.html.tpl" inline}
{foreach $configure as $key => $value}
    {if $tplData.$key.hasFocus == 1 }
        {$hasFocus = 1}
        {$mvCount = 6}
    {else}
        {$hasFocus = 0}
        {$mvCount = 5}
    {/if}
    {_mv_list data=$tplData.$key['mvList'] title=$value.title class=$key focus=$hasFocus href=$value.href first=$value.first color=$value.color count=$mvCount|default:5}
{/foreach}
{*<ol class="mv-index">*}
    {*{foreach $configure as $key => $value}*}
        {*<li class="mv-{$key}"><a href="#{$key}" title="{$value.title}"><span class="mv-color" style="background: {$value.color}"></span>{$value.short|default:$value.title}</a></li>*}
    {*{/foreach}*}
{*</ol>*}
