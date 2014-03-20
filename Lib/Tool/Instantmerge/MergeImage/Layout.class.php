<?php
class Layout {

	private $list = null;//图片列表
	private $direction = null;//0:X方向 1:Y方向
	private $border = null;
	private $throgh = null;
	private $flag = 0;

	/**
	 * 纯属Debug工具
	 */
	function list_array($arr){
		if(is_array($arr)){

			$_ret = array();
			foreach($arr as $i){
				$_ret[] = Layout::list_array($i);
			}
			return '['.join($_ret,',').']';
		}
		if(is_object($arr)){
			if(get_class($arr)=='Image'){
				return 'Image:[src='.$arr->filename.']';
			}
			return 'Object:'.get_class($arr);
		}
		return $arr;
	}

	public function __construct($item_list, $direction = 0){
		$this->list = $item_list;
		$this->direction = $direction;
	}


	/**
	 * 检测冲突函数
	 *
	 */
	private function check_list(){
		$_ret = false;
		//占用Map
		$conflict_map = array(
			//repeat:_____________________-,___________x,___________y_____|float
			NONE   => array( NONE => 0x0000, X => 0x0205, Y => 0x010A ),//| -
			TOP    => array( NONE => 0x0008, X => 0x0285, Y => 0x010A ),//|top
			RIGHT  => array( NONE => 0x0004, X => 0x0205, Y => 0x014A ),//|right
			BOTTOM => array( NONE => 0x0002, X => 0x0225, Y => 0x010A ),//|bottom
			LEFT   => array( NONE => 0x0001, X => 0x0205, Y => 0x011A ),//|left
		);

		$flag = 0;//冲突标记 xx|xxxx|xxxx

		$this->border = array( //边框分类 
			//array(),array(),array(),array(),array()
			);
		$this->throgh = array( //repeat分类 左上 | 无 | 右下
			//array(),array(),array()
			);

		foreach($this->list as $img){
			$float = $img->style('float');
			$repeat = $img->style('repeat');

			//分类
			$_flg = $conflict_map[$float][$repeat];
			$this->border[$float][] = $img;
			if($img->style('repeat') != NONE) $this->throgh[] = $img;

			//trigger_error("\$flag:$flag \$flg:$flg\n");
			//trigger_error(($flag & 0xF0) & ($flg & 0xF0));

			if((($flag & 0xF0) & ($_flg & 0xF0))){//检测通栏占用冲突
				$_ret = false;
				//trigger_error("border error 2", E_USER_ERROR);
			}else{
				$flag |= $_flg;
				if(($flag>>4 & 0x0F) & ($flag & 0x0F)){//检测通栏和局部占用冲突
					$_ret = false;
					//trigger_error("border error 1", E_USER_ERROR);
					//die("border error 1");
				}elseif( ($flag & 0x0300) == 0x0300){//检测贯通型冲突
					$_ret = false;
					//trigger_error("throgh error", E_USER_ERROR);
					//die("throgh error");
				}else{
					$this->flag = $flag;
					$_ret = true;
				}
			}
		}
		return $_ret;
	}

	/**
	 * 得到两个矩形的位置关系
	 * X Y 宽 高
	 */
	function rect_mask($s, $d){
		//$rs:原有矩形   $rd:新用掉的矩形
		//当前空间与当前占用空间关系    上 右 下  左
		//                        00 00 00 00
		$mask = 0;
		//判断上边
		$mask |= ($d[1] > $s[1])             ? 0x40 : 0;
		$mask |= ($d[1] < $s[1]+$s[3])       ? 0x80 : 0;

		//判断右边
		$mask |= ($d[0]+$d[2] > $s[0])       ? 0x10 : 0;
		$mask |= ($d[0]+$d[2] < $s[0]+$s[2]) ? 0x20 : 0;

		//判断下边
		$mask |= ($d[1]+$d[3] > $s[1])       ? 0x04 : 0;
		$mask |= ($d[1]+$d[3] < $s[1]+$s[3]) ? 0x08 : 0;

		//判断左边
		$mask |= ($d[0] > $s[0])             ? 0x01 : 0;
		$mask |= ($d[0] < $s[0]+$s[2])       ? 0x02 : 0;

		return $mask;
	}

