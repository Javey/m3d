{$offlineParties = [
    [
        "img" => "/static/images/vip/offline/image004.png"
        , "link" => "http://music.baidu.com/topic/cooperation/cocofbh"
        , "name" => "李玟《盛开》北京发布会"
    ],

    [
        "img" => "/static/images/vip/offline/image001.png"
        , "link" => "http://music.baidu.com/topic/show/intro"
        , "name" => "INTRO音乐节"
    ]
    , [
        "img" => "/static/images/vip/offline/image002.png"
        , "link" => "http://music.baidu.com/topic/cooperation/unlock"
        , "name" => "周笔畅发布会VIP抢票"
    ]
    , [
        "img" => "/static/images/vip/offline/image003.png"
        , "link" => "http://music.baidu.com/topic/cooperation/wangfeizhiqingchun"
        , "name" => "致青春VIP抢电影票活动"
    ]
] scope="parent"}

{$privilege_list_show_config = [
    "download" => [
        "name" => "下载特权",
        "list" => [
            "superstorage" => [
                "title" => "高品质音乐下载",
                "type" => "superstorage",
                "desc" => "VIP会员可下载最高320Kbps MP3音乐资源",
                "href" => "/vip/superstorage"
            ],

            "batchdown" => [
                "title" => "批量下载",
                "type" => "batchdown",
                "desc" => "VIP会员可一键批量下载列表、专辑内的多首歌曲",
                "href" => "/vip/batchdown"
            ],

            "losslessdown" => [
                "title" => "无损音乐下载",
                "type" => "losslessdown",
                "desc" => "白金VIP专享无损品质音乐资源下载",
                "href" => "/vip/losslessdown",
                "isPremium" => true
            ]
        ],
        "onIndex" => true
    ],

    "listen" => [
        "name" => "试听特权",
        "list" => [
            "superplay" => [
                "title" => "高品质试听",
                "type" => "superplay",
                "desc" => "VIP会员享320Kbps MP3格式高品质播放服务",
                "href" => "/vip/superplay"
            ],

            "playbackenhance" => [
                "title" => "音效增强",
                "type" => "playbackenhance",
                "desc" => "音效增强",
                "href" => "/vip/playbackenhance"
            ]
        ],
        "onIndex" => true
    ],

    "cloud" => [
        "name" => "云音乐特权",
        "list" => [
            "sync" => [
                "title" => "云端数据漫游",
                "type" => "sync",
                "desc" => "个人电脑、手机和Pad多端数据同步",
                "href" => "/vip/sync"
            ],

            "superspace" => [
                "title" => "云音乐空间",
                "type" => "superspace",
                "desc" => "VIP会员享受20000首歌曲的超大云音乐存储空间",
                "href" => "/vip/superspace"
            ],

            "highqualitystorage" => [
                "title" => "高品质存储",
                "type" => "highqualitystorage",
                "desc" => "VIP会员享受20000首歌曲的超大云音乐存储空间",
                "href" => "/vip/highqualitystorage"
            ],

            "compression" => [
                "title" => "音频压缩",
                "type" => "compression",
                "desc" => "VIP会员可将高品质资源压缩成更小的文件",
                "href" => "/vip/compression"
            ]
        ]
    ],

    "identity" => [
        "name" => "身份特权",
        "list" => [
            "vipidentity" => [
                "title" => "身份标识",
                "type" => "vipidentity",
                "desc" => "VIP会员尊享高贵身份标识",
                "href" => "/vip/vipidentity"
            ],

            "invite" => [
                "title" => "邀请特权",
                "type" => "invite",
                "desc" => "",
                "href" => "/vip/invite"
            ],

            "noad" => [
                "title" => "音乐盒去广告",
                "type" => "noad",
                "desc" => "音乐盒去广告",
                "href" => "/vip/noad",
                "isPremium" => true
            ],

            "artistapp" => [
                "title" => "新功能优先体验",
                "type" => "artistapp",
                "desc" => "VIP会员可优先体验最新版本的百度音乐产品&功能",
                "href" => "/vip/artistapp",
                "onIndex" => false
            ]
        ],
        "onIndex" => true
    ],

    "premium" => [
        "name" => "白金VIP",
        "list" => [
            "losslessdown" => [
                "title" => "无损音乐下载",
                "type" => "losslessdown",
                "desc" => "白金VIP专享无损品质音乐资源下载",
                "href" => "/vip/losslessdown",
                "isPremium" => true
            ],

            "noad" => [
                "title" => "音乐盒去广告",
                "type" => "noad",
                "desc" => "音乐盒去广告",
                "href" => "/vip/noad",
                "isPremium" => true
            ],

            "more" => [
                "title" => "更多专属特权上线中...",
                "type" => "more",
                "desc" => "",
                "href" => ""
            ]
        ]
    ]
] scope="parent"}

