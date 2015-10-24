define(function(require, exports, module){

	//初始化App模块
	window.app = require('modules/app/main');		//App模块
	//显示页面
	window.app.showPage('.page-index');

	//初始化各页面级模块
	require('modules/index/main').init();		//首页模块
	require('modules/teletext/main').init();	//图文模块
	//require('modules/link/main').init();		//链接模块
	//require('modules/video/main').init();		//视频模块
	//require('modules/map/main').init();		//地图模块
	//require('modules/form/main').init();		//表单模块

	//输出提示
	console.log('\n运行成功！');
	$('.app-footer').after($('input[data-weixin-callback]'));
});