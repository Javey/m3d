<div class="vip-privilege-block vip-privilege-all">
	<div class="module-a-title">
		<h2 class="title"><i class="icon"></i>所有特权</h2>
	</div>

	<div class="vip-table">
		{foreach key=i item=row from=$privileges_all_table.rows}
		<div class="vip-table-row {if $row@first}vip-table-row-first{/if} {if $row@last}vip-table-row-last{/if} vip-table-row-{if $i%2==1}odd{else}even{/if} vip-table-row{if $row@last}-last{/if}-{if $i%2==1}odd{else}even{/if}">
			{foreach $row as $cell}

			{if !$row@first && $cell['type'] != ""}
				{$htmlTag = "a"}
			{else}
				{$htmlTag = "div"}
			{/if}
			<{$htmlTag} class="vip-table-cell {if $cell['type'] != ""}vip-table-cell-a{/if} {if $cell@first}vip-table-cell-first{/if} {if $cell@last}vip-table-cell-last{/if}" href="/vip/{$cell['type']}">
				{if $cell['type']}
					<span class="icon vip-icon vip-icon-{$cell['type']}"></span>
					{if $row@first}
						{$cell['text']}
					{else}
						<span class="label">{$cell['text']}</span>
					{/if}
				{else}
					{$cell['text']}
				{/if}
			</{$htmlTag}>
			{/foreach}
		</div>
		{/foreach}
	</div>
</div>