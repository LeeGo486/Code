define(function(require, exports, module){

	//��ʼ��Appģ��
	window.app = require('modules/app/main');		//Appģ��
	//��ʾҳ��
	window.app.showPage('.page-index');

	//��ʼ����ҳ�漶ģ��
	require('modules/index/main').init();		//��ҳģ��
	require('modules/teletext/main').init();	//ͼ��ģ��
	//require('modules/link/main').init();		//����ģ��
	//require('modules/video/main').init();		//��Ƶģ��
	//require('modules/map/main').init();		//��ͼģ��
	//require('modules/form/main').init();		//��ģ��

	//�����ʾ
	console.log('\n���гɹ���');
	$('.app-footer').after($('input[data-weixin-callback]'));
});