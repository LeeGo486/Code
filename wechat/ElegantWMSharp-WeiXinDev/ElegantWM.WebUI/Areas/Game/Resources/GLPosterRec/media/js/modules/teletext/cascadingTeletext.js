define(function(require, exports, module){
	
	//�������ģ��
	var $ = require('lib/zepto/zepto'),
		$ = require('lib/zepto/touch'),
		$ = require('lib/zepto/data');

	//ע��CascadingTeletext���
	(function () {
		//����CascadingTeletext�������
		var CascadingTeletext = function ($item, options) {
			var theClass = this;
			//��������
			this.$target = $item.addClass('m-cascadingTeletext');
			this.$_currentItem = this.$target.find('li').first().addClass('z-current');

			//�趨�߶�
			$(window).on('resize', function (e) {
				theClass.$target.height(window.innerHeight);
			}).trigger('resize');

			//ɾ��û���ı���p���
			this.$target.find('.imgText').each(function (i, item) {
				if($.trim(item.innerText).length == 0){
					$(item).remove();
				}
			});

			//ע���¼�
			this.$target.on( $.isPC ? 'click' : 'swipeLeft swipeRight', function (e) {
				//�������ض���
				theClass.$_currentItem.addClass(e.type == 'swipeLeft' ? 'z-hideToLeft' : 'z-hideToRight');
			}).delegate('li', 'webkitAnimationEnd', function (e) {
				//�ŵ������
				theClass.$target.append(theClass.$_currentItem);
				//�л���ǰҳ��
				theClass.$_currentItem.removeClass('z-current z-hideToLeft z-hideToRight');
				theClass.$_currentItem = theClass.$target.find('li').first().addClass('z-current');
			});
		};

		//��ʾ�ķ���
		CascadingTeletext.show = function(first_argument) {
			this.$target.addClass('z-show');
		};

		//ע��cascadingTeletext����ӿ�
		$.fn.cascadingTeletext = function (options) {
			//��ȡָ��
			var command = 'init';
			if(arguments.length > 0){
				if (typeof arguments[0] == 'string'){
					command = arguments[0];
				}
			}

			//�ж�ָ��
			switch(command){
				//�����ʼ��
				case 'init':
					//ѭ������
					this.each(function (i, item) {
						var $item = $(item);
						//ʵ����CascadingTeletext����
						var pluginObj = new CascadingTeletext($item);
						//����ǰ������󱣴浽data��
						$item.data('plugin_cascadingTeletext', pluginObj);
					});
				break;
				//�����ʼ��
				case 'getPluginObject':
					//����ǰ������󱣴浽data��
					return $item.data('plugin_cascadingTeletext');
				break;
			}

			//���ֲ�����
			return this;
		};
	})();

	module.exports = $;
});