	/**
	 * 计算并切割空间
	 */
	function slice_space(&$space, $area){
		$block = array();
		for($idx = 0; $idx<count($space); $idx++){
			$sp = $space[$idx];
			//TODO 舍弃掉不可能相交的
			$mask = Layout::rect_mask($sp, $area);
			//判断是否相交
			if(
				(($mask & 0xC0)==0x40)||//上边在下
				(($mask & 0x30)==0x20)||//右边在左
				(($mask & 0x0C)==0x08)||//下边在上
				(($mask & 0x03)==0x01)  //左边在右
			){
				continue;
			}
			//$found = true;
			//切割
			if(($mask&0xC0)==0xC0){//上边在中间
				$block[] = array($sp[0], $sp[1], $sp[2], $area[1]-$sp[1]);
			}

			if(($mask&0x30)==0x30){//右边在中间
				$block[] = array($area[0]+$area[2], $sp[1], ($sp[0]+$sp[2])-($area[0]+$area[2]), $sp[3]);
			}

			if(($mask&0x0C)==0x0C){//下边在中间
                $block[] = array($sp[0], $area[1]+$area[3], $sp[2], ($sp[1]+$sp[3])-($area[1]+$area[3]));
			}

			if(($mask&0x03)==0x03){//左边在中间
				$block[] = array($sp[0], $sp[1], $area[0]-$sp[0], $sp[3]);
			}
			array_splice($space, $idx, 1);
			$idx--;
		}
		$space = array_merge($space, $block);
	}

	/**
	 * 合并空间
	 * 主要为了减少重复的块描述
	 * 舍弃不能放下最小块的描述
	 */
	//现在只能合并同宽或同高的
	//TODO 合并不同宽高的相邻矩形
	function merge_space(&$space, $imgs){
		for($idx = 0; $idx<count($space); $idx++){
			$sp = $space[$idx];
			for($idx2 = 0; $idx2<count($space); $idx2++){
				if($idx == $idx2) continue;//同一元素，不做操作
				$sp2 = $space[$idx2];
				//合并同宽或同高且接壤的空间
				//检测纵向
				$found = false;
				if($sp[0]==$sp2[0] && $sp[2]==$sp2[2] && $sp2[1]>=$sp[1] && $sp2[1]<=$sp[1]+$sp[3]){
					$space[$idx][3] = max($sp[3], $sp2[1]-$sp[1]+$sp2[3]);
					$found = true;
				}

				//检测横向
				if($sp[1]==$sp2[1] && $sp[3]==$sp2[3] && $sp2[0]>=$sp[0] && $sp2[0]<=$sp[0]+$sp[2]){
					$space[$idx][2] = max($sp[2], $sp2[0]-$sp[0]+$sp2[2]);
					$found = true;
				}

				if($found){
					array_splice($space, $idx2, 1);
					if($idx2 < $idx) $idx--;
					$idx2--;
				}
			}
		}

		//$imgs
		for($idx = 0; $idx<count($space); $idx++){
			$sp = $space[$idx];
			$found = false;
			foreach($imgs as $img){
				if(($sp[2] >= $img[0]) && ($sp[3] >= $img[1])){
					$found = true;
					break;
				}
			}
			if(!$found){
				array_splice($space, $idx, 1);
				$idx--;
			}
		}
	}

