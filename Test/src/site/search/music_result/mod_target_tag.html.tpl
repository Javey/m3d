
{$targetTag = $tplData.heterobject.res_array}

<div id="target_banner" monkey="target-banner">
	<div class="target-tag clearfix" id="target_tag">
		<a href="/tag"><span  class="tag-nav">&nbsp;</span></a> <a class="title fs14p" href="/tag/{$tplData.query|escape:url nofilter}">{$tplData.query}</a> 
		 <span class="total">共<span class="nums">{$tplData.nums.tag}</span>首歌</span> 
		 {button
			 str="收听该分类电台"
			 style="b"
			 href="{$tplData.param.fm_host}/#/channel/public_tag_{$tplData.query|escape:url }"
			 tagAtt ="target='_blank' "
			 class="radio"
			 icon="fm"
			 isRightIcon = true
		}
	</div>
	<div class="module-line module-line-bottom"></div>
</div>
