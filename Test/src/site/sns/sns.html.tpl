{extends file="ting.html.tpl"}
{block name="assign" append}
    {**add sunxiangpeng **}
	{$navIndex = false}

{/block}
{block name="body_class" append}
class="sns {block name="body_class_name"}{/block}"
{/block}
{block name="css" append}
<link rel="stylesheet" type="text/css" href="/static/css/sns.css{*version file='/static/css/sns.css' prefix='?' suffix='.css'*}" />
{/block}
{block name="content_main"}
	{block name="ad-banner"}{/block}
	{block name="sns_top"}			
	{/block}
    {block name='sns_body'}
        <div class="main-body">

            {block name="sns_left"}{/block}
        </div><!--end sns-left-->
        <div class="sidebar">

            {block name="sns_right"}{/block}
        </div><!--end sns_right-->
    {/block}
{/block}
