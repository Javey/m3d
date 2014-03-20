{extends file="sns/sns.html.tpl"}

{block name="assign" append}
    {foreach $tplData.data as $data}
        {$songInfo = $data.songInfo}
        {$mvInfo = $data.mvInfo}
        {break}
    {/foreach}
    {$mvList = $tplData.data.recommend}
    {$curInfo = array_merge($songInfo, $mvInfo)}
    {array_unshift($mvList, $curInfo)}
    {$mvList = array_slice($mvList, 0, 12)}
    {$sourceMap = [
        '12' => ['yinyuetai', '音悦台'],
        '11' => ['iqiyi', '爱奇艺']
    ]}
    {$mvSource = $sourceMap[$mvInfo.provider][0]|default:'iqiyi'}
{/block}

{block name='keywords'}"{$songInfo.title},{$songInfo.author},mv,百度音乐,mp3免费下载,高品质音乐下载"{/block}
{block name='description'}"百度音乐为你提供{$songInfo.author}单曲{$songInfo.title}MV观看,{$songInfo.title}MP3免费下载,{$songInfo.title}高品质音乐享受。"{/block}

{block name="title"}
    {$songInfo.title|default:'MV'}-{$songInfo.author},{$songInfo.title}MV,{$songInfo.title}高品质音乐下载
{/block}

{block name="css" append}
    <link rel="stylesheet" type="text/css" href="/static/css/mv_page.css" />
{/block}

{block name="js" append}
    <script type="text/javascript" src="/static/js/mv_page.js"></script>
    <script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=10004" ></script>
    <script type="text/javascript" id="bdshell_js"></script>
    <script type="text/javascript">
        var bds_config = { 'bdText':'推荐{$songInfo.author}的MV《{$songInfo.title}》 （分享自@百度音乐）'};
        document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)

        //创建播放器
        $(function () {
            var data = [];
            {foreach $mvList as $data}
                {$mvData = [
                    'songId' => $data.song_id,
                    'title' => $data.title,
                    'albumId' => $data.album_id,
                    'albumTitle' => $data.album_title,
                    'author' => $data.author,
                    'authorId' => $data.all_artist_ting_uid,
                    'time' => $data.file_duration,
                    'publishTime' => $data.showtime,
                    'tvid' => $data.tvid,
                    'vid' => $data.player_param,
                    'resourceType' => $data.resource_type,
                    'relateStatus' => $data.relate_status,
                    'delStatus' => $data.del_status,
                    'source' => {$mvSource},
                    'area' => {$songInfo.area},
                    'mvid' => {$data.mv_id}
                ]}
                data.push({json_encode($mvData) nofilter});
            {/foreach}

            // mvType到初始化widget的映射
            var widget = {
                iqiyi: {
                    name: 'mv',
                    options: {
                        height: '520px'
                    }
                },
                yinyuetai: {
                    name: 'mvYinyuetai',
                    options: {
                        height: '410px'
                    }
                }
            };
            var defaultOptions = {
                width: '100%',
                height: '100%',
                chainDataElem: $('.other-mv').find('li'),
                data: data
            };

            $('.player-container')[widget["{$mvSource}"].name]($.extend(defaultOptions, widget["{$mvSource}"].options));
        });

        // createClickMonkey("ting-music-mv");
    </script>
{/block}

{block name='js-monkey-pageid'}ting-music-{$mvSource}-mv{/block}

{block name="body_class_name"}mv {$mvSource}-mv{/block}

