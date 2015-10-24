define(function(require, exports, module){
	
	//�������ģ��
	var $ = require('lib/zepto/zepto'),
		$ = require('./animationCloudBg'),
		$ = require('./meteorShower');

	//��ȡҳ��ģ��jQuery����
	var $indexPages = $('.page-index');

	//�����ṩ�ӿ�
	module.exports = {
		//��ʼ��
		init : function () {
			var $app = $('body');
			//��ʼ����ҳģ��
			$indexPages.each(function (i, item) {
				console.log('index init');
				//��ȡ��ǰpageҳ
				$page = $(item);

				//��ʼ������
				(function () {
					//������ʽ1
					var $animationBox = $page.find('.m-animationBox');
					var appBgClass = 'appBg1';
					if($animationBox.is('.m-animationCloudBg')){
						$animationBox.animationCloudBg();
						appBgClass = 'appBg1';
					}else if($animationBox.is('.m-meteorShower')){
						$animationBox.meteorShower({
							starCount : 30,		//���Ǹ���
							meteorCount : 26	//���Ǹ���
						});
						appBgClass = 'appBg2';
					}

					//���ݲ�ͬ����Ӧ�ò�ͬ�ı���
					$(window).on('load', function (e) {
						//�ų�����app
						var appID = parseInt($app.data('app-id'));
						var arr = [3468];
						if(arr.indexOf(appID) >= 0){
							$app.css('background-image', 'url(/media/images/wapp_'+ appID +'.jpg)');
						}else{
							//������ʽ
							$app.addClass(appBgClass);
						}
					});
				})();
				
				//ע�ἤ��ʱ���¼�
				$page.on('active', function (e) {
					console.log('index active');
				}).on('current', function (e) {
					console.log('index current');
				});
			});
		}
	}
});