{extends file="topic/module/module.html.tpl"}
{block name='mod_class'}mod-vote{/block}
{block name='mod_attr'}monkey="mod-vote{$index}"{/block}
{block name="mod_body"}
{if $modData.parames.column_content}
<p class="clearfix">
    		{$modData.parames.column_content nofilter}
</p>
{/if}
<div>
  <p class="vote-desc">七月流火，暑期临近，两年前的那个夏天，一张《那些你们喜欢的不喜欢的我都喜欢的女孩》，拉近了我们跟这个个性十足的“摇滚小子”王啸</p>
  <div class="vote-body">
  <p class="vote-condition">最多限选3项</p>
  <dl class="vote-item">
    <dt class="vote-item-desc">月流火，暑期临近，两年前的那个夏天，一张《那些你们喜欢的不 喜欢的我都喜欢的女孩》，拉近了我们跟这个个性十足。</dt>
    <dd>
      <input class="vote-chk" type="checkbox"/>
      <span class="vote-num" id="voite_id">90828372票(20%)</span>
      <div class="vote-slider">
        <div class="slider-inner slider-type1"> <div class="slider-body"></div></div>
      </div>
    </dd>
  </dl>
  <dl class="vote-item">
    <dt class="vote-item-desc">月流火，暑期临近，两年前的那个夏天，一张《那些你们喜欢的不 喜欢的我都喜欢的女孩》，拉近了我们跟这个个性十足。</dt>
    <dd>
      <input class="vote-chk" type="checkbox"/>
      <span class="vote-num" id="voite_id">90828372票(20%)</span>
      <div class="vote-slider">
        <div class="slider-inner slider-type2"> <div class="slider-body"></div></div>
      </div>
    </dd>
  </dl>
  <dl class="vote-item">
    <dt class="vote-item-desc">月流火，暑期临近，两年前的那个夏天，一张《那些你们喜欢的不 喜欢的我都喜欢的女孩》，拉近了我们跟这个个性十足。</dt>
    <dd>
      <input class="vote-chk" type="checkbox"/>
      <span class="vote-num" id="voite_id">90828372票(20%)</span>
      <div class="vote-slider">
        <div class="slider-inner slider-type3"> <div class="slider-body"></div></div>
      </div>
    </dd>
  </dl>
  <dl class="vote-item">
    <dt class="vote-item-desc">月流火，暑期临近，两年前的那个夏天，一张《那些你们喜欢的不 喜欢的我都喜欢的女孩》，拉近了我们跟这个个性十足。</dt>
    <dd>
      <input class="vote-chk" type="checkbox"/>
      <span class="vote-num" id="voite_id">90828372票(20%)</span>
      <div class="vote-slider">
        <div class="slider-inner slider-type4"> <div class="slider-body"></div></div>
      </div>
    </dd>
  </dl>  
  <p class="vote-result">截止时间：2012-03-15 18:55   |   已有投票人数：198251 
      {button style="b" class="topic-vote-btn"  width=75 str = '投票' href = '#'}
  </p>    
</div>

</div>
{/block}