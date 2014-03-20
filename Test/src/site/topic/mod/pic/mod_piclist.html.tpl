{include file="widget/button/button.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}	
{include file="widget/album_cover/album_cover.html.tpl" inline}
<div class="module mod-piclist" monkey="mod-piclist{$index}" id="mod_{$modData.parames.module_id}">
	{if $modData.parames.title}
	<div class="mod-head" >
		<h2 class="mod-title">{$modData.parames.title}</h2>
	</div>
	{/if}
	<div class="mod-body">
	{if ($smarty.now<$modData.parames.ud_end_time)&&($modData.parames.ud_type==0)}
		{button style="b" class="upload-photo-btn { 'ud_id':'{$modData.parames.upd_id}' }"  width=140 str = '上传我的作品' href = '#' isShadow = false}
	{/if}
		{if $modData.parames.sm_img}<img src="{$modData.parames.sm_img}" />{/if}
		{if $modData.parames.content}
		<div class="info">
			{$modData.parames.content nofilter}
			{if $modData.parames.btn_title}
			<p class="btn-wrap">
				{if $modData.parames.btn_target == 0}  {$tagAtt = "target='_blank'"} {/if}
				{button
				style="c"
				str = $modData.parames.btn_title
				tagAtt = $tagAtt
				href = $modData.parames.btn_link
				isShadow = false }
			</p>
			{/if}
		</div>
		{/if}
		{if $modData.parames._category}
		<div class="topic-tab">
			<div class="tab-nav">
			{foreach $modData.parames._category as $item}
				{if !$item.no_display}
				{button
				style="{if $item@first}p{else}o{/if}"
                class = "{if $item@first}btn-o{/if}"
				str = $item.title
				href = "#"}
				{/if}
			{/foreach}				
			</div>
			<div class='tab-body'>
			{foreach $modData.parames._category as $item}
				{if !$item.no_display}
				<div class="tab-item {if $item@first}on{/if} ">
					<div class="clearfix pic-content { 'type':'cooperate','code':'{$tplData.url}','data_type':'{$item.data_type}','ud_id':'{$modData.parames.upd_id}' ,'ud_type':'{$modData.parames.ud_type}','ud_only_ding':'{$modData.parames.ud_only_ding}' }">
					{if $modData.data[$item.code]}
						{foreach $modData.data[$item.code] as $content}
							{if  $content@index<$item.num}
								<dl>
								    {if $modData.parames.ud_type==1}
                                        <dt>{album_cover album=$content.subData}</dt>
                                        <dd ><a href="/album/{$content.subData.album_id}">《{$content.subData.title|pixel_truncate:120}》</a></dd>						              
								    {elseif $modData.parames.ud_type==2}
                                      <dt>
                                            <a href="{user_link user=$content.subData}" title="{$content.subData.nick}" class="img-link"><img class="avatar"  src="{avatar user=$content.subData type='big'}" width="150" height="150" alt="{$content.subData.nick}" /></a>
                                      </dt>
                                      <dd>{people_name people=$content.subData width=130}</dd>      								    
								    {else}
									<dt>
										<a href="{$content.ud_image_big}" class="item-img" title="{$content.ud_title}">

                                            {$pph = #PIC_PLACEHOLDER#}
											{if $item@first} 
												{$_src = "src='`$content.ud_image_mini`'"}
											{else} 
												{$_src = "class='topic-lazyload' org_src='`$content.ud_image_mini`' src='`$pph`'"}
											{/if}

											<img  {$_src nofilter} width=150 height=150 />
											<i class="bg"></i>
			                                <i class="zoom" title="查看大图"></i>
										</a>
									</dt>
									<dd class="title">{$content.ud_title|pixel_truncate:140}</dd>
									<dd>{people_name people=["ting_uid"=>{$content.ting_uid},"is_musicer"=>{$content.is_musicer},"nick"=>{$content.nick}] width=130}</dd>
									<dd>{$content.create_time|date_format:"%Y-%m-%d"}</dd>
									{/if}
									<dd>
									    <a href="#"  class="topic-up {if $modData.parames.ud_only_ding==1} topic-up-mini {/if} { 'sig':'{$content.sig}','ts':'{$content.click_end_time}','id':'{$content.id}','type':'up'}">{$content.up}</a>
									    {if $modData.parames.ud_only_ding==1}
									    <a href="#"  class="topic-down { 'sig':'{$content.sig}','ts':'{$content.click_end_time}','id':'{$content.id}','type':'down'}">{$content.down}</a>
									    {/if}
									</dd>
									{if $content.hlike}
									<dd class="hot-like"></dd>
									{/if}
								</dl>
							{/if}
						{/foreach}
					{/if}
					</div>
					{if $item.total&&$item.total>$item.num}
					<div>
					{page_navigator total=$item.total size=$item.num start=0 url="/data/topic/imagelist?start=#start#&size=#size#"}
					</div>
					{/if}				
				</div>
				{/if}
			{/foreach}					
			</div>
		</div>
		{/if}
	</div>
</div>
