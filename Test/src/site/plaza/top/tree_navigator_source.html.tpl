{$tree=[
    [
        "type"  => "index",
        "title" => "全部榜单",
        "href"  => "/top"
    ],
    [
        "title"   => "主打榜单",
        "subTree" => [
            [
                "type"  => "dayhot",
                "title" => "热歌榜 <span>TOP500</span>",
                "href"  => "/top/dayhot"
            ],
            [
                "type"  => "new",
                "title" => "新歌榜 <span>TOP100</span>",
                "href"  => "/top/new",
                "noline" => true
            ], 
            [
                "type"  => "artist",
                "title" => "歌手榜 <span>TOP200</span>",
                "href"  => "/top/artist"
            ]
        ]
    ],
    [
        "title"   => "分类榜单",
        "subTree" => [
            [
                "type"  => "chinavoice2013",
                "title" => "中国好声音榜",
                "href"  => "/top/chinavoice2013"
            ],        
            [
                "type"  => "oumei",
                "title" => "欧美金曲榜",
                "href"  => "/top/oumei"
            ],
            [
                "type"  => "yingshijinqu",
                "title" => "影视金曲榜",
                "href"  => "/top/yingshijinqu",
                "noline" => true
            ],
            [
                "type"  => "lovesong",
                "title" => "情歌对唱榜",
                "href"  => "/top/lovesong"

            ],
            [
                "type"  => "netsong",
                "title" => "网络歌曲榜",
                "href"  => "/top/netsong"
            ],
            [
                "type"  => "oldsong",
                "title" => "经典老歌榜",
                "href"  => "/top/oldsong",
                "noline" => true
                
            ],
            [
                "type"  => "rock",
                "title" => "摇滚榜",
                "href"  => "/top/rock",
                "noline" => true
            ]
        ]
    ],
    [
        "title"   => "媒体榜单",
        "subTree" => [
            [
                "type"  => "ktv",
                "title" => "KTV热歌榜",
                "href"  => "/top/ktv"
            ],
            [
                "type"  => "billboard",
                "title" => "Billboard",
                "href"  => "/top/billboard"
            ],
            [
                "type"  => "ukchart",
                "title" => "UK Chart",
                "href"  => "/top/ukchart",
                "noline" => true
            ],
            [
                "type"  => "hito",
                "title" => "Hito中文榜",
                "href"  => "/top/hito"
            ],
            [
                "type"  => "chizha",
                "title" => "叱咤歌曲榜",
                "href"  => "/top/chizha"
            ],
            [
                "type"  => "mnet",
                "title" => "韩国Mnet",
                "href"  => "/top/mnet"
            ],
            [
                "type"  => "oricon",
                "title" => "日本公信榜",
                "href"  => "/top/oricon"
            ]            
        ]
    ]    
] scope="parent"}

