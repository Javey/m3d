{**
  * 相关歌手
  * 
  * @author zhangyuanwei
  * @param relatedList 人物信息
  * 
  **}
{extends file="module/module.html.tpl"}
{block name='mod_class'}related-singer{/block}
{block name='mod_attr'}monkey="related-singer"{/block}
{block name="mod_head"}
<h2 class="title">推荐歌手</h2>
{/block}
{block name="mod_body"}

{include file="widget/people_icon/people_icon.html.tpl" empty=false inline}
{include file="widget/user_link/user_link.html.tpl" inline}
<ul class="related-list clearfix">
{foreach $tplData.relate_artist as $artist}
	<li>
		{people_icon type = 60 imgsize = 60 people=$artist showName=false}
		<h4>
			<a href="{user_link user=$artist}" title="{$artist.name}">{$artist.name|pixel_truncate:60}</a>
		</h4>
	</li>
{/foreach}
</ul>
{/block}
