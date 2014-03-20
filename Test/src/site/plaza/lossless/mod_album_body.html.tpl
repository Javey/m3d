{include file="widget/album_cover/album_cover.html.tpl" inline}
{include file="widget/author_list/author_list.html.tpl" inline}
{include file="widget/song_list/song_list.html.tpl" inline}
{include file="widget/page_navigator/page_navigator.html.tpl" inline}
{$row = 4}
<ul class="albumlist clearfix">
    {foreach $tplData.albumList.list as $item}
        {if $item@index % $row === 0 && !$item@first}
            </ul>
            <ul class="albumlist clearfix">
        {/if}
        <li class="album-item">
            {album_cover
                moduleName = "newAlbum"
                album = $item
                showStatus = true
                type = 'large'
                showBorder = false
            }
            <div class="album-name">
                <a title="{$item.title}" href="/album/{$item.album_id}">
                    <span>{$item.title|pixel_truncate:83 nofilter}</span>
                </a>
            </div>
            <div class="singer-name">
                {author_list source='album' releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid  names=$item.author width=75}
            </div>
        </li>
    {foreachelse}
        <div class="no-data">暂无数据</div>
    {/foreach}
    <li class="album-songs">
        <div class="arrow-wrapper">
            <div class="arrow-up"></div>
        </div>
        <div class="info-wrapper">
            <div class="img-bg-wrapper">
                <img class="img-bg" />
                <div class="img-mask"></div>
            </div>
            <div class="head clearfix">
                <div class="album-info"></div>
                <div class="tip">因格式问题歌曲播放不支持无损格式播放</div>
            </div>
            <div class="album-songlist"></div>
        </div>
    </li>
</ul>

{if !empty($tplData.albumList.list)}
    {page_navigator total={$tplData.albumList.nums} size=16 start={$tplData.param.page} url="/lossless/`$view`/`$urlType`/`$order`/#start#"}
{/if}