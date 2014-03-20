{include file="widget/button/button.html.tpl" inline}
<div class="base-info no-film-pic clearfix" alog-alias="base-info">
    {*<div class="film-img">*}
        {*<img src="http://hiphotos.baidu.com/ting/pic/item/7af40ad162d9f2d3ca27999fa8ec8a136327cc88.jpg"/>*}
    {*</div>*}
    <div class="base-info-cont">
        <h2 class="name">{$tplData.film_info.entity_type}《{$tplData.film_info.name}》</h2>
        <div class="song-count">曲目：{count($tplData.song_list)} 首</div>
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
            {$ids = []}
            {foreach $tplData.song_list as $item}
                {$tempStr = array_push($ids, $item.song_id)}
            {/foreach}
            <span class="play-all" data-song='{json_encode(["moduleName" => "playFilm","ids" => $ids])}'>
                {button
                style = "a"
                str = "播放全部歌曲"
                icon = "play"
                }
            </span>
            <span class="add-all" data-song='{json_encode(["moduleName" => "addFilm","ids" => $ids])}'>
                {button
                style = "b"
                str = "添加"
                icon = "add"
                }
            </span>
        </div>
    </div>
</div>