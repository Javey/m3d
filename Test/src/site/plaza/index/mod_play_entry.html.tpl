<div class="module play-entry" alog-alias="play-entry" monkey="play-entry" style="display: none;"></div>


<script type="text/template" id="play-entry-user-tmpl">
<div class="item">
    <div class="pic">
        <img alt="<%- name %>" src="<%- avatar %>">
    </div>
    <div class="info">
        <% if (name) { %>
            <span class="name"><%- $.ting.subByte(name, 12, '..') %></span>
            <% if (vip) { %>
                <% if (vip.cloud.service_level == 'comm') { %>
                    <a class="vip vip-icon" href="http://music.baidu.com/home/vip">VIP</a>
                <% } else if (vip.cloud.service_level == 'gold') { %>
                    <a class="gold-vip vip-icon" href="http://music.baidu.com/home/vip">VIP</a>
                <% } %>
            <% } else { %>
                <a class="no-vip vip-icon" href="http://music.baidu.com/home/vip">非VIP</a>
            <% } %>
        <% } else { %>
            <p class="greeting"><%- greeting %></p>
            <p><a class="login" href="javascript:;">登录百度音乐</a></p>
        <% } %>
    </div>
</div>
<span class="arrow"></span>
</script>

<script type="text/template" id="play-entry-songs-tmpl">
  <div class="vip-privilege">
    <p class="vip-privilege-info">我的特权</p>
    <ul class="clearfix vip-privilege-icons">
      <li><a href="/vip/superstorage" target="_blank"><i title="高品质音乐下载" class="power-icon-min vip-icon-superstorage"></i></a> </li>
      <li><a href="/vip/batchdown" target="_blank"><i title="批量下载" class="power-icon-min vip-icon-batchdown"></i></a> </li>
      <li><a href="/vip/superplay" target="_blank"><i title="高品质音乐播放" class="power-icon-min vip-icon-superplay"></i></a> </li>
      <li><a href="/vip/playbackenhance" target="_blank"><i title="音效增强" class="power-icon-min vip-icon-playbackenhance"></i></a> </li>
      <li><a href="/vip/vipidentity" target="_blank"><i title="VIP会员身份标识" class="power-icon-min vip-icon-vipidentity"></i></a> </li>
      <li><a href="/vip/invite" target="_blank"><i title="邀请特权" class="power-icon-min vip-icon-invite"></i></a> </li>
      <li><a href="/vip/losslessdown" target="_blank"><i title="无损音乐下载" class="power-icon-min vip-icon-losslessdown"></i></a> </li>
      <li><a href="/vip/noad" target="_blank"><i title="音乐盒去广告" class="power-icon-min vip-icon-noad"></i></a> </li>
    </ul>
  </div>
  <div class="collect-info"></div>
<p class="status">
    最近听过
    <a class="more" href="javascript:;">播放全部<span>&gt;&gt;</span></a>
</p>
<% if (songs.length) { %>
    <ul class="songs">
<%
    }
    _.each(songs, function(song, i) {
%>
    <li class="js-play" <% if (i % 2 === 1) { print(' class="even"') } %> data-index="<%- i %>"><a title="<%- song.title %>" href="javascript:;">
        <span class="play"></span><%- $.ting.subByte(song.title, 26, '..') %>
    </a></li>
<%
    });
    if (songs.length) {
%>
    </ul>
<% } %>
</script>
