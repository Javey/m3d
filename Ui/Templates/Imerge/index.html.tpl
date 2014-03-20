<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Images Merge Preprocess</title>
    <link type="text/css" rel="stylesheet" href="/static/css/imerge.css"/>
</head>
<body>
<header>
    <h1>Images Merge Preprocess</h1>
    <nav>
        {foreach $tplData.types as $type}
            <a href="/imerge?site={$tplData.params.site}&module={$tplData.params.module}&type={$type}" title="{$type}" {if $tplData.curType === $type}class="actived"{/if}>{$type}</a>
        {/foreach}
    </nav>
</header>
<aside>
    <a href="/imerge/sprite/type/{$tplData.curType}" title="点击浏览大图">
        <img src="/imerge/sprite/type/{$tplData.curType}"/>
    </a>
</aside>
<article>
    <table id="control-panel">
        <thead>
        <tr>
            <th >Source</th><th >Padding</th><th>Float</th><th>Repeat</th><th>Border</th><th >Limit</th>
        </tr>
        <tr>
            <td>(uri)</td><td>(px)</td><td>direct</td><td>x|0|y</td><td>(px)</td><td>w|h(px)</td>
        </tr>
        </thead>
        <tbody id="tbody">
        <tr>
            <td class="td-input" colspan="6">
                <input type="text" id="new_image" placeholder="输入小图文件名" />
                <input type="button" id="confirm" value="确认">
                {*<input type="button" id="cancel" value="取消">*}
            </td>
        </tr>
        {$direct = ['top', 'left', 'right', 'bottom', 'none']}
        {foreach $tplData.config as $uri => $config}
        <tr>
            <td class="td-img">
                <a href="/imerge/image?uri={$uri}" target="_blank">
                    <img src="/imerge/image?uri={$uri}"/>
                </a>
                <div>{basename($uri)}</div>
            </td>
            <td class="td-padding">
                {for $i = 0 to 8}
                    {if $i % 2}
                        <input type="text" name="padding-{$direct[floor($i/2)]}" value="{$config['padding-'|cat:$direct[floor($i/2)]]}"/>
                    {else}
                        <div class="empty"></div>
                    {/if}
                {/for}
            </td>
            <td class="td-float">
                {for $i = 0 to 8}
                    {if $i % 2}
                        <input type="radio" name="float{$config@index}" value="{$direct[floor($i/2)]}" {if $direct[floor($i/2)] === $config['float']}checked="checked"{/if}/>
                    {elseif $i === 4}
                        <input type="radio" name="float{$config@index}" value="{$direct[$i]}" {if $direct[$i] === $config['float']}checked="checked"{/if}/>
                    {else}
                        <div class="empty"></div>
                    {/if}
                {/for}
            </td>
            <td class="td-repeat">
                {foreach ['x', 'none', 'y'] as $key}
                    <input type="radio" name="repeat{$config@index}" value="{$key}" {if $config.repeat === $key}checked="checked"{/if} />
                {/foreach}
            </td>
            <td class="td-border">
                {for $i = 0 to 8}
                    {if $i % 2}
                        <input type="text" name="border-{$direct[floor($i/2)]}" value="{$config['border-'|cat:$direct[floor($i/2)]]}"/>
                    {else}
                        <div class="empty"></div>
                    {/if}
                {/for}
            </td>
            <td class="td-limit">
                {foreach ['width', 'height'] as $key}
                    <input type="text" name="min-{$key}" value="{$config['min-'|cat:$key]}"/>
                {/foreach}
            </td>
        </tr>
        {/foreach}
        </tbody>
    </table>
</article>
<script type="text/javascript" src="/static/js/lib/jquery.js"></script>
<script type="text/javascript" src="/static/js/ui/imerge.js"></script>
</body>
</html>