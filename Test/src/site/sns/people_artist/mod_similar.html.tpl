{**
  * 类似歌手
  * 
  * @author sunxiangpeng
  * @param relatedList 人物信息
  * 
  **}
{extends file="module/module.html.tpl"}
{block name='mod_class'}related-singer{/block}
{block name='mod_attr'}monkey="related-singer"{/block}
{block name="mod_head"}
<span class="more"><a href="#" id="updateArtist" class="update-artist">换一换</a> </span>
<h2 class="title">推荐歌手</h2>

{/block}
{block name="mod_body"}

{include file="widget/people_icon/people_icon.html.tpl" empty=false inline}
{include file="widget/user_link/user_link.html.tpl" inline}
	<ul class="related-list clearfix" data-data ='{json_encode(["t"=>$tplData.relate_artist.t,"id"=>$tplData.artist_info.ting_uid])}'>
	
	{foreach $tplData.relate_artist.artists as $item}
	{if $item@index < 9}
		{$initPage = true}
		{$lazyload = false}
	{else}
		{$lazyload = true}
		{$initPage = false}
	{/if}
	{if ($item@index+1) % 9 == 0}
        {$wrap = true}
	  {else}
	    {$wrap = false}
	  {/if}
		<li data-data='{json_encode(["m"=>$item.m,"id"=>$item.ting_uid])}'>
			{people_icon  lazyload = $lazyload  type = "middle" imgsize = 60 people=$item showName=false}
			<h4>
				<a href="/artist/{$item.ting_uid}" title="{$item.name}">{$item.name|pixel_truncate:60}</a>
			</h4>
		</li>
		{if $wrap && ($item@index + 1) != count($tplData.relate_artist.artists)}
        </ul><ul data-data ='{json_encode(["t"=>$tplData.relate_artist.t,"id"=>$tplData.artist_info.ting_uid])}' class="related-list clearfix" style="display:none;">
      {/if}
	{/foreach}
	</ul>



{/block}
