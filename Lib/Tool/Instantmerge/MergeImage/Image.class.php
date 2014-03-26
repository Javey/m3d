<?php
class Image {
	const UNIT_WIDTH = 12;
	const UNIT_HEIGHT = 12;

	private $type_support = array(
		'gif'=>'gif',
		'jpeg'=>'jpeg',
		'jpg'=>'jpeg',
		'png'=>'png',
	); 
	private $default_conf = array(
		"id" => null,
		"repeat" => NONE,
		"float" => NONE,
		"min-width" => 0,
		"min-height" => 0,
		"padding-left" => 0,
		"padding-top" => 0,
		"padding-right" => 0,
		"padding-bottom" => 0,
		"border-left" => 0,
		"border-right" => 0,
		"border-top" => 0,
		"border-bottom" => 0,
	);

	private $filename = null;
	private $config = null;

	private $ori_width = 0;
	private $ori_height = 0;
	private $x_fix = 0;
	private $y_fix = 0;

	//外部可访问属性
	private $x = 0;
	private $y = 0;
	private $width = 0;
	private $height = 0;
	private $top = 0;
	private $right = 0;
	private $bottom = 0;
	private $left = 0;

	private $readonly = array('width', 'height', 'top', 'right', 'bottom', 'left', 'filename', 'config');

	public function __construct($filename, $conf=null){
		if(file_exists($filename) && ($image_size = getimagesize($filename))){
			$this->filename = $filename;
			$this->ori_width = $image_size[0];
			$this->ori_height = $image_size[1];
			$this->config = array_merge($this->default_conf, ($conf==null) ? array() : $conf);
			$this->check_config();
			$this->resize();
		}else{
			mark("file \"$filename\" not found! But in merge config!", 'error');
		}
	}

	public function __destruct(){
		//imagedestroy($this->resource);
	}

	private function check_config(){
		switch($this->style('repeat')){
		case X:
			if($this->style('border-left') + $this->style('border-right') > $this->ori_width){
				trigger_error("border out of ctrl!",E_USER_ERROR);
			}
			if(in_array($this->style('float'), array(LEFT, RIGHT))){
				$this->config['float'] = NONE;
			}
			break;
		case Y:
			if($this->style('border-top') + $this->style('border-bottom') > $this->ori_height){
				trigger_error("border out of ctrl!",E_USER_ERROR);
			}
			if(in_array($this->style('float'), array(TOP, BOTTOM))){
				$this->config['float'] = NONE;
			}
			break;
		case NONE:
			break;
		default:
			trigger_error("unknow repeat value",E_USER_ERROR);
			break;
		}

		switch($this->style('float')){
		case TOP:
		case RIGHT:
		case BOTTOM:
		case LEFT:
		case NONE:
			break;
		default:
			trigger_error("unknow float value",E_USER_ERROR);
			break;
		}
	}

	//确定图标所占用宽高
	private function resize(){
		//最小宽高
		$o_width = $this->ori_width + $this->style('padding-left') + $this->style('padding-right');
		$o_height = $this->ori_height + $this->style('padding-top') + $this->style('padding-bottom');

		//优化后宽高
		$width = Image::UNIT_WIDTH * ceil($o_width/Image::UNIT_WIDTH);
		$height = Image::UNIT_HEIGHT * ceil($o_height/Image::UNIT_HEIGHT);

		$fx = $fy = 0;
		//在范围内居中布局修正
		//$fx = ($width - $o_width) >> 1;
		//$fy = ($height - $o_height) >> 1;

		//通过Float修正
		switch($this->style('float')){
		case TOP:
			$fy = 0;
			break;
		case RIGHT:
			$fx = $width - $o_width;
			break;
		case BOTTOM:
			$fy = $height - $o_height;
			break;
		case LEFT:
			$fx = 0;
			break;
		}

		switch($this->style('repeat')){
		case X:
			$width = UNKNOW;
			$fx = 0;
			break;
		case Y:
			$height = UNKNOW;
			$fy = 0;
			break;
		case NONE:
			break;
		}
		$this->width = $width;
		$this->height = $height;
		$this->x_fix = $fx;
		$this->y_fix = $fy;
	}

	public function style($name){
		return (isset($this->config[$name]) ? $this->config[$name] : null); 
	}

