{extends file="plaza/doc/doc.html.tpl"}
{block name="title"}
	帮助中心
{/block}
{block name="main_body"}
{include file="widget/tab/tab.html.tpl" inline}
	<h1>帮助中心</h1>
	<div class="help-body" id="help_body">
		{$tabs = [
      [
        "link" => "#",
        "title" => "百度音乐网站",
        "active" => 1
      ],
      [
        "link" => "#",
        "title" => "电脑版"
      ],
      [
        "link" => "#",
        "title" => "手机版"
      ],
      [
        "link" => "#",
        "title" => "Pad版"
      ],
			[
				"link" => "#",
				"title" => "帐号"
			],
      [
        "link" => "#",
        "title" => "VIP会员"
      ],
			[
				"link" => "#",
				"title" => "百度随心听"
			]
		]}
		{tab tablist = $tabs style = "middle"}
		<div class="music-ui-tab-body">
      <div class="ui-tab-content">
        <ul>
          <li>
            <h4><span>Q:</span>百度音乐搜索音乐窍门</h4>
            <div class="answer">
              <div>A:</div>
              <p>您可以在搜索框中输入歌曲名、专辑名、音乐人姓名来查找想要的信息。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>我的音乐盒使用指南</h4>
            <div class="answer">
              <div>A:</div>
              <p>1、点击播放图标，就会自动弹出音乐盒为您播放您选择的歌曲、专辑和专题。<br />
                2、您觉得好听的歌就点红心收藏吧，下次可以在“我的音乐”里听到。<br />
                3、不仅想在线听，还想下载到本地听，那就点击下载，还可以批量下载哦。<br />
                4、同步显示当前播放的歌曲歌词，还可一键复制歌词。
              </p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>如何在手机或Pad上使用百度音乐？</h4>
            <div class="answer">
              <div>A:</div>
              <p>1、 Android用户可以在手机或Pad上打开浏览器，或去应用市场，搜“百度音乐”，下载APP，安装后即可使用。iOS用户可以在App Store搜索“百度音乐”，下载APP，安装后即可使用；<br />
                2、 您也可以在电脑上进入<a href="http://music.baidu.com/mobile" target="_blank">http://music.baidu.com/mobile</a> 下载百度音乐Android版、iPhone版或Pad版到手机或平板电脑，安装好后启动就可以使用啦。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>音乐盒中有一部分歌曲无法正常播放怎么办?</h4>
            <div class="answer">
              <div>A:</div>
              <p>请将您不能正常或完整播放的“歌曲名-歌手名-专辑”的信息，还有您的浏览器版本，联系方式，并将问题清晰地描述出来，邮件反馈至 <a href="mailto:musichelp@baidu.com">musichelp@baidu.com</a>	</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>如何用手机使用百度音乐听歌？</h4>
            <div class="answer">
              <div>A:</div>
              <p>1、 通过iTunes或Android软件市场免费下载“百度音乐”手机版最新版本，第一时间收听歌曲。<br>
                2、 百度一下“百度音乐手机版”即可免费下载“百度音乐”手机版最新版本，享受音乐服务。<br>
                3、 进入 <a target="_blank" href="http://music.baidu.com/mobile">http://music.baidu.com/mobile</a>	 ，扫描二维码或点击下载，即可免费下载“百度音乐”手机版最新版。	</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>大陆IP无法查看怎么办？</h4>
            <div class="answer">
              <div>A:</div>
              <p>	请将您的IP地址、您所处的城市及网络供应商的名称反馈到<a href="mailto:musichelp@baidu.com">musichelp@baidu.com</a>，我们会尽快查找原因并给予回应。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>为什么境外IP无法访问？</h4>
            <div class="answer">
              <div>A:</div>
              <p>	我们因为版权限制，暂时无法提供中国大陆以外地区的百度音乐服务，非常抱歉给您带来了不便。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>如何进行歌词搜索？</h4>
            <div class="answer">
              <div>A:</div>
              <p>百度音乐支持搜索歌词功能，您可在搜索栏输入歌词查找您需要的歌曲。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>如何进行格式搜索？</h4>
            <div class="answer">
              <div>A:</div>
              <p>百度音乐歌曲下载格式默认为mp3格式，如果您需要其他格式音乐请将需求及原因反馈到<a href="mailto:musichelp@baidu.com">musichelp@baidu.com</a>，我们会尽快改善。	</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>为什么查不到歌曲或歌手？</h4>
            <div class="answer">
              <div>A:</div>
              <p>	感谢您对百度音乐的支持，请将您要查找的歌曲或歌手反馈到<a href="mailto:musichelp@baidu.com">musichelp@baidu.com</a>，我们会尽快改善。 </p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>为什么歌曲歌词显示不成功？</h4>
            <div class="answer">
              <div>A:</div>
              <p>请您将歌曲、歌手信息和浏览器及其版本反馈给<a href="mailto:musichelp@baidu.com">musichelp@baidu.com</a>，我们会尽快联系相关人员处理。	</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>为什么歌曲无法下载？如歌曲下载错误、歌曲下载名称乱码等</h4>
            <div class="answer">
              <div>A:</div>
              <p>请您将有问题的歌曲下载地址（歌曲名称上方 music.baidu.com/song/*******/download形式地址）以及您的IP地址、所处城市、网络供应商名称反馈到<a href="mailto:musichelp@baidu.com">musichelp@baidu.com</a>，我们会尽快查找原因并给予回应。	</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>为什么要取消歌曲的外链？</h4>
            <div class="answer">
              <div>A:</div>
              <p>	感谢您对百度音乐的支持，因为版权问题目前百度音乐不支持外链。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>百度音乐的榜单是怎么得来的？</h4>
            <div class="answer">
              <div>A:</div>
              <p>	榜单的数据来自百度音乐搜索中播放量最高的歌曲/歌手等， 由系统自动计算统计得出结果。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>歌曲如何入库百度音乐？</h4>
            <div class="answer">
              <div>A:</div>
              <p>百度音乐歌曲入库需通过邮箱进行申请，请注明需求，同时需要介绍公司名称及情况，请将邮件发送至<a href="mailto:fuying01@baidu.com">fuying01@baidu.com</a>。	</p>
            </div>
          </li>

        </ul>
      </div>

      <div class="ui-tab-content"  style="display:none;">
        <ul>
          <li>
            <h4><span>Q:</span>如何下载安装电脑版？</h4>
            <div class="answer">
              <div>A:</div>
              <p>电脑上访问<a href="http://qianqian.baidu.com/index.php">http://qianqian.baidu.com/index.php</a>，下载软件并安装即可。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>有mac版吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>暂时只有windows版，之后如果mac版上线，我们会第一时间通知你。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>电脑版有哪些特色功能？</h4>
            <div class="answer">
              <div>A:</div>
              <p>
                1、正版超高品质、无损音乐下载。 <br>
                2、多种音效插件，给你震撼试听体验。 <br>
                3、权威榜单、音乐专题、歌单等帮你发现好音乐。 <br>
                4、个人的、安全永久的超大云音乐存储空间。 <br>
                5、个性化皮肤，同步歌词。
              </p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>支持哪些音频格式？</h4>
            <div class="answer">
              <div>A:</div>
              <p>支持几乎所有常见的音频格式，包括MP3/mp3PRO、AAC/AAC+、M4A/MP4、WMA、APE、MPC、OGG、WAVE、CD、FLAC、RM、TTA、AIFF、AU等音频格式以及多种MOD和MIDI音乐。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>支持哪些操作系统？</h4>
            <div class="answer">
              <div>A:</div>
              <p>支持win 2000/2003、XP、vista、win 7、win8操作系统。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
        </ul>
      </div>

      <div class="ui-tab-content" style="display:none;">
        <ul>
          <li>
            <h4><span>Q:</span>哪些手机可以使用手机版？</h4>
            <div class="answer">
              <div>A:</div>
              <p>iPhone手机、安卓手机、Windows Phone手机。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>如何安装手机版？</h4>
            <div class="answer">
              <div>A:</div>
              <p>
                1、电脑或手机上访问http://music.baidu.com/mobile，下载手机对应版本。 <br>
                2、Android用户可以在手机打开浏览器，或去应用市场，搜索“百度音乐”，下载安装即可。 <br>
                3、iPhone用户可以在App Store搜索“百度音乐”，下载安装即可。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>手机版是收费应用吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>百度音乐iPhone版、安卓版以及Windows Phone版均是免费应用，可通过各应用市场免费下载安装。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>使用手机版消耗手机流量吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>收听本地歌曲不需要手机流量，试听或下载在线音乐需要手机流量，建议您在WIFI环境下使用在线音乐。您可以在WIFI下缓存或下载歌曲，保证无网情况下也能随时畅听。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>可以设置完全不走手机流量吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>你可以打开流量开关，关闭流量使用，避免流量透支。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>手机版的歌曲可以同步到电脑或Pad等设备上吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>你只要登录百度帐号，即可实现收藏歌曲在不同设置间的自动同步功能，让您随意畅听，音乐不间断。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>大陆以外地区可以使用吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>本地歌曲播放功能没有任何限制，但因为版权限制，中国大陆以外地区无法使用在线音乐，非常抱歉给您带来了不便。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
        </ul>
      </div>

      <div class="ui-tab-content" style="display:none;">
        <ul>
          <li>
            <h4><span>Q:</span>一共有哪些pad版？</h4>
            <div class="answer">
              <div>A:</div>
              <p>目前只有iPad版，安卓pad版和Windows pad版正在抓紧上线中…</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>如何安装pad版？</h4>
            <div class="answer">
              <div>A:</div>
              <p>
                1、方法一：将iPad连上电脑，并在电脑上打开itunes，在app store中搜索”百度音乐” ，下载安装即可。 <br>
                2、方法二：解锁iPad，打开app store ，搜索”百度音乐” ，下载安装即可。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>pad版是收费应用吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>百度音乐iPad版及之后即将上线的安卓版、Windows pad版均是免费应用，可通过各应用市场免费下载安装。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>pad版的歌曲可以同步到电脑或手机等设备上吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>你只要登录百度帐号，即可实现收藏歌曲在不同设置间的自动同步功能，让您随意畅听，音乐不间断。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>大陆以外地区可以使用吗？</h4>
            <div class="answer">
              <div>A:</div>
              <p>因版权限制，仅在中国大陆地区提供在线音乐服务，对你造成的不便深表歉意。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
        </ul>
      </div>

			<div class="ui-tab-content" style="display:none;">
				<ul>
					<li>
						<h4><span>Q:</span>为什么提示我需要注册？</h4>
						<div class="answer">
							<div>A:</div>
							<p>注册能让您享用更好的服务，登录后，无论您是在电脑上还是移动设备上使用百度音乐，都可以同步您收藏的歌曲和播放记录。注册流程很简单，不会耽误您太久的时间。另外，如果您已经有百度帐号，您可以用百度帐号登录。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>如何注册个人帐号？</h4>
						<div class="answer">
							<div>A:</div>
							<p>如果您还没有百度帐号，请注册一个百度帐号，就可以享受百度音乐为您提供的服务。如果您已经是百度其他产品（百度贴吧、百度知道、百度空间等）的用户，可以直接使用您的百度帐号和密码登录。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>登录密码能修改吗？如何修改？</h4>
						<div class="answer">
							<div>A:</div>
							<p>登录密码可以修改。登录百度音乐后，进入 <a href="http://passport.baidu.com/center" target="_blank">http://passport.baidu.com/center</a>	，点击“修改密码”，在该页面即可修改登录密码。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>我忘记了密码怎么办？</h4>
						<div class="answer">
							<div>A:</div>
							<p>如果不小心忘记了您的密码，可以在登录页面中，点击登录按钮旁的“忘记密码”，输入您的百度帐号和注册邮箱的地址，您可以通过邮件中的链接进行密码的修改。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>帐号的安全隐患可能是什么？</h4>
						<div class="answer">
							<div>A:</div>
							<p>
								1. 因外部不可控因素（如其他网站用户资料泄露等），您的帐号有被他人登录的风险。<br />
								2. 您的帐号最近有异常的登录行为。建议您在百度音乐使用不同于其他网站的用户名和密码，且定期修改密码，以确保帐号安全。
							</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>我上传的头像为什么不见了？</h4>
						<div class="answer">
							<div>A:</div>
							<p>如果您上传的图片含有反动类、色情类、恐怖类，或其他中国法律、法规以及任何具有法律效力之规范所限制或禁止的图片，则该图片会被删除。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>可以把喜欢的歌曲分享到其他社交网站吗？</h4>
						<div class="answer">
							<div>A:</div>
							<p>可以的，目前支持QQ空间、人人网、新浪微博、腾讯微博、百度贴吧、开心网等平台，您可以点击分享按钮，一键将百度音乐上好听的歌曲分享至以上平台。</p>
						</div>
					</li>
				</ul>
			</div>


      <div class="ui-tab-content" style="display:none;">
        <ul>
          <li>
            <h4><span>Q:</span>什么是VIP会员？</h4>
            <div class="answer">
              <div>A:</div>
              <p>VIP会员是百度音乐推出的付费会员服务，旨在为付费用户提供优质的音乐服务。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>VIP会员有哪些特权？</h4>
            <div class="answer">
              <div>A:</div>
              <p>百度音乐VIP会员可以享受超大存储空间、高品质音乐播放、高品质音乐存储、音频压缩、VIP会员身份标识、艺人APP优先体验等特权......还有更多会员专享特权将陆续上线。VIP会员特权详情请参考 <a target="_blank" href="http://music.baidu.com/home/vip">http://music.baidu.com/home/vip</a></p>
            </div>
            <div class="module-dotted"></div>
          </li>
          <li>
            <h4><span>Q:</span>怎样成为VIP会员？</h4>
            <div class="answer">
              <div>A:</div>
              <p>登录百度音乐帐号，进入<a target="_blank" href="http://music.baidu.com/home/vip">http://music.baidu.com/home/vip</a>，在该页面点击「开通VIP会员」，立即享受上述VIP会员特权。</p>
            </div>
            <div class="module-dotted"></div>
          </li>
        </ul>
      </div>

			<div class="ui-tab-content" style="display:none;">
				<ul>
					<li>
						<h4><span>Q:</span>什么是百度随心听？</h4>
						<div class="answer">
							<div>A:</div>
							<p>百度随心听是百度音乐推出的全新音乐产品，界面简洁，操作简便，并提供智能、个性化的音乐推荐，为用户提供贴心的好音乐。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>百度随心听的功能是什么？</h4>
						<div class="answer">
							<div>A:</div>
							<p>百度随心听的功能包括分享，选择频道，红心收藏，下载，歌词显示，播放上一曲下一曲，将不喜欢歌曲放到垃圾桶中等。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>百度随心听都有哪些频道？</h4>
						<div class="answer">
							<div>A:</div>
							<p>目前分为私人频道、红心频道和公共频道，私人频道主要依据登陆用户的个人收听喜好提供个性化的歌曲；红心频道中是点击红心收藏的歌曲；公共频道则有随便听听、KTV金曲、网络红歌、天下足球、慵懒午后、毕业歌、开车、情歌、影视、旅行、70后、80后、90后、火爆新歌、经典老歌、儿歌、流行、摇滚、DJ舞曲、轻音乐、古典、华语、欧美、日语、韩语、粤语等大量细分频道，最大限度满足用户的个性化需求。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>百度随心听有哪些特色功能？</h4>
						<div class="answer">
							<div>A:</div>
							<p>1、歌词显示：当前播放歌曲的右侧是歌词，用户无需再从网页中寻找相关歌词。<br />
								2、免费下载：每首歌曲下面都有下载歌曲的按钮，用户可直接点击下载按钮下载歌曲。 　　<br />
								3、播放上一曲：您可以点击左边较小的专辑图片去“再听一遍”，更多试听历史可以在右上角的试听历史页面里找到。<br />
								4、播放下一曲：您可以点击专辑封面下的“切歌”按钮收听下一首歌曲，我们会即时根据您的操作进行下一首歌曲的推荐效果优化。<br />
								5、音量调节：您可以点击专辑封面下的“小喇叭”按钮调节歌曲音量。
							</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>怎样让百度随心听只放符合你口味的歌曲？</h4>
						<div class="answer">
							<div>A:</div>
							<p>百度随心听致力于播放最符合您口味的歌曲。首先，请登录您的百度帐号；其次，碰到喜欢的歌曲，请点击红心按钮，表示您喜欢该歌曲，我们会记录您的喜好；遇到不喜欢的歌曲，您可以点击垃圾桶按钮，将不喜欢的歌曲扔进垃圾桶，我们再也不会推荐给您这首歌。点击越多您喜欢的红心歌曲，我们的判断会更精准，您就能听到更多符合您口味的歌曲！
							</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>如何在手机上听百度随心听？</h4>
						<div class="answer">
							<div>A:</div>
							<p>iPhone，iTouch，iPad和安卓用户可以打开浏览器，输入<a target="_blank" href="http://fm.baidu.com">http://fm.baidu.com</a>，可收听；iPhone用户可以进入 <a target="_blank" href="http://fm.baidu.com/app/">http://fm.baidu.com/app/</a>，或者在App Store下载百度随心听到您的手机，更方便您在手机上使用。</p>
						</div>
						<div class="module-dotted"></div>
					</li>
					<li>
						<h4><span>Q:</span>百度随心听有搜索、快进、拖动进度条和列表的功能吗？</h4>
						<div class="answer">
							<div>A:</div>
							<p>感谢您对百度音乐的支持，百度随心听没有搜索（快进、进度条、列表）功能，我们会通过分析您的歌曲喜好，智能推送给您歌曲，旨在帮助您在海量歌曲库中挑选出符合您口味的音乐。</p>
						</div>
					</li>
				</ul>
			</div>


		</div>
		<p class="more-serviece">更多反馈意见请进入 <a href="http://service.baidu.com/question?prod_en=music" target="_blank">百度用户服务中心</a> 集中提交，我们致力于给您提供越来越好的音乐服务！</p>
	</div>
{/block}