	/**
	 *
	 * 确定图片各个部分宽高
	 * 返回
	 * array(
	 *   TOP=>array('w'=>0, 'h'=>0),
	 *   RIGHT=>array('w'=>0, 'h'=>0),
	 *   BOTTOM=>array('w'=>0, 'h'=>0),
	 *   LEFT=>array('w'=>0, 'h'=>0),
	 *   NONE=>array('w'=>0, 'h'=>0, 'min_w'=>0, 'min_h'=>0),
	 * )
	 */
	private function get_size(&$size=null){
		$size = array(
			TOP=>array('w'=>0, 'h'=>0),
			RIGHT=>array('w'=>0, 'h'=>0),
			BOTTOM=>array('w'=>0, 'h'=>0),
			LEFT=>array('w'=>0, 'h'=>0),
			NONE=>array('w'=>0, 'h'=>0, 'min_w'=>0, 'min_h'=>0),
		);
		foreach($this->list as $img){
			$w = $img->width == UNKNOW ? $img->style('min-width') : $img->width;
			$h = $img->height == UNKNOW ? $img->style('min-height') : $img->height;

			//根据浮动属性确定各部分宽高
			switch($img->style('float')){
			case TOP:
				$size[TOP]['w'] += $w;
				$size[TOP]['h'] = max($size[TOP]['h'], $h);
				break;
			case RIGHT:
				$size[RIGHT]['w'] = max($size[RIGHT]['w'], $w);
				$size[RIGHT]['h'] += $h;
				break;
			case BOTTOM:
				$size[BOTTOM]['w'] += $w;
				$size[BOTTOM]['h'] = max($size[BOTTOM]['h'], $h);
				break;
			case LEFT:
				$size[LEFT]['w'] = max($size[LEFT]['w'], $w);
				$size[LEFT]['h'] += $h;
				break;
			case NONE:
			default:
				$size[NONE]['w'] += $w;
				$size[NONE]['h'] += $h;
				$size[NONE]['min_w'] = max($size[NONE]['min_w'], $w);
				$size[NONE]['min_h'] = max($size[NONE]['min_h'], $h);
				break;
			}

			//有repeat的况，则延伸方向两边都得增加
			switch($img->style('repeat')){
			case X:
				$size[LEFT]['h'] += $h;
				$size[RIGHT]['h'] += $h;
				$size[NONE]['min_h'] += $h;
				break;
			case Y:
				$size[TOP]['w'] += $w;
				$size[BOTTOM]['w'] += $w;
				$size[NONE]['min_w'] += $w;
				break;
			}
		}
		return $size;
	}

	/*
	将匿名函数至于外，因为开发机不支持匿名函数
	add by luoqin @20111101
	*/
	public static function forbar1($a, $b){
		$map = array(
			TOP => 3,
			RIGHT => 1,
			BOTTOM => 3,
			LEFT => 4,
			NONE => 2,
		);
		$vfa = $map[$a[2]->style('float')];
		$vfb = $map[$b[2]->style('float')];
		return ($vfa>$vfb) ? 1 : (($vfa<$vfb) ? -1 : ((($a[0]*$a[1]) > ($b[0]*$b[1])) ? 1 : -1));
	}
	
	public static function forbar2($a, $b){
		$map = array(
			TOP => 4,
			RIGHT => 3,
			BOTTOM => 1,
			LEFT => 3,
			NONE => 2,
		);
		$vfa = $map[$a[2]->style('float')];
		$vfb = $map[$b[2]->style('float')];
		return ($vfa>$vfb) ? 1 : (($vfa<$vfb) ? -1 : ((($a[0]*$a[1]) > ($b[0]*$b[1])) ? 1 : -1));
	}
	
	public static function forbar3($a, $b){return $a[0] > $b[0] ? 1 : -1;}
	
	public static function forbar4($a, $b){return $a[1] > $b[1] ? 1 : -1;}
	
