{$access = [
    'none' => '00',
    'collect' => '01',
    'download' => '10'
] scope="parent"}

{$title = [
    '64' => '标准品质',
    '96' => '标准品质',
    '128' => '标准品质',
    '192' => '高品质',
    '256' => '高品质',
    '320' => '超高品质',
    '1000' => '无损品质'
] scope="parent"}

{$buttons = [
    'noLoginDownload' => [
        'class' => 'btn-download no-login-download',
        'text' => '下载',
        'href' => 'link',
        'icon' => 'download-small'
    ],
	'download' => [
		'class' => 'btn-download download',
		'text' => '下载',
        'icon' => 'download-small',
        'href' => 'link'
	],
	'loginDownload' => [
		'class' => 'btn-download login-download',
		'text' => '登录后下载',
        'icon' => 'download-small',
        'description' => '<a href="#" title="登录" class="login-btn">登录</a>'
	],
	'loginCommVipTry' => [
		'class' => 'btn-download login-download',
		'text' => '下载',
        'icon' => 'download-small',
        'description' => ''
	], 
	'loginCommVip' => [
		'class' => 'login-vip-download',
		'text' => 'VIP用户登录后下载',
        'icon' => 'download-small',
        'style' => 'f',
        'description' => '<a href="/home/payment/cloud?type=add&level=comm&pst=pay_download" title="开通VIP会员" class="add-vip" target="_blank"><i class="power-icon-min power-icon-vipidentity-active"></i></a>'
	],
	'loginGoldVip' => [
		'class' => 'login-vip-download',
		'text' => '白金VIP用户登录后下载',
        'style' => 'k',
        'icon' => 'download-small',
        'description' => '<a href="/home/payment/cloud?type=add&level=gold&pst=pay_download" title="开通白金VIP会员" class="add-vip" target="_blank"><i class="power-icon-min power-icon-goldvip-active"></i>开通白金VIP>></a>'
	],
    'commVip' => [
        'class' => 'not-vip-download',
        'text' => '成为VIP用户后下载',
        'href' => '/home/payment/cloud?type=add&level=comm&pst=pay_download',
        'target' => 'target="_blank"',
        'style' => 'k',
        'icon' => 'download-small',
        'description' => '<a href="/home/payment/cloud?type=add&level=comm&pst=pay_download" title="开通VIP会员" class="add-vip" target="_blank"><i class="power-icon-min power-icon-vipidentity-active"></i></a>'
    ],
    'goldVip' => [
        'class' => 'not-vip-download',
        'text' => '成为白金VIP用户后下载',
        'href' => '/home/payment/cloud?type=add&level=gold&pst=pay_download',
        'target' => 'target="_blank"',
        'style' => 'k',
        'icon' => 'download-small',
        'description' => '<a href="/home/payment/cloud?type=add&level=gold&pst=pay_download" title="开通白金VIP会员" class="add-vip" target="_blank"><i class="power-icon-min power-icon-goldvip-active"></i>开通白金VIP>></a>'
    ],
    'upgradeGoldVip' => [
    	'class' => 'not-vip-download',
        'text' => '升级为白金VIP用户后下载',
        'href' => '/home/payment/cloud?type=upgrade&level=gold&pst=pay_download',
        'target' => 'target="_blank"',
        'style' => 'k',
        'icon' => 'download-small',
        'description' => '<a href="/home/payment/cloud?type=upgrade&level=gold&pst=pay_download" title="升级白金VIP会员" class="add-vip" target="_blank"><i class="power-icon-min power-icon-goldvip-active"></i>升级白金VIP>></a>'
    ],
    'collect' => [
        'class' => 'song-collect',
        'text' => '保存到云'
    ]
] scope="parent"}

{$accessConfigure = [
	'none' => [
		'notThree' => [
			'64' => [
				'access' => $access['download'],
				'button' => 'download'
			],
            '96' => [
                'access' => $access['dowmload'],
                'button' => 'download'
            ],
			'128' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'192' => [
				'access' => $access['none'],
				'button' => 'loginDownload'
			],
			'256' => [
				'access' => $access['none'],
				'button' => 'loginDownload'
			],
			'320' => [
				'access' => $access['none'],
				'button' => 'loginDownload'
			],
			'1000' => [
				'access' => $access['none'],
				'button' => 'loginGoldVip'
			]
		],
		'isThree' => [
			'64' => [
				'access' => $access['none'],
				'button' => 'loginCommVipTry'
			],
            '96' => [
                'access' => $access['dowmload'],
                'button' => 'download'
            ],
			'128' => [
				'access' => $access['none'],
				'button' => 'loginCommVipTry'
			],
			'192' => [
				'access' => $access['none'],
				'button' => 'loginCommVipTry'
			],
			'256' => [
				'access' => $access['none'],
				'button' => 'loginCommVipTry'
			],
			'320' => [
				'access' => $access['none'],
				'button' => 'loginGoldVip'
			],
			'1000' => [
				'access' => $access['none'],
				'button' => 'loginGoldVip'
			]
		]
	],
	'login' => [
		'notThree' => [
			'64' => [
				'access' => $access['download'],
				'button' => 'download'
			],
            '96' => [
                'access' => $access['dowmload'],
                'button' => 'download'
            ],
			'128' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'192' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'256' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'320' => [
				'access' => $access['none'],
				'button' => 'download'
			],
			'1000' => [
				'access' => $access['none'],
				'button' => 'goldVip'
			]
		],
		'isThree' => [
			'64' => [
				'access' => $access['none'],
				'button' => 'commVip'
			],
            '96' => [
                'access' => $access['dowmload'],
                'button' => 'download'
            ],
			'128' => [
				'access' => $access['none'],
				'button' => 'commVip'
			],
			'192' => [
				'access' => $access['none'],
				'button' => 'commVip'
			],
			'256' => [
				'access' => $access['none'],
				'button' => 'commVip'
			],
			'320' => [
				'access' => $access['none'],
				'button' => 'goldVip'
			],
			'1000' => [
				'access' => $access['none'],
				'button' => 'goldVip'
			]
		]
	],
	'commVip' => [
		'notThree' => [
			'64' => [
				'access' => $access['download'],
				'button' => 'download'
			],
            '96' => [
                'access' => $access['dowmload'],
                'button' => 'download'
            ],
			'128' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'192' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'256' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'320' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'1000' => [
				'access' => $access['none'],
				'button' => 'upgradeGoldVip'
			]
		],
		'isThree' => [
			'64' => [
				'access' => $access['download'],
				'button' => 'download'
			],
            '96' => [
                'access' => $access['dowmload'],
                'button' => 'download'
            ],
			'128' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'192' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'256' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'320' => [
				'access' => $access['none'],
				'button' => 'upgradeGoldVip'
			],
			'1000' => [
				'access' => $access['none'],
				'button' => 'upgradeGoldVip'
			]
		]
	],
	'goldVip' => [
		'notThree' => [
			'64' => [
				'access' => $access['download'],
				'button' => 'download'
			],
            '96' => [
                'access' => $access['dowmload'],
                'button' => 'download'
            ],
			'128' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'192' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'256' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'320' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'1000' => [
				'access' => $access['download'],
				'button' => 'download'
			]
		],
		'isThree' => [
			'64' => [
				'access' => $access['download'],
				'button' => 'download'
			],
            '96' => [
                'access' => $access['dowmload'],
                'button' => 'download'
            ],
			'128' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'192' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'256' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'320' => [
				'access' => $access['download'],
				'button' => 'download'
			],
			'1000' => [
				'access' => $access['download'],
				'button' => 'download'
			]
		]
	]
] scope="parent"}
