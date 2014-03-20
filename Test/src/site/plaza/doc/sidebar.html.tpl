{include file="widget/tree_navigator_top/tree_navigator.html.tpl" inline}

{$type = explode("/", $smarty.server.REQUEST_URI)}
{$type = $type[2]}

{tree_navigator_top selected=$type treeData=[
	[
		"subTree"=>[
			[
				"title" => "关于百度音乐",
				"href" => "/doc/about",
				"type" => "about"
			],
			[
				"title"=>"意见反馈",
				"href"=>"/doc/feedback",
				"type"=>"feedback"
			],
			[
				"title"=>"联系我们",
				"href"=>"/doc/contact",
				"type"=>"contact"
			],
			[
				"title"=>"帮助中心",
				"href"=>"/doc/help",
				"type"=>"help"
			],
			[
				"title" => "服务协议",
				"href" => "/doc/agreement",
				"type" => "agreement"
			],
			[
				"title" => "权利声明",
				"href" => "/doc/statement",
				"type" => "statement"
			]
		]
	]
]}