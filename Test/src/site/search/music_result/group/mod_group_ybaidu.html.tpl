{**代表音乐人
  **}
{extends file="module/module.html.tpl"}
{block name='mod_class'}group-ybaidu{/block}
{block name='mod_attr'}monkey="group-ybaidu"{/block}
{block name="mod_head"}
<h2 class="title">代表音乐人</h2>

{/block}
{block name="mod_body"}
{include file="widget/people_icon/people_icon.html.tpl" empty=false inline}
{include file="widget/user_link/user_link.html.tpl" inline}
	<ul class="related-list clearfix">
	
	{foreach $tplData.yyrobject.res_array as $item}
	{if $item@index<6}
		<li data-data='{json_encode(["m"=>$item.m,"id"=>$item.ting_uid])}'>
<div class="people-icon  cover-img">
	<a  target="_blank"  href="http://y.baidu.com/artist/{$item.artist_id}?pst=music_search" title="" class="img-link cover"><img class="avatar" src="{$item.avatar_middle}" width="60" height="60" alt="{$item.singer}"></a>
	</div>			
			<h4>
				<a  target="_blank"  href="http://y.baidu.com/artist/{$item.artist_id}?pst=music_search" title="{$item.singer}">{$item.singer|pixel_truncate:60}</a>
			</h4>
		</li>
	{/if}
	{/foreach}
	</ul>



{/block}
