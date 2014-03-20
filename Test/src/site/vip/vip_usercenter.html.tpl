{extends file="vip/vip.html.tpl"}

{block name="head" append}
{include file="vip/power_list_config.html.tpl" inline}
{/block}

{block name="body_class"}
class="vip-page vip-uc"
{/block}

{block name="title"}用户中心{/block}
{block name="assign" append}
    {$navIndex = "usercenter"}
{/block}

{block name="content_main"}
    <div class="main-body">
        <div class="vip-power-list">
            <div class="vip-uc-header">
                <div class="module-a-title">
                    <h3 class="title"><i class="icon"></i>个人信息</h3>
                </div>

                <div class="vip-user-wrapper">
                    {include file="vip/mod_userinfo.html.tpl"}
                </div>

                <div class="vip-uc-banner">
                    <a href="{$tplData['data']['pic_info']['link']}" >
                        <img src="{$tplData['data']['pic_info']['pic']}" />
                    </a>
                </div>
            </div>

            <div class="vip-privilege-block">
                <div class="module-a-title">
                    <h3 class="title"><i class="icon"></i>订单记录</h2>
                </div>
                <div class="vip-table">
                    <div class="vip-table-header vip-table-row-first">
                        <div class="vip-table-cell vip-table-cell-w340 vip-table-cell-aligncenter vip-table-cell-first">时间</div>
                        <div class="vip-table-cell vip-table-cell-w630 vip-table-cell-aligncenter vip-table-cell-last">内容</div>
                    </div>

                    {if $loginInfo}
                        {if count($tplData['data']['order_history']) > 0}
                            {foreach key=i item=row from=$tplData['data']['order_history']}
                            <div class="vip-table-row {if $row@last}vip-table-row-last{/if} vip-table-row-{if $i%2==1}even{else}odd{/if} vip-table-row{if $row@last}-last{/if}-{if $i%2==1}even{else}odd{/if}">
                                <div class="vip-table-cell vip-table-cell-first vip-table-cell-w340 vip-table-cell-aligncenter">
                                    {$row['update_time']}
                                </div>
                                <div class="vip-table-cell vip-table-cell-last vip-table-cell-w630 vip-table-cell-aligncenter">
                                    {$row['msg']}
                                </div>
                            </div>
                            {/foreach}
                        {else}
                            <div class="vip-table-row vip-table-row-last-odd vip-table-row-odd vip-table-row-last">
                                <div class="vip-table-cell vip-table-cell-w980" >暂无记录</div>
                            </div>
                        {/if}
                    {else}
                        <div class="vip-table-row vip-table-row-last-odd vip-table-row-odd vip-table-row-last">
                            <div class="vip-table-cell vip-table-cell-w980" >请先<a class="blue login-btn">登入</a></div>
                        </div>
                    {/if}
                </div>
            </div>

            <div class="vip-privilege-block">
                <div class="module-a-title">
                    <h3 class="title"><i class="icon"></i>我的优惠券</h2>
                </div>

                <div class="vip-table">
                    <div class="vip-table-header vip-table-row-first">
                        <div class="vip-table-cell vip-table-cell-w225 vip-table-cell-aligncenter vip-table-cell-first">优惠券号</div>
                        <div class="vip-table-cell vip-table-cell-w295 vip-table-cell-aligncenter">内容</div>
                        <div class="vip-table-cell vip-table-cell-w225 vip-table-cell-aligncenter">到期时间</div>
                        <div class="vip-table-cell vip-table-cell-w225 vip-table-cell-aligncenter vip-table-cell-last">状态</div>
                    </div>
                    
                    {if $loginInfo}
                        {if count($tplData['data']['code_info']) > 0}
                            {foreach key=i item=row from=$tplData['data']['code_info']}
                            <div class="vip-table-row {if $row@last}vip-table-row-last{/if} vip-table-row-{if $i%2==1}even{else}odd{/if} vip-table-row{if $row@last}-last{/if}-{if $i%2==1}even{else}odd{/if}">
                                <div class="vip-table-cell vip-table-cell-first vip-table-cell-w225 vip-table-cell-aligncenter">
                                    {$row['code']}
                                </div>
                                <div class="vip-table-cell vip-table-cell vip-table-cell-w295 vip-table-cell-aligncenter">
                                    {$row['from']}
                                </div>
                                <div class="vip-table-cell vip-table-cell vip-table-cell-w225 vip-table-cell-aligncenter">
                                    {$row['expiration']}
                                </div>
                                <div class="vip-table-cell vip-table-cell-last vip-table-cell-w225 vip-table-cell-aligncenter">
                                    {if $row['status'] == 0}
                                    未使用 (<a class="blue" href="/duihuan?code={$row['code']}" target="_blank">使用</a>)
                                    {else}
                                    已使用
                                    {/if}
                                </div>
                            </div>
                            {/foreach}
                        {else}
                            <div class="vip-table-row vip-table-row-last-odd vip-table-row-odd vip-table-row-last">
                                <div class="vip-table-cell vip-table-cell-w980" >暂无记录, <a href="/vip/invite" class="blue" target="_blank">邀请好友免费领续期</a></div>
                            </div>
                        {/if}
                    {else}
                        <div class="vip-table-row vip-table-row-last-odd vip-table-row-odd vip-table-row-last">
                            <div class="vip-table-cell vip-table-cell-w980" >请先<a class="blue login-btn">登入</a></div>
                        </div>
                    {/if}
                </div>
            </div>

            <div class="vip-privilege-block">
                <div class="module-a-title">
                    <h2 class="title"><i class="icon"></i>我的特权</h2>
                </div>

                {include file="vip/mod_privileges.html.tpl"}
            </div>
        </div>
    </div>
{/block}


{block name='js-monkey-pageid'}ting-music-vip-usercenter{/block}
