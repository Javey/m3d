{assign var=module value=[
            '10000'=>[ 'path'=>'topic/mod/musiclist/mod_music_list.html.tpl' , 'className'=>'' ],
            '10001'=>[ 'path'=>'topic/mod/musiclist/mod_music_list_right.html.tpl' , 'className'=>'' ],
            '10002'=>[ 'path'=>'topic/mod/musiclist/mod_single.html.tpl' , 'className'=>'' ],
            '10003'=>[ 'path'=>'topic/mod/musiclist/mod_music_list.html.tpl' , 'className'=>'music-list-float' ],
            '10004'=>[ 'path'=>'topic/mod/musiclist/mod_music_list.html.tpl' , 'className'=>'music-list-banner' ],
            '10005'=>[ 'path'=>'topic/mod/musiclist/mod_single_inline.html.tpl' , 'className'=>'' ],
            '10100'=>[ 'path'=>'topic/mod/share/mod_share.html.tpl' , 'className'=>'' ],
            '10200'=>[ 'path'=>'topic/mod/star/mod_star.html.tpl' , 'className'=>'' ],
			'10201'=>[ 'path'=>'topic/mod/star/mod_star_album.html.tpl' , 'className'=>'' ],
			'10300'=>[ 'path'=>'topic/mod/information/mod_information.html.tpl' , 'className'=>'' ],
            '10301'=>[ 'path'=>'topic/mod/information/mod_information.html.tpl' , 'className'=>'information-noinfo' ],
            '10302'=>[ 'path'=>'topic/mod/information/mod_information_banner.html.tpl' , 'className'=>'' ],
			'10400'=>[ 'path'=>'topic/mod/pic/mod_pic.html.tpl' , 'className'=>'' ],
            '10401'=>[ 'path'=>'topic/mod/pic/mod_pic_album.html.tpl' , 'className'=>'pic-album' ],
            '10403'=>[ 'path'=>'topic/mod/pic/mod_pic_album_right.html.tpl' , 'className'=>'' ],
            '10500'=>[ 'path'=>'topic/mod/othertopics/mod_other_topics.html.tpl' , 'className'=>'' ],
            '10600'=>[ 'path'=>'topic/mod/information/mod_information_left.html.tpl' , 'className'=>'' ],
            '10601'=>[ 'path'=>'topic/mod/information/mod_information_right.html.tpl' , 'className'=>'' ],
            '10602'=>[ 'path'=>'topic/mod/intro/mod_intro.html.tpl' , 'className'=>'' ],
            '10603'=>[ 'path'=>'topic/mod/intro/mod_intro.html.tpl' , 'className'=>'' ],
			 '10604'=>[ 'path'=>'topic/mod/intro/mod_intro.html.tpl' , 'className'=>'' ],
            '10700'=>[ 'path'=>'topic/mod/album/mod_album.html.tpl' , 'className'=>'' ],
            '10701'=>[ 'path'=>'topic/mod/album/mod_album_detailed.html.tpl' , 'className'=>'' ],
            '10702'=>[ 'path'=>'topic/mod/album/mod_wall_album.html.tpl' , 'className'=>'' ],
            '10703'=>[ 'path'=>'topic/mod/album/mod_album_right.html.tpl' , 'className'=>'' ],
            '10800'=>[ 'path'=>'topic/mod/video/mod_video.html.tpl' , 'className'=>'' ],
            '10801'=>[ 'path'=>'topic/mod/video/mod_video_right.html.tpl' , 'className'=>'' ],
            '10900'=>[ 'path'=>'topic/mod/media/mod_media.html.tpl' , 'className'=>'' ],
            '10901'=>[ 'path'=>'topic/mod/media/mod_media.html.tpl' , 'className'=>'mod-media-notitle' ],
            '10902'=>[ 'path'=>'topic/mod/media/mod_media.html.tpl' , 'className'=>'mod-media-nopic' ],
            '11000'=>[ 'path'=>'topic/mod/message/mod_message.html.tpl' , 'className'=>''],
            '11100'=>[ 'path'=>'topic/mod/blank/mod_blank.html.tpl' , 'className'=>''],
            '11101'=>[ 'path'=>'topic/mod/blank/mod_blank.html.tpl' , 'className'=>''],
            '11102'=>[ 'path'=>'topic/mod/blank/mod_blank.html.tpl' , 'className'=>''],
            '11200'=>[ 'path'=>'topic/mod/floatLayer/mod_floatLayer.html.tpl' , 'className'=>''],
            '11300'=>[ 'path'=>'topic/mod/pic/mod_piclist.html.tpl' , 'className'=>'' ],
            '11301'=>[ 'path'=>'topic/mod/vote/mod_vote.html.tpl' , 'className'=>'' ]
		] scope='global'}
        
          
        
{**
		*
			'className'=>'' 必填  
		*
        
          '10004'=> '【top区域】 歌单 模块',               样式OK，缺数据
          '10100'=> '【top区域】 banner 模块',            样式OK，缺数据
          '10302'=> '【top区域】相关资讯 banner 模块',      样式OK，缺数据
          '10602'=> ' 活动信息说明 banner 模块',
          '11102'=> '【top区域】空白 模块'   
          
          
          '10000'=> '【left区域】 歌单 有歌曲信息 模块',		OK,
              
          '10002'=> '【left区域】 单曲 模块',
          '10003'=> '【left区域】 歌单 信息浮动 模块',
          '10005'=> '【left区域】 内嵌单曲播放器',
		      '10201'=> '【left区域】多个相关音乐人列表 模块',
          '10400'=> '【left区域】图片 模块',					OK
          '10401'=> '【left区域】图片 有（无）缩略图 模块',
          '10600'=> '【left区域】 活动信息说明 模块',    样式OK，缺数据
          '10700'=> '【left区域】专辑 模块',					OK
          '10701'=> '【left区域】专辑 只有两张专辑的 模块',					
          '10702'=> '【left区域】专辑 多张专辑且有浮层 模块',					
          '10800'=> '视频 模块'
          '11100'=> '【left区域】空白 模块'  
          
          '10001'=> '【right区域】 歌单 模块',		
          '10200'=> '【right区域】相关音乐人 模块',
          '10300'=> '【right区域】相关资讯 有资料 模块',
          '10301'=> '【right区域】相关资讯 无资料 模块',
          '10500'=> '【right区域】其他专题 模块',
          '10001'=> '【right区域】 歌单 模块',
          '10601'=> '【right区域】 活动信息说明 模块',
          '10703'=> '【right区域】专辑 右侧 模块',		
          '10801'=> '【right区域】 视频 图文 模块',
          '10900'=> '【right区域】 合作媒体 图文 模块',
          '10901'=> '【right区域】 合作媒体 无标题 模块',
          '10902'=> '【right区域】 合作媒体 无图片 模块',
          '11000'=> '留言 模块'   
          '11101'=> '右侧留言 模块'   
          '11200'=> '顶踩提交数据浮层'   
          '11300'=> '顶踩互动模块图片',
          '11301'=> '投票模块',
          
**}