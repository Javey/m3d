{foreach $privileges_compare_table as $privilegeTable}
<div class="vip-table">
    <div class="vip-table-header">
        <div class="vip-table-row-first" >
            <div class="vip-table-cell vip-table-cell-w958 vip-table-cell-alignleft vip-table-cell-first vip-table-cell-first-pad" >{$privilegeTable.title}</div>
        </div>
    </div>
    
    {foreach key=i item=row from=$privilegeTable.rows}
    <div class="vip-table-row {if $row@last}vip-table-row-last{/if} vip-table-row-{if $i%2==1}even{else}odd{/if} vip-table-row{if $row@last}-last{/if}-{if $i%2==1}even{else}odd{/if}">
        {foreach $row as $cell}
        <div class="vip-table-cell {if $cell@first}vip-table-cell-first vip-table-cell-first-pad{/if} {if $cell@last}vip-table-cell-last{/if}">
            {if $cell['type']}
                <span class="icon vip-icon vip-icon-{$cell['type']}"></span>
                <a class="label" href="/vip/{$cell['type']}">{$cell['text']}</a>
            {else}
                {if $cell['text'] == "tick"}
                    <span class="vip-icon vip-icon-tick"></span>
                {else if $cell['text'] == "cross"}
                    <span class="vip-icon vip-icon-cross"></span>
                {else}
                    {$cell['text']}
                {/if}
            {/if}
        </div>
        {/foreach}
    </div>
    {/foreach}
</div>
{/foreach}