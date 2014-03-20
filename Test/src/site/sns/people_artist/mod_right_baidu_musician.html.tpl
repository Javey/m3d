{extends file="module/module.html.tpl"}
{block name='mod_class'}mod-bd-musician{/block}
{block name='mod_attr'}monkey="mod-bd-musician"{/block}
{block name="mod_head"}
  <span class="more"><a target="_blank" href="//y.baidu.com?pst=gs">更多<span>&gt;&gt;</span></a> </span>
  <h2 class="title">推荐音乐人</h2>
{/block}
{block name="mod_body"}
  {*{$recommend_baidu_musician = [*}
    {*[*}
      {*"thumbnail"=> "/static/images/musician/liuruiqi.jpg",*}
      {*"name"=>"刘瑞琦",*}
      {*"link"=>"//y.baidu.com/liuruiqi"*}
    {*],*}
    {*[*}
      {*"thumbnail"=>"/static/images/musician/songdongye.jpg",*}
      {*"name"=>"宋冬野",*}
      {*"link"=>"//y.baidu.com/artist/100027"*}
    {*],*}
    {*[*}
      {*"thumbnail"=>"/static/images/musician/longjinshuochang.jpg",*}
      {*"name"=>"龙井说唱",*}
      {*"link"=>"//y.baidu.com/artist/100441"*}
    {*]*}
  {*]*}
  {*}*}

  <ul class="clearfix recommend-bd-musician">
    {foreach $tplData.artist_info.rec_musician as $item}
      {if $item@index < 3}
        <li>
          <div class="people-icon cover-img">
            <a target="_blank" href="//y.baidu.com/artist/{$item.artist_id}?pst=gs" class="img-link cover">
              <img class="avatar lazyload" org_src="{$item.avatar}" width="60" height="60" alt="{$item.name}"/>
            </a>
          </div>
          <h4>
            <a target="_blank" href="//y.baidu.com/artist/{$item.artist_id}?pst=gs" title="{$item.name}">{$item.name|pixel_truncate:60}</a>
          </h4>
        </li>
      {/if}
    {/foreach}
  </ul>
{/block}