{$vipConfigure = [
    "add" => [
        "comm" => [
            "title" => "开通VIP会员",
            "tip" => "5元/月"
        ],
        "gold" => [
            "title" => "开通白金VIP",
            "tip" => "10元/月"
        ]
    ],
    "upgrade" => [
        "gold" => [
            "title" => "升级白金VIP",
            "tip" => "10元/月"
        ]
    ],
    "up" => [
        "comm" => [
            "title" => "续期VIP会员",
            "tip" => "5元/月"
        ],
        "gold" => [
            "title" => "续期白金VIP",
            "tip" => "10元/月"
        ]
    ]
] scope="parent"}

{$power_list_config = [
    "vip" => [
        "list" => [
            "superstorage" => [
                "title" => "高品质音乐下载",
                "type" => "superstorage",
                "desc" => "",
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
                "href" => "/home/vip/losslessdown"
            ],
            "superplay" => [
                "title" => "高品质试听",
                "type" => "superplay",
                "desc" => "VIP会员享320Kbps MP3格式高品质播放服务",
                "href" => "/vip/superplay"
            ],
            "playbackenhance" => [
                "title" => "音效增强",
                "type" => "playbackenhance",
                "desc" => "极致试听体验",
                "href" => "/vip/playbackenhance"
            ],
            
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
                "desc" => "",
                "href" => "/vip/noad"
            ],
            "artistapp" => [
                "title" => "新功能优先体验",
                "type" => "artistapp",
                "desc" => "最火资源、最新功能、最精彩的活动<br />百度音乐VIP, 优先体验",
                "href" => "/vip/artistapp"
            ]
        ]
    ],
    "gold" => [
        "list" => [
            "losslessdown" => [
                "title" => "无损音乐下载",
                "type" => "losslessdown",
                "desc" => "白金VIP专享无损品质音乐资源下载",
                "href" => "/home/vip/losslessdown"
            ]
        ]
    ]
] scope="parent"}