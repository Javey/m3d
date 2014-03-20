{extends file="ting.html.tpl"}

{block name="assign" append}
  {**
	{$navIndex='plaza'}
	{$plazaNav='news'}
  **}
{/block}

{block name="title"}{block name="news_title"}{/block}{/block}

{block name="css" append}
	<link rel="stylesheet" type="text/css" href="http://ting.baidu.com/cms/news/static/news.css" />
{/block}

{block name="content_main"}
	{block name="news_content"}{/block}
{/block}

{block name="js" append}
	{block name="news_js"}{/block}
{/block}
