{include file="widget/button/button.html.tpl" inline}
<div class="base-info no-film-pic clearfix" alog-alias="base-info">
    <div class="film-img">
        <img width=113 height=150 src="{$tplData.film_info.thumbnail|default:#FILM_COVER_DEFAULT#}"/>
    </div>
    <div class="base-info-cont">


        <div class="opera">
            <div class="share clearfix">
                <span class="share-label">分享到： </span>
                <div id="bdshare" class="bds_tools bdshare_t">
                    <a class="bds_qzone"></a>
                    <a class="bds_renren"></a>
                    <a class="bds_tqq"></a>
                    <a class="bds_tsina"></a>
                    <span class="bds_more"></span>
                </div>
            </div>
        <h2 class="name">{$tplData.film_info.type}《{$tplData.film_info.title}》{$tplData.film_info.versions}{$tplData.film_info.session}</h2>
        <div class="desc">
            <span class="description">{$tplData.film_info.info|utf8_truncate:400|replace:"\n":'<br />' nofilter}</span>
            {if strlen($tplData.film_info.info)>400}
                <span class="description-all">{$tplData.film_info.info|replace:"\n":'<br />'}</span>
                <a class="des-more-hook" href="#">展开</a>
            {/if}  
        </div>
        </div>

    </div>
</div>