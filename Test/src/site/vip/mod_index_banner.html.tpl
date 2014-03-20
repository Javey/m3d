<div class="vip-focus">
    <div class="vip-focus-bg"></div>
    <div class="vip-focus-bottom"></div>
    <div class="vip-focus-mid">
        <div class="vip-ads">
            {*<a href="/home/vip/invite?pst=invite_vip"><img src="/static/images/vip/vip_ads.jpg" alt="" /></a>*}
            {$focusPic = []}
            
            {foreach $tplData.data.main_focus as $item}
                {$focusItem = [
                    'randpic' => $item.pic,
                    'randpic_link' => $item.link
                ]}

                {append var='focusPic' value=$focusItem}
            {/foreach}

            {include file="widget/focus/focus.html.tpl"}
            {anyfocus data =$focusPic width=980 height=350 isPage = true target = true}
        </div>

        <div class="vip-user-wrapper">
            {include file="vip/mod_userinfo.html.tpl"}
        </div>
    </div>
</div>
