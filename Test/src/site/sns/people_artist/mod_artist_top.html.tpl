{extends file="module/module.html.tpl"}
{block name='mod_class'}mod-artisttop{/block}
{block name='mod_attr'}monkey="mod-artisttop"{/block}
{block name="mod_head"}
<span class="more"><a href="/top/artist">更多<span>&gt;&gt;</span></a> </span>
<h2 class="title">歌手榜</h2>
{/block}
{block name="mod_body"}
{include file="widget/people_icon/people_icon.html.tpl" empty=false inline}
{include file="widget/user_link/user_link.html.tpl" inline}
	<ul class="clearfix">
	
	{foreach $tplData.artistBillboard as $item}
	{if $item@index < 9}

		<li data-data='{json_encode(["m"=>$item.m,"id"=>$item.ting_uid])}'>
			<i class="{if $item@first}top-first{/if} top-index">{$item@index+1}</i>
			{people_icon   type = "middle" imgsize = 60 people=$item showName=false}
			<h4>
				<a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:60}</a>
			</h4>
		</li>
      {/if}
	{/foreach}
	</ul>
{/block}