{extends 'data2.json.tpl'}
{block 'json_data'}
{capture name="cap_html"}{block name="ajax_html"}{/block}{/capture}
{capture name="cap_js"}{block name="ajax_js"}{/block}{/capture}
{capture name="cap_css"}{block name="ajax_css"}{/block}{/capture}
{$jsonData = [
	"html" => $smarty.capture.cap_html,
	"js" => $smarty.capture.cap_js,
	"css" => $smarty.capture.cap_css
	]}
{/block}