	/**
	 * 布局
	 */  
	public function reflow(&$min_width=0, &$min_height=0){
		//检查是否有冲突，不能合并
		if($this->check_list()){
			//如果有横向平铺，则纵向延伸
			if($this->flag & 0x0200) $this->direction = 1;

			$list = array();//宽.高.图片
			//将图片数据保存
			foreach($this->list as $idx=>$img){
				$list[] = array($img->width, $img->height, $img);
			}

			//最大宽高度
			$width = 0;
			$height = 0;

			//当前X，Y位置标记
			$point_x = 0;
			$point_y = 0;
			//标志位，表示是否在放最后的浮动对象
			$clean_flg = false;

			$point_fix = 0;
			$size = $this->get_size();

			//计算最大宽高
			if($this->direction==0){//横向延伸
				//最坏情况全部横排
				$width = max($min_width, $size[TOP]['w'] + $size[RIGHT]['w'] 
					+ $size[BOTTOM]['w'] + $size[LEFT]['w'] + $size[NONE]['w']);
				//分为左中右，取最大值
				$height = max($min_height, $size[TOP]['h'], $size[RIGHT]['h'],
					$size[BOTTOM]['h'], $size[LEFT]['h'], $size[NONE]['min_h']);
			}else{//纵向延伸
				//最坏情况全部竖排
				$height = max($min_height, $size[TOP]['h'] + $size[RIGHT]['h'] 
					+ $size[BOTTOM]['h'] + $size[LEFT]['h'] + $size[NONE]['h']);
				//分为上中下，取最大值
				$width = max($min_width, $size[TOP]['w'], $size[RIGHT]['w'], 
					$size[BOTTOM]['w'], $size[LEFT]['w'], $size[NONE]['min_w']);
			}
			//初始化空间 X,Y,宽,高      0   1       2        3
			$space = array(array(0, 0, $width, $height));

			//将图标数据排序，先左上，再右下，先大后小
			if($this->direction==0){//横向延伸，顺序为 左 。。。右
				usort($list, "Layout::forbar1");
			}else{//纵向延伸，顺序为 上 。。。 下
				usort($list, "Layout::forbar2");
			}


			//直到摆放完成
			while(!empty($list)){
				//找到标记
				$found = false;

				//按照排序放入
				$cur = array_pop($list);

				($cur[0] == UNKNOW) ? $cur[0] = $width : 0;
				($cur[1] == UNKNOW) ? $cur[1] = $height : 0; 

				if($this->direction == 0){
					//横向排序中，如果发现第一个float right，则清理空间
					if(!$clean_flg && $cur[2]->style('float')==RIGHT){
						$space = array(array($point_x, 0, $width-$point_x, $height));
						$clean_flg = true;
					}else{
						//按照坐标排序,从左往右或从上往下
						usort($space, "Layout::forbar3"); 
					}
				}else{
					//纵向排序中，如果发现第一个float bottom，则清理空间
					if(!$clean_flg && $cur[2]->style('float')==BOTTOM){
						$space = array(array(0, $point_y, $width, $height-$point_y));
						$clean_flg = true;
					}else{
						//按照坐标排序,从左往右或从上往下
						usort($space, "Layout::forbar4");
					}
				}

				//查找合适空间
				foreach($space as $sp){
					//最终占用的空间
					//检查当前空间是否能容纳
					if($sp[2] >= $cur[0] && $sp[3]>=$cur[1]){
						$found = true;
						$used = array($sp[0], $sp[1], $cur[0], $cur[1]);//最终占用空间
						//是否推进X
						$add_x = true;
						//是否推进Y
						$add_y = true;
						//检查浮动特性
						switch($cur[2]->style('float')){
						case TOP://向上浮动，需要空间y坐标为0
							$found = $sp[1]==0;
							break;
						case RIGHT://向右浮动，需要空间右边为空（宽度为最大值）
							$found = $sp[2]==($width-$sp[0]);
							if($this->direction==0){//向右延伸则不推进X
								$add_x = false;
								$point_fix = max($point_fix, $used[2]);
							}else{
								$used[0] = $width - $cur[0];
							}
							break;
						case BOTTOM://向下浮动，需要空间下边为空（高度为最大值）
							$found = $sp[3]==($height-$sp[1]);
							if($this->direction!=0){//向下延伸则不推进Y
								$add_y = false;
								$point_fix = max($point_fix, $used[3]);
							}else{
								$used[1] = $height - $cur[1];
							}
							break;
						case LEFT://向左浮动，需要空间x坐标为0
							$found = $sp[0]==0;
							break;
						case NONE:
						default:
							break;
						}
						if(!$found) continue;

						//将宽高向前推进
						$add_x ? ($point_x = max($point_x, $used[0]+$used[2])) : 0;
						$add_y ? ($point_y = max($point_y, $used[1]+$used[3])) : 0;

						//放置图片
						$cur[2]->location($used[0], $used[1]);

						//计算被分割的空间
						Layout::slice_space($space, $used);
						//合并相邻空间
						Layout::merge_space($space, array_reverse($list));
						break;
					}
				}
				if(!$found){
					break;
				}
            }
            ($this->direction == 0) ? ($point_x+=$point_fix) : ($point_y+=$point_fix);
            $min_width = max($min_width, $point_x);
            $min_height = max($min_height, $point_y);
            return $found;
		}else{//冲突检测未通过
			return false;
		}
	}
}