{$privileges_all_table = [
    "rows" => [
        [
            [
                "text" => "下载特权",
                "type" => "download"
            ],

            [
                "text" => "试听特权",
                "type" => "listen"
            ],

            [
                "text" => "云音乐特权",
                "type" => "cloud"
            ],

            [
                "text" => "身份特权",
                "type" => "identity"
            ]
        ],

        [
            [
                "text" => "高品质下载",
                "type" => "superstorage"
            ],

            [
                "text" => "高品质试听",
                "type" => "superplay"
            ],

            [
                "text" => "云端数据漫游",
                "type" => "sync"
            ],

            [
                "text" => "VIP会员标识",
                "type" => "vipidentity"
            ]
        ],

        [
            [
                "text" => "批量下载",
                "type" => "batchdown"
            ],

            [
                "text" => "音效增强",
                "type" => "playbackenhance"
            ],

            [
                "text" => "云音乐空间",
                "type" => "superspace"
            ],

            [
                "text" => "邀请特权",
                "type" => "invite"
            ]
        ],

        [
            [
                "text" => "无损音乐下载",
                "type" => "losslessdown"
            ],

            [
                "text" => ""],

            [
                "text" => "高品质储存",
                "type" => "highqualitystorage"
            ],

            [
                "text" => "音乐盒去广告",
                "type" => "noad"
            ]
        ],

        [
            [
                "text" => ""],

            [
                "text" => ""],

            [
                "text" => "音频压缩",
                "type" => "compression"
            ],

            [
                "text" => "新功能优先体验",
                "type" => "artistapp"
            ]
        ]
    ]
] scope="parent"}

