{$access = [
    'none' => '00',
    'collect' => '01',
    'download' => '10'
] scope="parent"}

{$title = [
    '64' => ['rate' => '普通品质', 'desc' =>'64kbps'],
    '128' => ['rate' => '普通品质', 'desc' =>'128kbps'],
    '192' => ['rate' => '高品质', 'desc' =>'192kbps'],
    '256' => ['rate' => '高品质', 'desc' =>'256kbps'],
    '320' => ['rate' => '超高品质', 'desc' =>'320kbps'],
    '1000' => ['rate' => '无损品质', 'desc' =>'flac']
] scope="parent"}

{$buttons = [
    'noLoginDownload' => [
        'class' => 'btn-download no-login-download',
        'text' => '下载',
        'href' => 'link',
        'style' => 'g',
        'icon' => 'download-icon'
    ],
	'download' => [
		'class' => 'btn-download download',
		'text' => '下载',
        'icon' => 'download-icon',
        'href' => 'link'
	],
	'loginDownload' => [
		'class' => 'btn-download login-download',
		'text' => '登录后下载',
        'icon' => 'download-icon',
        'description' => '需要<a href="#" title="登录" class="login-btn">登录>></a>'
	],
	'loginCommVipTry' => [
		'class' => 'btn-download login-download',
		'text' => '下载',
        'icon' => 'download-icon',
        'description' => '<i class="power-icon-min power-icon-vipidentity-active"></i>VIP会员特权，免费试用2个月',
        'style' => 'g'
	], 
	'loginCommVip' => [
		'class' => 'login-vip-download',
		'text' => 'VIP用户登陆后下载',
        'icon' => 'collect-vip',
        'style' => 'f',
        'description' => '<i class="power-icon-min power-icon-vipidentity-active"></i>VIP会员特权<a href="/home/payment/cloud?type=add&level=comm&pst=pay_piliang" title="开通VIP会员" class="add-vip" target="_blank">开通>></a>'
	],
	'loginGoldVip' => [
		'class' => 'login-vip-download',
		'text' => '白金VIP用户登陆后下载',
        'style' => 'f',
        'icon' => 'goldvip',
        'description' => '<i class="power-icon-min power-icon-goldvip-active"></i>白金VIP会员特权<a href="/home/payment/cloud?type=add&level=gold&pst=pay_piliang" title="开通白金VIP会员" class="add-vip" target="_blank">开通>></a>'
	],
    'commVip' => [
        'class' => 'not-vip-download',
        'text' => '成为VIP用户后下载',
        'href' => '/home/payment/cloud?type=add&level=comm&pst=pay_piliang',
        'target' => 'target="_blank"',
        'style' => 'f',
        'icon' => 'collect-vip',
        'description' => '<i class="power-icon-min power-icon-vipidentity-active"></i>VIP会员特权<a href="/home/payment/cloud?type=add&level=comm&pst=pay_piliang" title="开通VIP会员" class="add-vip" target="_blank">开通>></a>'
    ],
    'goldVip' => [
        'class' => 'not-vip-download',
        'text' => '成为白金VIP用户后下载',
        'href' => '/home/payment/cloud?type=add&level=gold&pst=pay_piliang',
        'target' => 'target="_blank"',
        'style' => 'f',
        'icon' => 'goldvip',
        'description' => '<i class="power-icon-min power-icon-goldvip-active"></i>白金VIP会员特权<a href="/home/payment/cloud?type=add&level=gold&pst=pay_piliang" title="开通白金VIP会员" class="add-vip" target="_blank">开通>></a>'
    ],
    'upgradeGoldVip' => [
    	'class' => 'not-vip-download',
        'text' => '升级为白金VIP用户后下载',
        'href' => '/home/payment/cloud?type=upgrade&level=gold&pst=pay_piliang',
        'target' => 'target="_blank"',
        'style' => 'f',
        'icon' => 'goldvip',
        'description' => '<i class="power-icon-min power-icon-goldvip-active"></i>白金VIP会员特权<a href="/home/payment/cloud?type=upgrade&level=gold&pst=pay_piliang" title="升级白金VIP会员" class="add-vip" target="_blank">升级>></a>'
    ],
    'collect' => [
        'class' => 'song-collect',
        'text' => '保存到云'
    ]
] scope="parent"}

{$accessConfigure = [
	'none' => [
		'64' => [
			'access' => $access['download'],
			'button' => 'loginCommVip'
		],
		'128' => [
			'access' => $access['download'],
			'button' => 'loginCommVip'
		],
		'192' => [
			'access' => $access['none'],
			'button' => 'loginCommVip'
		],
		'256' => [
			'access' => $access['none'],
			'button' => 'loginCommVip'
		],
		'320' => [
			'access' => $access['none'],
			'button' => 'loginCommVip'
		]
	],
	'login' => [
		'64' => [
			'access' => $access['none'],
			'button' => 'commVip'
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
			'button' => 'commVip'
		]
	],
	'commVip' => [
		'64' => [
			'access' => $access['download'],
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
		]
	],
	'goldVip' => [
		'64' => [
			'access' => $access['download'],
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
		]
	]
] scope="parent"}
