/**
 * 一些模块初始化相关的JS示例
 * @type {*}
 */

// 通过call绑定jQuery对象来成为选择器作用域
context = this;

// 初始化Slider
new ting.Slider($(".recommend-mv-cover"), $(".mv-focus"))

// 单曲播放和添加按钮
$(".music-icon-hook", context).musicIcon();