{$privileges_compare_table = [
    "download" => [
        "title" => "下载特权",
        "rows" => [
            [
                ["text" => ""],

                ["text" => "普通会员"],

                ["text" => "VIP会员"],

                ["text" => "白金VIP"]
            ],

            [
                [
                    "text" => "高品质下载",
                    "type" => "superstorage"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ],

            [
                [
                    "text" => "批量下载",
                    "type" => "batchdown"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ],

            [
                [
                    "text" => "无损音乐下载",
                    "type" => "losslessdown"
                ],

                ["text" => "cross"],

                ["text" => "cross"],

                ["text" => "tick"]
            ]
        ]
    ],

    "listening" => [
        "title" => "试听特权",
        "rows" => [
            [
                ["text" => ""],

                ["text" => "普通会员"],

                ["text" => "VIP会员"],

                ["text" => "白金VIP"]
            ],

            [
                [
                    "text" => "高品质试听",
                    "type" => "superplay"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ],

            [
                [
                    "text" => "音效增强",
                    "type" => "playbackenhance"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ]
        ]
    ],

    "clouding" => [
        "title" => "云音乐特权",
        "rows" => [
            [
                ["text" => ""],

                ["text" => "普通会员"],

                ["text" => "VIP会员"],

                ["text" => "白金VIP"]
            ],

            [
                [
                    "text" => "云端数据漫游",
                    "type" => "sync"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ],

            [
                [
                    "text" => "云音乐空间",
                    "type" => "superspace"
                ],

                ["text" => "500首"],

                ["text" => "20000首"],

                ["text" => "20000首"]
            ],

            [
                [
                    "text" => "高品质储存",
                    "type" => "highqualitystorage"
                ],

                ["text" => "128kbps mp3"],

                ["text" => "320kbps mp3"],

                ["text" => "无损品质"]
            ],

            [
                [
                    "text" => "音频压缩",
                    "type" => "compression"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ]
        ]
    ],

    "indentity" => [
        "title" => "身份特权",
        "rows" => [
            [
                ["text" => ""],

                ["text" => "普通会员"],

                ["text" => "VIP会员"],

                ["text" => "白金VIP"]
            ],

            [
                [
                    "text" => "VIP会员标识",
                    "type" => "vipidentity"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ],

            [
                [
                    "text" => "邀请特权",
                    "type" => "invite"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ],

            [
                [
                    "text" => "音乐盒去广告",
                    "type" => "noad"
                ],

                ["text" => "cross"],

                ["text" => "cross"],

                ["text" => "tick"]
            ],

            [
                [
                    "text" => "新功能优先体验",
                    "type" => "artistapp"
                ],

                ["text" => "cross"],

                ["text" => "tick"],

                ["text" => "tick"]
            ]
        ]
    ]
] scope="parent"}

{$power_list_user = [
    [
        "type" => "superstorage",
        "title" => "高品质音乐下载",
        "require" => "commVip,goldVip"
    ], 
    [
        "type" => "batchdown",
        "title" => "批量下载",
        "require" => "commVip,goldVip"
    ], 
    [
        "type" => "superplay",
        "title" => "高品质音乐播放",
        "require" => "commVip,goldVip"
    ], 
    [
        "type" => "playbackenhance",
        "title" => "音效增强",
        "require" => "commVip,goldVip"
    ], 
    [
        "type" => "vipidentity",
        "title" => "VIP会员身份标识",
        "require" => "commVip,goldVip"
    ], 
    [
        "type" => "invite",
        "title" => "邀请特权",
        "require" => "commVip,goldVip"
    ], 
    [
        "type" => "losslessdown",
        "title" => "无损音乐下载",
        "require" => "goldVip"
    ], 
    [
        "type" => "noad",
        "title" => "音乐盒去广告",
        "require" => "goldVip"
    ]
] scope="parent"}

{$power_list_config = [
    "vip" => [
        "title" => "<span class='red'>VIP</span>会员权利",
        "list" => [
            "superstorage" => [
                "title" => "高品质音乐下载",
                "type" => "superstorage",
                "desc" => "",
                "href" => "/vip/superstorage"
            ],
            "superplay" => [
                "title" => "高品质音乐播放",
                "type" => "superplay",
                "desc" => "VIP会员享320Kbps MP3格式高品质播放服务",
                "href" => "/vip/superplay"
            ],
            "batchdown" => [
                "title" => "批量下载",
                "type" => "batchdown",
                "desc" => "VIP会员可一键批量下载列表、专辑内的多首歌曲",
                "href" => "/vip/batchdown"
            ],
            "vipidentity" => [
                "title" => "VIP会员身份标识",
                "type" => "vipidentity",
                "desc" => "VIP会员尊享高贵身份标识",
                "href" => "/vip/vipidentity"
            ],
            "artistapp" => [
                "title" => "新产品优先体验",
                "type" => "artistapp",
                "desc" => "最火资源、最新功能、最精彩的活动<br />百度音乐VIP, 优先体验",
                "href" => "/vip/artistapp"
            ],
            "superspace" => [
                "title" => "超大存储空间",
                "type" => "superspace",
                "desc" => "音乐数据尽在云端，三端同步永不下架。",
                "href" => "/vip/superspace"
            ],
            "compression" => [
                "title" => "音频压缩",
                "type" => "compression",
                "desc" => "VIP会员可将高品质资源压缩成更小的文件",
                "href" => "/vip/compression"
            ],
            "invite" => [
                "title" => "邀请特权",
                "type" => "invite",
                "desc" => "",
                "href" => "/vip/invite"
            ],
            "playbackenhance" => [
                "title" => "音效增强",
                "type" => "playbackenhance",
                "desc" => "极致试听体验",
                "href" => "/vip/playbackenhance"
            ],
            "highqualitystorage" => [
                "title" => "高品质储存",
                "type" => "highqualitystorage",
                "desc" => "",
                "href" => "/vip/highqualitystorage"
            ],
            "noad" => [
                "title" => "音乐盒去广告",
                "type" => "noad",
                "desc" => "",
                "href" => "/vip/noad"
            ]
        ]
    ],
    "gold" => [
        "title" => "<span class='red'>白金VIP</span>会员专享",
        "list" => [
            "losslessdown" => [
                "title" => "无损音乐下载",
                "type" => "losslessdown",
                "desc" => "白金VIP专享无损品质音乐资源下载",
                "href" => "/home/vip/losslessdown"
            ]
        ]
    ],
    "free" => [
        "title" => "普通会员权利",
        "list" => [
            "space" => [
                "title" => "存储空间",
                "type" => "space",
                "desc" => "普通会员拥有500首歌曲的免费存储空间",
                "href" => "/home/vip/space"
            ],
            "play" => [
                "title" => "音乐播放",
                "type" => "play",
                "desc" => "普通会员可享受128Kbps MP3格式的音乐播放服务",
                "href" => "/home/vip/play"
            ],
            "clouddown" => [
                "title" => "云端音乐下载",
                "type" => "clouddown",
                "desc" => "普通会员可下载128Kbps MP3格式的歌曲",
                "href" => "/home/vip/clouddown"
            ],
            "sync" => [
                "title" => "多端数据同步",
                "type" => "sync",
                "desc" => "个人电脑、手机和Pad多端数据同步",
                "href" => "/home/vip/sync"
            ]
        ]   
    ]
] scope="parent"}

{$userStatusConfigure = [
    'none' => [
        'button' => [
            'str' => '开通<b>VIP</b>会员',
            'href' => '/home/payment/cloud?type=add&level=comm'
        ]
    ],
    
    'login' => [
        'button' => [
        	'str' => '开通<b>VIP</b>会员',
        	'href' => '/home/payment/cloud?type=add&level=comm'
        ],
        'link' => [
    		'href' => '/home/payment/cloud?type=add&level=gold',
    		'title' => '开通白金VIP',
    		'text' => '开通白金VIP，专享无损音乐下载'
    	]
    ],
    'commVip' => [
    	'button' => [
    		'str' => '<b>VIP</b>会员续期',
    		'href' => '/home/payment/cloud?type=up&level=comm'
    	],
    	'link' => [
    		'href' => '/home/payment/cloud?type=upgrade&level=gold',
    		'title' => '升级白金VIP',
    		'text' => '升级白金VIP，专享无损音乐下载'
    	]
    ],
    'goldVip' => [
    	'button' => [
    		'str' => '白金<b>VIP</b>会员续期',
    		'href' => '/home/payment/cloud?type=up&level=gold'
    	]
    ]
] scope="parent"}
