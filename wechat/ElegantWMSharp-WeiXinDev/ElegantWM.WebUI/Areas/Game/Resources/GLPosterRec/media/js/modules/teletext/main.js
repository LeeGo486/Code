define(function(require, exports, module){
	
	//�������ģ��
	var $ = require('lib/zepto/zepto');
		$ = require('./cascadingTeletext');
		
	//��ȡҳ��ģ��jQuery����
	var $teletextPages = $('.page-teletext');

	//�����ṩ�ӿ�
	module.exports = {
		//��ʼ��
		init : function () {
			//��ʼ��ͼ��ģ��
			$teletextPages.each(function (i, item) {
				console.log('teletext init');
				//��ȡ��ǰpageҳ
				$page = $(item);
			
				//��ʼ�����ͼ�����
				var $cascadingTeletext = $page.find('.m-cascadingTeletext').cascadingTeletext();

				//ע�ἤ��ʱ���¼�
				$page.on('active', function (e) {
					console.log('teletext active');
					$cascadingTeletext.removeClass('z-viewArea').find('li.z-current').removeClass('z-current');
				}).on('current', function (e) {
					console.log('teletext current');
					$cascadingTeletext.addClass('z-viewArea');
					setTimeout(function () {
						$cascadingTeletext.find('li:first').addClass('z-current');
					}, 1800);
				});
			});
		}
	}
});