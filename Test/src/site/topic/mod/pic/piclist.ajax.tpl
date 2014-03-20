{extends file="ajax.tpl"}
{block name="ajax_html"}
{include file="widget/user_link/user_link.html.tpl" inline}  
{include file="widget/alias/alias.html.tpl" inline}
{include file="widget/people_name/people_name.html.tpl" inline}
{include file="widget/song_link/song_link.html.tpl" inline}
{include file="widget/author_list/author_list.html.tpl" inline}
{include file="widget/people_icon/people_icon.html.tpl" inline}
{include file="widget/avatar/avatar.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{include file="widget/album_cover/album_cover.html.tpl" inline}
    {foreach $tplData.updData.data as $content}
            <dl>
                {if $tplData.updData.ud_type==1}
                    <dt>{album_cover album=$content.subData lazyload=false}</dt>
                    <dd ><a href="/album/{$content.subData.album_id}">《{$content.subData.title|pixel_truncate:120}》</a></dd>                                      
                {elseif $tplData.updData.ud_type==2}
                  <dt>
                        <a href="{user_link user=$content.subData}" title="{$content.subData.nick}" class="img-link"><img class="avatar"  src="{avatar user=$content.subData type='big'}" width="150" height="150" alt="{$content.subData.nick}" /></a>
                  </dt>
                  <dd>{people_name people=$content.subData width=130}</dd>                                          
                {else}
                <dt>
                    <a href="{$content.ud_image_big}" class="item-img" title="{$content.ud_title}">
                        <img src="{$content.ud_image_mini}" width=150 height=150 />
                        <i class="bg"></i>
                        <i class="zoom" title="查看大图"></i>
                    </a>
                </dt>
                <dd class="title">{$content.ud_title|pixel_truncate:140}</dd>
                <dd>{people_name people=["ting_uid"=>{$content.ting_uid},"is_musicer"=>{$content.is_musicer},"nick"=>{$content.nick}] width=130}</dd>
                <dd>{$content.create_time|date_format:"%Y-%m-%d"}</dd>
                {/if}
                <dd>
                    <a href="#"  class="topic-up {if $tplData.updData.ud_only_ding==1} topic-up-mini {/if} { 'sig':'{$content.sig}','ts':'{$content.click_end_time}','id':'{$content.id}','type':'up'}">{$content.up}</a>
                    {if $tplData.updData.ud_only_ding==1}
                    <a href="#"  class="topic-down { 'sig':'{$content.sig}','ts':'{$content.click_end_time}','id':'{$content.id}','type':'down'}">{$content.down}</a>
                    {/if}
                </dd>
                {if $content.hlike}
                <dd class="hot-like"></dd>
                {/if}
            </dl>
    {/foreach}  
{/block}

{block name="ajax_js"}
    $(".item-img",this).lightBox();
    $(".topic-up,.topic-down",this).tip();
    $(".topic-up,.topic-down",this).bind('click',function(){
        var _this=this,
             post=$.metadata.get(_this)||{ };
        ting.connect.topicUpd(null,post,function(result){
            var val=parseInt($(_this).text());
            $(_this).html(++val);       
            $(_this).tip("tipup",{ msg:"投票成功！",iconClass:"tip-success" });
        },function(result){
            $(_this).tip("tipup",{ msg:ting.errorMap[result.errorCode]||"投票失败!",iconClass:"tip-error" });   
        })
        return false;
    })
    $(".album-cover-hook",this).albumCover();
{/block}