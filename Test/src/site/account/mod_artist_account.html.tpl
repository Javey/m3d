{extends 'module/mod_left/mod_left.html.tpl'}
{block 'mod_class'} mod-left-home {/block}
{block 'mod_tabs'}
<ul class="mod-tabs mod-tabs-left">
    <li {if $tabIndex == 'profile'} class="on" {/if}><a href="/account/profile">基本信息</a> </li>
    <li {if $tabIndex == 'banner'} class="on" {/if}><a href="/account/banner">个性化头图</a> </li>
    <li {if $tabIndex == 'broadcast'} class="on" {/if}><a href="/account/route">公告栏</a> </li>
</ul>
{/block}
{block name="mod_body"}{/block}
