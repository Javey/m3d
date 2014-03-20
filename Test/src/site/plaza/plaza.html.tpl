{extends file="ting.html.tpl"}

{block name="assign" append}
{$navIndex='home'}
{/block}
{block name="body_class"}
class="{block name="body_class_name"}{/block}"
{/block}
{block name="css" append}
{/block}
{block name="content_main"}
	{block name="plaza_top"}
	<div class="plaza-top ">
		
	</div>
	{/block}
	<div class="main-body">
		{block name="plaza_left"}{/block}
	</div><!--end plaza-left-->
	{block name="module_line"}{/block}
	<div class="sidebar">
		{if $showBackTing}
			<a class="back-ting" href="{user_link user=$loginInfo}"></a>
		{/if}
		{block name="plaza_right"}{/block}
	</div><!--end plaza_right-->
{/block}
{block name="music_banner_ad"}
	{block name="plaza_bottom"}{/block}
{/block}