{block name="sns_body"}
	{include file="widget/mv_cover/mv_cover.html.tpl" inline}
    {*格式化时间，将秒数转为“:”分割的时间*}
    {function name=formatTime time=0}
        {$minute = floor($time / 60)}
        {if $minute < 10}
            {$minute = '0'|cat:$minute}
        {/if}
        {$second = $time % 60}
        {if $second < 10}
            {$second = '0'|cat:$second}
        {/if}
        {*直接输出变量会输出多余空格，故把li标签放进来*}
        <li>时长：{$minute}:{$second}</li>
    {/function}

    <h1 class="music-seo">
        <strong>{$songInfo.author}</strong>单曲<strong>{$songInfo.title}</strong>MV观看,<strong>{$songInfo.title}</strong>MP3免费下载,<strong>{$songInfo.title}</strong>高品质音乐下载。
    </h1>

    <div class="mv-container" monkey="mv-container" alog-alias="mv-container">
        {if !empty($songInfo)}
            {if $songInfo.song_id}
                <a href="http://qianqian.baidu.com/download/BaiduMusic-12345621.exe" target="_blank" id="add_to_player" class="mv-add-song">使用百度音乐PC版专享高速MV播放</a>
            {/if}
            <h1 id="mv_title">[MV]{$songInfo.author}-{$songInfo.title}</h1>
        {/if}
        <div class="player-container-wrapper">
            <div class="player-container"></div>
            {if $mvSource == 'yinyuetai'}
                <div class="yinyuetai-recommend-mv" alog-alias="yinyuetai-recommend-mv">
                    <h1>音悦台推荐</h1>
                    <div id="yinyuetai_scroll">
                        <div class="scrollbar">
                            <div class="track">
                                <div class="thumb">
                                    <div class="end"></div>
                                </div>
                            </div>
                        </div>
                        <div class="viewport loading">
                            <ul class="yinyuetai-list overview" id="yinyuetai_list"></ul>
                            <script type="text/template" id="yinyuetai_list_template">
                                <% _.each(data, function(value) { %>
                                <li>
                                    <a class="yinyuetai-item" href="<%- value.playUrl %>" target="_blank" title="<%- value.title %> - <%- value.artists %>">
                                        <span class="yinyuetai-item-img">
                                            <img src="<%- value.picture1 %>" alt="<%- value.title %>">
                                            <span class="play-icon-big"></span>
                                        </span>
                                        <span class="yinyuetai-item-info">
                                            <span class="song-title"><%- value.title %></span>
                                            <span class="singer-name"><%- value.artists %></span>
                                        </span>
                                    </a>
                                </li>
                                <% }) %>
                            </script>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </div>
	<div class="mv-extra" monkey="mv-extra"  alog-alias="mv-extra">
        {if !empty($songInfo)}
            <div class="song-info" alog-alias="song-info">
                <h3 class="mv-extra-title">MV信息</h3>
                <div class="mv-source c6">来自：<span>{$sourceMap[$mvInfo.provider][1]|default:'爱奇艺'}</span></div>
                <ul class="c6 info-item clearfix" id="info">
                    {song_link_url_plugin song=$songInfo linkWithNoSongId="#" songLinkUrl=theSongLink}
                    <li>歌曲：<a href="{if $songInfo.song_id}{$theSongLink}{else}/search?key={$songInfo.title|escape:'url'}" title="{$songInfo.title}{/if}" target="_blank">{$songInfo.title}</a></li>
                    <li>歌手：{author_list target ="blank"  releaseStatus=$songInfo.relate_status ids=$songInfo.all_artist_ting_uid names=$songInfo.author width = 100}</li>
                    {*<li>专辑：{if $songInfo.relate_status == 0 || $songInfo.relate_status == 2}<a target="_blank" href="/album/{$songInfo.album_id}">《{$songInfo.album_title|pixel_truncate:400}》</a>{else}<a target="_blank" href="/search?key={$songInfo.album_title|escape:'url'}+{$songInfo.author|escape:'url'}">《{$songInfo.album_title|pixel_truncate:400}》{/if}</a></li>*}
                    {formatTime time=$mvInfo.file_duration}
                    <li>发行时间：{$mvInfo.showtime}</li>
                </ul>
                <div class="song-page-share clearfix">
                    <div class="share-label">分享到： </div>
                    <div id="bdshare" class="bdshare_t bds_tools get-codes-bdshare">
                        <a class="bds_qzone"></a>
                        <a class="bds_renren"></a>
                        <a class="bds_tqq"></a>
                        <a class="bds_tsina"></a>
                        <span class="bds_more"></span>
                    {*<a class="shareCount"></a>*}
                    </div>
                </div>
            </div>
        {/if}
		<div class="other-mv-wrapper" alog-alias="other-mv">
            <h3 class="mv-extra-title">连播列表</h3>
			{** <a class="other-mv-left left-disable" href="#"></a> **}
			<div class="other-mv-inner-wrapper">
                <div class="other-mv-inner">
                    <ul class="other-mv clearfix">
                        {foreach $mvList as $item}
                        <li>
                            {mv_cover data=$item showMvData=true showPlayIcon=false showMVIcon=false}
                            <div class="song-item">
								<span class="song-title">
									{song_link_url_plugin song=$item linkWithNoSongId="#" songLinkUrl=theSongLink}
                                    <a href="{$theSongLink}">{$item.title|pixel_truncate:140:'tahoma_14' nofilter}</a>
								</span>
								<span class="siger-name">
									歌手：{author_list releaseStatus=$item.relate_status ids=$item.all_artist_ting_uid  names=$item.author width=80}
								</span>
                            </div>
                        </li>
                        {/foreach}
                    </ul>
                </div>
			</div>
			{**
			{if $tplData.data.recommend|@count <= $page}
				{$rightClass = "right-disable"}
			{/if}
			<a class="other-mv-right {$rightClass}" href="#"></a>
			 **}
		</div>
	</div>
    {include file="sns/mv/mod_noflash_dialog.html.tpl" inline}
{/block}
