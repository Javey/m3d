{** 第三方资源 **}
{$downloadInfo = $tplData.data.song}
{$authors = explode(',', $downloadInfo.author)}
<div class="song">
    <div class="logo-grey">
        <a target="_blank" href="/">百度音乐</a>
    </div><span class="label c9">歌曲：</span>
    <span class="fwb">{$downloadInfo.title nofilter}</span>{if $downloadInfo.author}&nbsp;&nbsp;<span class="c6">-</span>&nbsp;&nbsp;{author_list target="_blank" releaseStatus=$downloadInfo.relate_status ids=$downloadInfo.artist_id names=$downloadInfo.author}{/if}
</div>

<div class="download-wrapper">
    {if count($downloadInfo.fileData) > 0}
    <div class="main-links clearfix">
        <span class="label c9">推荐链接：</span>
        <ul>
            <li>
            {$otherCount = 0}
            {foreach $downloadInfo.fileData as $key => $val}
                {if $otherCount == 0}
                    {$recommendSong = $val}
                    {$thirdPartySongLink = $val.songLink}
                    <a class="fwb" href="{$val.songLink}">
                    {short_link link=$val.songShowLink}</a>
                {/if}
                {$otherCount = $otherCount + 1}
            {/foreach}
            </li>
        </ul>
    </div>
    {else}
    <div class="main-links clearfix">
        <span class="c9">来源链接：</span> <span class="c6">暂无</span>
    </div>
    {/if}
    {if count($downloadInfo.fileData) > 1}
    <div class="other-links clearfix">
        <span class="label c9">其它链接：</span>
        <ul>
            {$otherCount = 0}
            {foreach $downloadInfo.fileData as $key => $val}
                {if $otherCount != 0 && $otherCount < 5}
                    <li>
                        <a href="{$val.songLink}">
                            {short_link link=$val.songShowLink}</a>
                    </li>
                {/if}
                {$otherCount = $otherCount + 1}
            {/foreach}
        </ul>
    </div>
    {/if}
    {if count($downloadInfo.fileData) > 0}
        {$downloadLink = $thirdPartySongLink}
        {$data = [
            'artistName' => $downloadInfo.author,
            'songName' => '',
            'songLink' => $downloadLink,
            'format' => $recommendSong.format,
            'size' => $recommendSong.size,
            'appendix' => $downloadInfo.title
        ]}
        <div class="operation clearfix operation-notcopy">
            {button
                style = 'h'
                class = 'actived download btn-download'
                data = ['ids'=>$downloadInfo.song_id,'type'=>"song"]
                str = '下载'
                icon = 'download-small'
                href = $downloadLink
            }
            {button
                style = 'i'
                id = 'telDownloadBtn'
                class = 'actived btn-download'
                str = '下载到手机'
                href = '/app'
                tagAtt = 'target="_blank"'
            }
            {button
                style = 'i'
                id = 'pcDownloadBtn'
                class = 'actived btn-download'
                str ='用PC版高速下载'
                href = '#'
                data = $data
                tagAtt = 'target="_blank"'
            }
        </div>
    {/if}
</div>
