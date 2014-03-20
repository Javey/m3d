{include file="widget/tree_navigator_top/tree_navigator.html.tpl" inline}
{tree_navigator_top selected=$artistSelected treeData=[
	[
		"title"=> "全部歌手",
		"href"=>"/artist",
		"type"=>"all-all"
	],
	[
		"title" => "华语",
		"subTree"=>[
			
			[
				"title"=>"华语男歌手",
				"href"=>"/artist/cn/male",
				"type"=>"cn-male"
			],
			[
				"title"=>"华语女歌手",
				"href"=>"/artist/cn/female",
				"type"=>"cn-female"
			],
			[
				"title"=>"华语乐队组合",
				"href"=>"/artist/cn/group",
				"type"=>"cn-group"
			]
		]
	],
	[
		"title" => "欧美",
		"subTree"=>[
			
			[
				"title"=>"欧美男歌手",
				"href"=>"/artist/western/male",
				"type"=>"western-male"
			],
			[
				"title"=>"欧美女歌手",
				"href"=>"/artist/western/female",
				"type"=>"western-female"
			],
			[
				"title"=>"欧美乐队组合",
				"href"=>"/artist/western/group",
				"type"=>"western-group"
			]
		]
	],
	[
		"title" => "日韩",
		"subTree"=>[
			
			[
				"title"=>"日韩男歌手",
				"href"=>"/artist/jpkr/male",
				"type"=>"jpkr-male"
			],
			[
				"title"=>"日韩女歌手",
				"href"=>"/artist/jpkr/female",
				"type"=>"jpkr-female"
			],
			[
				"title"=>"日韩乐队组合",
				"href"=>"/artist/jpkr/group",
				"type"=>"jpkr-group"
			]
		]
	],
	[
		"subTree"=>[
			[
				"title"=>"其他歌手",
				"href"=>"/artist/other",
				"type"=>"other-other"
			]
		]
	],
  [
    "subTree"=>[
      [
        "title"=>"百度原创音乐人",
        "href"=>"/musician",
        "new"=>true,
        "type"=>"baidu-musician"
      ]
    ]
  ]
]}