	public function location($x, $y){

		switch($this->style('float')){
		case TOP:
			$y = 0;
			break;
		case RIGHT:
			$x = ($this->width == UNKNOW) ? 0 : -$this->width;
			break;
		case BOTTOM:
			$y = ($this->height == UNKNOW) ? 0 : -$this->height;
			break;
		case LEFT:
			$x = 0;
			break;
		case NONE:
			break;
		default:
		}
		//echo("x:$x y:$y\n");
		$this->x = $x + $this->x_fix;
		$this->y = $y + $this->y_fix;
	}

	public function paint(&$image, $total_width, $total_height){
		$pathinfo = pathinfo($this->filename);
		$ext = $pathinfo['extension'];
		if(isset($this->type_support[$ext])){
			$createfn = 'imagecreatefrom' . $this->type_support[$ext];
			$resource = $createfn($this->filename);

			$this->x += ($this->x < 0) ? $total_width : 0;
			$this->y += ($this->y < 0) ? $total_height : 0;

			$this->top = $this->y + $this->style('padding-top');
			$this->right = $total_width - $this->x - $this->ori_width;
			$this->bottom = $total_height - $this->y - $this->ori_height;
			$this->left = $this->x + $this->style('padding-left');

			switch($this->style('repeat')){
			case X:
				$this->right = $this->style('padding-right');
				$this->left = $this->style('padding-left');
				$this->width = $total_width - $this->right - $this->left;

				//绘制左边图像
				if($this->style('border-left') > 0){
					imagecopy($image, $resource,
						$this->style('padding-left'),
						$this->y + $this->style('padding-top'),
						0, 0, $this->style('border-left'), $this->ori_height);
				}

				//绘制右边图像
				if($this->style('border-right') > 0){
					imagecopy($image, $resource,
						$total_width - $this->style('padding-right') - $this->style('border-right'),
						$this->y + $this->style('padding-top'),
						$this->ori_width - $this->style('border-right'), 0, $this->style('border-right'), $this->ori_height);
				}

				//重复绘制中间图像
				$start = $this->style('border-left') + $this->style('padding-left');
				$end = $total_width - $this->style('border-right') - $this->style('padding-right');

				$t_start = $this->style('border-left');
				$t_end = $this->ori_width - $this->style('border-right');
				$t_step = $t_end - $t_start;

				if($t_step > 0){
					for($t_x = $start; $t_x<$end; $t_x+=$t_step){
						$t_width = min($end - $t_x, $t_step);//此次复制的宽度
						imagecopy($image, $resource,
							$t_x, $this->y + $this->style('padding-top'),
							$t_start, 0, $t_width, $this->ori_height);
					}
				}
				break;

			case Y:
				$this->top = $this->style('padding-top');
				$this->bottom = $this->style('padding-bottom');
				$this->height = $total_height - $this->top - $this->bottom;

				//绘制上边图像
				if($this->style('border-top') > 0){
					imagecopy($image, $resource,
						$this->x +  $this->style('padding-left'),
						$this->style('padding-top'),
						0, 0, $this->ori_width, $this->style('border-top'));
				}

				//绘制下边图像
				if($this->style('border-bottom') > 0){
					imagecopy($image, $resource,
						$this->x +  $this->style('padding-left'),
						$total_height - $this->style('padding-bottom') - $this->style('border-bottom'),
						0, $this->ori_height - $this->style('border-bottom'), $this->ori_width, $this->style('border-bottom'));
				}

				//重复绘制中间图像
				$start = $this->style('border-top') + $this->style('padding-top');
				$end = $total_height - $this->style('border-bottom') - $this->style('padding-bottom');

				$t_start = $this->style('border-top');
				$t_end = $this->ori_height - $this->style('border-bottom');
				$t_step = $t_end - $t_start;

				if($t_step > 0){
					for($t_y = $start; $t_y<$end; $t_y+=$t_step){
						$t_height = min($end - $t_y, $t_step);//此次复制的高度
						imagecopy($image, $resource,
							$this->x + $this->style('padding-left'), $t_y,
							0, $t_start, $this->ori_width, $t_height);
					}
				}
				break;
			case NONE:
			default:
				imagecopy($image, $resource,
					$this->x + $this->style('padding-left'),
					$this->y + $this->style('padding-top'),
					0, 0, $this->ori_width, $this->ori_height);
			}
			imagedestroy($resource);
		}else{
			trigger_error("type \"$ext\" not support!", E_USER_ERROR);
			return false;
		}
		return true;
	}

	public function __get($name){
		if(in_array($name, $this->readonly)){
			return $this->$name;
		}else{
			trigger_error("field \"$name\" not fount" ,E_USER_WARNING);
		}
	}
}
