{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/zoom_image/zoom_image.html.tpl"}
<ul class="list clearfix">
	{if  $tplData.photoList}		
		{foreach $tplData.photoList as $photo}
			{if $photo@index<12}
			<li class="photo-item">
				<a class="photo-border"  href="/photo/fans#{$photo.photo_id}-{$photo@index}">
					{zoom_image lazyload = false  url=$photo.photo_url zoomWidth=160 zoomHeight=160 imgWidth=$photo.photo_width imgHeight=$photo.photo_height}				
				</a>
			</li>
			{/if}
		{/foreach}
	{else}
		<li>
		<div class="no-data">目前Ta还没有照片。</div>
		</li>
	{/if}	
	</ul>
{/block}

{block name="ajax_css"}

{/block}


{block name="ajax_js"}
{/block}
